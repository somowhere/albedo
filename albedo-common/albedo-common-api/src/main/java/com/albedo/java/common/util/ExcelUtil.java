package com.albedo.java.common.util;

import cn.hutool.core.convert.Convert;
import com.albedo.java.common.core.annotation.ExcelField;
import com.albedo.java.common.core.annotation.ExcelField.ColumnType;
import com.albedo.java.common.core.annotation.ExcelField.Type;
import com.albedo.java.common.core.annotation.ExcelFields;
import com.albedo.java.common.core.config.ApplicationConfig;
import com.albedo.java.common.core.exception.RuntimeMsgException;
import com.albedo.java.common.core.util.ClassUtil;
import com.albedo.java.common.core.util.ObjectUtil;
import com.albedo.java.common.core.util.R;
import com.albedo.java.common.core.util.StringUtil;
import com.albedo.java.modules.sys.domain.Dict;
import com.albedo.java.modules.sys.util.DictUtil;
import com.google.common.collect.Maps;
import org.apache.poi.hssf.usermodel.HSSFDateUtil;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.ss.util.CellRangeAddressList;
import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.apache.poi.xssf.usermodel.XSSFDataValidation;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.*;
import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.math.BigDecimal;
import java.text.DecimalFormat;
import java.util.*;

/**
 * Excel相关处理
 *
 * @author somewhere
 */
public class ExcelUtil<T> {
	/**
	 * Excel sheet最大行数，默认65536
	 */
	public static final int sheetSize = 65536;
	private static final Logger log = LoggerFactory.getLogger(ExcelUtil.class);
	private static Map<String, Object> dataDictMap = Maps.newHashMap();
	/**
	 * 实体对象
	 */
	public Class<T> clazz;
	/**
	 * 工作表名称
	 */
	private String sheetName;
	/**
	 * 导出类型（EXPORT:导出数据；IMPORT：导入模板）
	 */
	private Type type;
	/**
	 * 工作薄对象
	 */
	private Workbook wb;
	/**
	 * 工作表对象
	 */
	private Sheet sheet;
	/**
	 * 样式列表
	 */
	private Map<String, CellStyle> styles;
	/**
	 * 导入导出数据列表
	 */
	private List<T> list;
	/**
	 * 注解列表
	 */
	private List<Object[]> fields;

	public ExcelUtil(Class<T> clazz) {
		this.clazz = clazz;
		dataDictMap.clear();
	}

	/**
	 * 解析导出值 0=男,1=女,2=未知
	 *
	 * @param propertyValue 参数值
	 * @param converterExp  翻译注解
	 * @return 解析后值
	 * @throws Exception
	 */
	public static String convertByExp(String propertyValue, String converterExp) throws Exception {
		try {
			String[] convertSource = converterExp.split(",");
			for (String item : convertSource) {
				String[] itemArray = item.split("=");
				if (itemArray[0].equals(propertyValue)) {
					return itemArray[1];
				}
			}
		} catch (Exception e) {
			throw e;
		}
		return propertyValue;
	}

	/**
	 * 反向解析值 男=0,女=1,未知=2
	 *
	 * @param propertyValue 参数值
	 * @param converterExp  翻译注解
	 * @return 解析后值
	 * @throws Exception
	 */
	public static String reverseByExp(String propertyValue, String converterExp) throws Exception {
		try {
			String[] convertSource = converterExp.split(",");
			for (String item : convertSource) {
				String[] itemArray = item.split("=");
				if (itemArray[1].equals(propertyValue)) {
					return itemArray[0];
				}
			}
		} catch (Exception e) {
			throw e;
		}
		return propertyValue;
	}

	public static String getDataDictValue(String dictType, Object value) {
		List<Dict> listTemp = (List<Dict>) dataDictMap.get(dictType);
		if (listTemp == null) {
			listTemp = DictUtil.getDictListByParentCode(dictType);
			dataDictMap.put(dictType, listTemp);
		}
		if (ObjectUtil.isNotEmpty(listTemp)) {
			for (Dict item : listTemp) {
				if (String.valueOf(value).equals(item.getVal())) {
					return item.getName();
				}
			}
		}

		return null;
	}

