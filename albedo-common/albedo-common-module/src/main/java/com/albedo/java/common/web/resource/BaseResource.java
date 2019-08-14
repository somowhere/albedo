package com.albedo.java.common.web.resource;

import com.albedo.java.common.core.constant.CommonConstants;
import com.albedo.java.common.core.resource.GeneralResource;
import org.apache.poi.xssf.streaming.SXSSFWorkbook;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.net.URLEncoder;

/**
 * 基础控制器支持类 copyright 2014 albedo all right reserved author MrLi created on
 * 2014年10月15日 下午4:04:00
 */
public class BaseResource extends GeneralResource {

	/**
	 * 输出到客户端
	 *
	 * @param fileName 输出文件名
	 */
	public void write(HttpServletResponse response, SXSSFWorkbook wb, String fileName) {
		try {
			response.reset();
			response.setContentType("application/octet-stream; charset=utf-8");
			response.setHeader("Content-Disposition", "attachment; filename=" + URLEncoder.encode(fileName, CommonConstants.UTF8));
			wb.write(response.getOutputStream());
		} catch (IOException e) {
			e.printStackTrace();
			throw new RuntimeException(e);
		}
	}


}