	public void init(List<T> list, String sheetName, Type type) {
		if (list == null) {
			list = new ArrayList<T>();
		}
		this.list = list;
		this.sheetName = sheetName;
		this.type = type;
		createExcelField();
		createWorkbook();
	}

	/**
	 * 对excel表单默认第一个索引名转换成list
	 *
	 * @param is 输入流
	 * @return 转换后集合
	 */
	public List<T> importExcel(InputStream is) throws Exception {
		return importExcel(StringUtil.EMPTY, is);
	}

	/**
	 * 对excel表单指定表格索引名转换成list
	 *
	 * @param sheetName 表格索引名
	 * @param is        输入流
	 * @return 转换后集合
	 */
	public List<T> importExcel(String sheetName, InputStream is) throws Exception {
		this.type = Type.IMPORT;
		this.wb = WorkbookFactory.create(is);
		List<T> list = new ArrayList<T>();
		Sheet sheet = null;
		if (StringUtil.isNotEmpty(sheetName)) {
			// 如果指定sheet名,则取指定sheet中的内容.
			sheet = wb.getSheet(sheetName);
		} else {
			// 如果传入的sheet名不存在则默认指向第1个sheet.
			sheet = wb.getSheetAt(0);
		}

		if (sheet == null) {
			throw new IOException("文件sheet不存在");
		}

		int rows = sheet.getPhysicalNumberOfRows();

		if (rows > 0) {
			// 定义一个map用于存放excel列的序号和field.
			Map<String, Integer> cellMap = new HashMap<String, Integer>();
			// 获取表头
			Row heard = sheet.getRow(0);
			for (int i = 0; i < heard.getPhysicalNumberOfCells(); i++) {
				Cell cell = heard.getCell(i);
				if (cell != null) {
					String value = this.getCellValue(heard, i).toString();
					cellMap.put(value, i);
				} else {
					cellMap.put(null, i);
				}
			}
			// 有数据时才处理 得到类的所有field.
			Field[] allFields = clazz.getDeclaredFields();
			// 定义一个map用于存放列的序号和field.
			Map<Integer, Field> fieldsMap = new HashMap<Integer, Field>();
			for (int col = 0; col < allFields.length; col++) {
				Field field = allFields[col];
				ExcelField attr = field.getAnnotation(ExcelField.class);
				if (attr != null && (attr.type() == Type.ALL || attr.type() == type)) {
					// 设置类的私有字段属性可访问.
					field.setAccessible(true);
					Integer column = cellMap.get(attr.title());
					fieldsMap.put(column, field);
				}
			}
			for (int i = 1; i < rows; i++) {
				// 从第2行开始取数据,默认第一行是表头.
				Row row = sheet.getRow(i);
				T entity = null;
				for (Map.Entry<Integer, Field> entry : fieldsMap.entrySet()) {
					Object val = this.getCellValue(row, entry.getKey());

					// 如果不存在实例则新建.
					entity = (entity == null ? clazz.newInstance() : entity);
					// 从map中得到对应列的field.
					Field field = fieldsMap.get(entry.getKey());
					// 取得类型,并根据对象类型设置值.
					Class<?> fieldType = field.getType();
					if (String.class == fieldType) {
						String s = Convert.toStr(val);
						if (StringUtil.endWith(s, ".0")) {
							val = StringUtil.subBefore(s, ".0", true);
						} else {
							val = Convert.toStr(val);
						}
					} else if ((Integer.TYPE == fieldType) || (Integer.class == fieldType)) {
						val = Convert.toInt(val);
					} else if ((Long.TYPE == fieldType) || (Long.class == fieldType)) {
						val = Convert.toLong(val);
					} else if ((Double.TYPE == fieldType) || (Double.class == fieldType)) {
						val = Convert.toDouble(val);
					} else if ((Float.TYPE == fieldType) || (Float.class == fieldType)) {
						val = Convert.toFloat(val);
					} else if (BigDecimal.class == fieldType) {
						val = Convert.toBigDecimal(val);
					} else if (Date.class == fieldType) {
						if (val instanceof String) {
							val = com.albedo.java.common.core.util.DateUtil.parse((String) val);
						} else if (val instanceof Double) {
							val = DateUtil.getJavaDate((Double) val);
						}
					}
					if (ObjectUtil.isNotNull(fieldType)) {
						ExcelField attr = field.getAnnotation(ExcelField.class);
						String propertyName = field.getName();
						String readConverterExp = attr.readConverterExp();
						String dictType = attr.dictType();
						if (StringUtil.isNotEmpty(attr.targetAttr())) {
							propertyName = field.getName() + "." + attr.targetAttr();
						} else if (StringUtil.isNotEmpty(dictType)) {

							val = getDataDictValue(dictType, val);

						} else if (StringUtil.isNotEmpty(readConverterExp)) {
							val = reverseByExp(String.valueOf(val), readConverterExp);
						}
						ClassUtil.invokeSetter(entity, propertyName, val);
					}
				}
				list.add(entity);
			}
		}
		return list;
	}

	/**
	 * 对list数据源将其里面的数据导入到excel表单
	 *
	 * @param list      导出数据集合
	 * @param sheetName 工作表的名称
	 * @return 结果
	 */
	public R exportExcel(List<T> list, String sheetName) {
		this.init(list, sheetName, Type.EXPORT);
		return exportExcel();
	}

	/**
	 * 对list数据源将其里面的数据导入到excel表单
	 *
	 * @param sheetName 工作表的名称
	 * @return 结果
	 */
	public R importTemplateExcel(String sheetName) {
		this.init(null, sheetName, Type.IMPORT);
		return exportExcel();
	}

	/**
	 * 对list数据源将其里面的数据导入到excel表单
	 *
	 * @return 结果
	 */
	public R exportExcel() {
		OutputStream out = null;
		try {
			// 取出一共有多少个sheet.
			double sheetNo = Math.ceil(list.size() / sheetSize);
			for (int index = 0; index <= sheetNo; index++) {
				createSheet(sheetNo, index);

				// 产生一行
				Row row = sheet.createRow(0);
				int column = 0;
				// 写入各个字段的列头名称
				for (Object[] os : fields) {
					ExcelField excelField = (ExcelField) os[1];
					this.createCell(excelField, row, column++);
				}
				if (Type.EXPORT.equals(type)) {
					fillExcelData(index, row);
				}
			}
			String filename = encodingFilename(sheetName);
			out = new FileOutputStream(getAbsoluteFile(filename));
			wb.write(out);
			return R.buildOkData(filename);
		} catch (Exception e) {
			log.error("导出Excel异常{}", e.getMessage());
			throw new RuntimeMsgException("导出Excel失败，请联系网站管理员！");
		} finally {
			if (wb != null) {
				try {
					wb.close();
				} catch (IOException e1) {
					e1.printStackTrace();
				}
			}
			if (out != null) {
				try {
					out.close();
				} catch (IOException e1) {
					e1.printStackTrace();
				}
			}
		}
	}

	/**
	 * 填充excel数据
	 *
	 * @param index 序号
	 * @param row   单元格行
	 */
	public void fillExcelData(int index, Row row) {
		int startNo = index * sheetSize;
		int endNo = Math.min(startNo + sheetSize, list.size());
		for (int i = startNo; i < endNo; i++) {
			row = sheet.createRow(i + 1 - startNo);
			// 得到导出对象.
			T vo = (T) list.get(i);
			int column = 0;
			for (Object[] os : fields) {
				Field field = (Field) os[0];
				ExcelField excelField = (ExcelField) os[1];
				// 设置实体类私有属性可访问
				field.setAccessible(true);
				this.addCell(excelField, row, vo, field, column++);
			}
		}
	}

	/**
	 * 创建表格样式
	 *
	 * @param wb 工作薄对象
	 * @return 样式列表
	 */
	private Map<String, CellStyle> createStyles(Workbook wb) {
		// 写入各条记录,每条记录对应excel表中的一行
		Map<String, CellStyle> styles = new HashMap<String, CellStyle>();
		CellStyle style = wb.createCellStyle();
		style.setAlignment(HorizontalAlignment.CENTER);
		style.setVerticalAlignment(VerticalAlignment.CENTER);
		style.setBorderRight(BorderStyle.THIN);
		style.setRightBorderColor(IndexedColors.GREY_50_PERCENT.getIndex());
		style.setBorderLeft(BorderStyle.THIN);
		style.setLeftBorderColor(IndexedColors.GREY_50_PERCENT.getIndex());
		style.setBorderTop(BorderStyle.THIN);
		style.setTopBorderColor(IndexedColors.GREY_50_PERCENT.getIndex());
		style.setBorderBottom(BorderStyle.THIN);
		style.setBottomBorderColor(IndexedColors.GREY_50_PERCENT.getIndex());
		Font dataFont = wb.createFont();
		dataFont.setFontName("Arial");
		dataFont.setFontHeightInPoints((short) 10);
		style.setFont(dataFont);
		styles.put("data", style);

		style = wb.createCellStyle();
		style.cloneStyleFrom(styles.get("data"));
		style.setAlignment(HorizontalAlignment.CENTER);
		style.setVerticalAlignment(VerticalAlignment.CENTER);
		style.setFillForegroundColor(IndexedColors.GREY_50_PERCENT.getIndex());
		style.setFillPattern(FillPatternType.SOLID_FOREGROUND);
		Font headerFont = wb.createFont();
		headerFont.setFontName("Arial");
		headerFont.setFontHeightInPoints((short) 10);
		headerFont.setBold(true);
		headerFont.setColor(IndexedColors.WHITE.getIndex());
		style.setFont(headerFont);
		styles.put("header", style);

		return styles;
	}

	/**
	 * 创建单元格
	 */
	public Cell createCell(ExcelField attr, Row row, int column) {
		// 创建列
		Cell cell = row.createCell(column);
		// 写入列信息
		cell.setCellValue(attr.title());
		setDataValidation(attr, row, column);
		cell.setCellStyle(styles.get("header"));
		return cell;
	}

	/**
	 * 设置单元格信息
	 *
	 * @param value 单元格值
	 * @param attr  注解相关
	 * @param cell  单元格信息
	 */
	public void setCellVo(Object value, ExcelField attr, Cell cell) {
		if (ColumnType.STRING == attr.cellType()) {
			cell.setCellType(CellType.NUMERIC);
			cell.setCellValue(ObjectUtil.isNull(value) ? attr.defaultValue() : value + attr.suffix());
		} else if (ColumnType.NUMERIC == attr.cellType()) {
			cell.setCellType(CellType.NUMERIC);
			cell.setCellValue(Integer.parseInt(value + ""));
		}
	}

	/**
	 * 创建表格样式
	 */
	public void setDataValidation(ExcelField attr, Row row, int column) {
		if (attr.title().indexOf("注：") >= 0) {
			sheet.setColumnWidth(column, 6000);
		} else {
			// 设置列宽
			sheet.setColumnWidth(column, (int) ((attr.width() + 0.72) * 256));
			row.setHeight((short) (attr.height() * 20));
		}
		// 如果设置了提示信息则鼠标放上去提示.
		if (StringUtil.isNotEmpty(attr.prompt())) {
			// 这里默认设了2-101列提示.
			setXSSFPrompt(sheet, "", attr.prompt(), 1, 100, column, column);
		}
		// 如果设置了combo属性则本列只能选择不能输入
		if (attr.combo().length > 0) {
			// 这里默认设了2-101列只能选择不能输入.
			setXSSFValidation(sheet, attr.combo(), 1, 100, column, column);
		}
	}

	/**
	 * 添加单元格
	 */
	public Cell addCell(ExcelField attr, Row row, T vo, Field field, int column) {
		Cell cell = null;
		try {
			// 设置行高
			row.setHeight((short) (attr.height() * 20));
			// 根据Excel中设置情况决定是否导出,有些情况需要保持为空,希望用户填写这一列.
			if (attr.isExport()) {
				// 创建cell
				cell = row.createCell(column);
				cell.setCellStyle(styles.get("data"));

				// 用于读取对象中的属性
				Object value = getTargetValue(vo, field, attr);
				String dateFormat = attr.dateFormat();
				String readConverterExp = attr.readConverterExp();
				String dictType = attr.dictType();
				if (StringUtil.isNotEmpty(dateFormat) && ObjectUtil.isNotNull(value)) {
					cell.setCellValue(com.albedo.java.common.core.util.DateUtil.format((Date) value, dateFormat));
				} else if (StringUtil.isNotEmpty(dictType) && ObjectUtil.isNotNull(value)) {
					cell.setCellValue(getDataDictValue(dictType, value));
				} else if (StringUtil.isNotEmpty(readConverterExp) && ObjectUtil.isNotNull(value)) {
					cell.setCellValue(convertByExp(String.valueOf(value), readConverterExp));
				} else {
					// 设置列类型
					setCellVo(value, attr, cell);
				}
			}
		} catch (Exception e) {
			log.error("导出Excel失败{}", e);
		}
		return cell;
	}

	/**
	 * 设置 POI XSSFSheet 单元格提示
	 *
	 * @param sheet         表单
	 * @param promptTitle   提示标题
	 * @param promptContent 提示内容
	 * @param firstRow      开始行
	 * @param endRow        结束行
	 * @param firstCol      开始列
	 * @param endCol        结束列
	 */
	public void setXSSFPrompt(Sheet sheet, String promptTitle, String promptContent, int firstRow, int endRow,
							  int firstCol, int endCol) {
		DataValidationHelper helper = sheet.getDataValidationHelper();
		DataValidationConstraint constraint = helper.createCustomConstraint("DD1");
		CellRangeAddressList regions = new CellRangeAddressList(firstRow, endRow, firstCol, endCol);
		DataValidation dataValidation = helper.createValidation(constraint, regions);
		dataValidation.createPromptBox(promptTitle, promptContent);
		dataValidation.setShowPromptBox(true);
		sheet.addValidationData(dataValidation);
	}

	/**
	 * 设置某些列的值只能输入预制的数据,显示下拉框.
	 *
	 * @param sheet    要设置的sheet.
	 * @param textlist 下拉框显示的内容
	 * @param firstRow 开始行
	 * @param endRow   结束行
	 * @param firstCol 开始列
	 * @param endCol   结束列
	 * @return 设置好的sheet.
	 */
	public void setXSSFValidation(Sheet sheet, String[] textlist, int firstRow, int endRow, int firstCol, int endCol) {
		DataValidationHelper helper = sheet.getDataValidationHelper();
		// 加载下拉列表内容
		DataValidationConstraint constraint = helper.createExplicitListConstraint(textlist);
		// 设置数据有效性加载在哪个单元格上,四个参数分别是：起始行、终止行、起始列、终止列
		CellRangeAddressList regions = new CellRangeAddressList(firstRow, endRow, firstCol, endCol);
		// 数据有效性对象
		DataValidation dataValidation = helper.createValidation(constraint, regions);
		// 处理Excel兼容性问题
		if (dataValidation instanceof XSSFDataValidation) {
			dataValidation.setSuppressDropDownArrow(true);
			dataValidation.setShowErrorBox(true);
		} else {
			dataValidation.setSuppressDropDownArrow(false);
		}

		sheet.addValidationData(dataValidation);
	}

	/**
	 * 编码文件名
	 */
	public String encodingFilename(String filename) {
		filename = UUID.randomUUID().toString() + "_" + filename + ".xlsx";
		return filename;
	}

	/**
	 * 获取下载路径
	 *
	 * @param filename 文件名称
	 */
	public String getAbsoluteFile(String filename) {
		String downloadPath = ApplicationConfig.getDownloadPath() + filename;
		File desc = new File(downloadPath);
		if (!desc.getParentFile().exists()) {
			desc.getParentFile().mkdirs();
		}
		return downloadPath;
	}

	/**
	 * 获取bean中的属性值
	 *
	 * @param vo         实体对象
	 * @param field      字段
	 * @param excelField 注解
	 * @return 最终的属性值
	 * @throws Exception
	 */
	private Object getTargetValue(T vo, Field field, ExcelField excelField) throws Exception {
		Object o = field.get(vo);
		if (StringUtil.isNotEmpty(excelField.targetAttr())) {
			String target = excelField.targetAttr();
			if (target.indexOf(".") > -1) {
				String[] targets = target.split("[.]");
				for (String name : targets) {
					o = getValue(o, name);
				}
			} else {
				o = getValue(o, target);
			}
		}
		return o;
	}

	/**
	 * 以类的属性的get方法方法形式获取值
	 *
	 * @param o
	 * @param name
	 * @return value
	 * @throws Exception
	 */
	private Object getValue(Object o, String name) throws Exception {
		if (StringUtil.isNotEmpty(name)) {
			Class<?> clazz = o.getClass();
			String methodName = "get" + name.substring(0, 1).toUpperCase() + name.substring(1);
			Method method = clazz.getMethod(methodName);
			o = method.invoke(o);
		}
		return o;
	}

	/**
	 * 得到所有定义字段
	 */
	private void createExcelField() {
		this.fields = new ArrayList<Object[]>();
		List<Field> tempFields = new ArrayList<>();
		tempFields.addAll(Arrays.asList(clazz.getSuperclass().getDeclaredFields()));
		tempFields.addAll(Arrays.asList(clazz.getDeclaredFields()));
		for (Field field : tempFields) {
			// 单注解
			if (field.isAnnotationPresent(ExcelField.class)) {
				putToField(field, field.getAnnotation(ExcelField.class));
			}

			// 多注解
			if (field.isAnnotationPresent(ExcelFields.class)) {
				ExcelFields attrs = field.getAnnotation(ExcelFields.class);
				ExcelField[] excelFields = attrs.value();
				for (ExcelField excelField : excelFields) {
					putToField(field, excelField);
				}
			}
		}
	}

	/**
	 * 放到字段集合中
	 */
	private void putToField(Field field, ExcelField attr) {
		if (attr != null && (attr.type() == Type.ALL || attr.type() == type)) {
			this.fields.add(new Object[]{field, attr});
		}
	}

	/**
	 * 创建一个工作簿
	 */
	public void createWorkbook() {
		this.wb = new SXSSFWorkbook(500);
	}

	/**
	 * 创建工作表
	 *
	 * @param sheetNo sheet数量
	 * @param index   序号
	 */
	public void createSheet(double sheetNo, int index) {
		this.sheet = wb.createSheet();
		this.styles = createStyles(wb);
		// 设置工作表的名称.
		if (sheetNo == 0) {
			wb.setSheetName(index, sheetName);
		} else {
			wb.setSheetName(index, sheetName + index);
		}
	}

	/**
	 * 获取单元格值
	 *
	 * @param row    获取的行
	 * @param column 获取单元格列号
	 * @return 单元格值
	 */
	public Object getCellValue(Row row, int column) {
		if (row == null) {
			return row;
		}
		Object val = "";
		try {
			Cell cell = row.getCell(column);
			if (cell != null) {
				if (cell.getCellTypeEnum() == CellType.NUMERIC || cell.getCellTypeEnum() == CellType.FORMULA) {
					val = cell.getNumericCellValue();
					if (HSSFDateUtil.isCellDateFormatted(cell)) {
						val = DateUtil.getJavaDate((Double) val); // POI Excel 日期格式转换
					} else {
						if ((Double) val % 1 > 0) {
							val = new DecimalFormat("0.00").format(val);
						} else {
							val = new DecimalFormat("0").format(val);
						}
					}
				} else if (cell.getCellTypeEnum() == CellType.STRING) {
					val = cell.getStringCellValue();
				} else if (cell.getCellTypeEnum() == CellType.BOOLEAN) {
					val = cell.getBooleanCellValue();
				} else if (cell.getCellTypeEnum() == CellType.ERROR) {
					val = cell.getErrorCellValue();
				}

			}
		} catch (Exception e) {
			return val;
		}
		return val;
	}
}
