//package com.albedo.java.modules;
//
//import com.albedo.java.config.TestConfig;
//import com.albedo.java.modules.test.domain.SystemArea;
//import com.albedo.java.modules.test.repository.SystemAreaRepository;
//import com.albedo.java.modules.test.service.SystemAreaService;
//import com.albedo.java.util.Json;
//import com.albedo.java.util.PublicUtil;
//import com.google.common.collect.Lists;
//import org.junit.Before;
//import org.junit.Test;
//import org.junit.runner.RunWith;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.test.context.ContextConfiguration;
//import org.springframework.test.context.TestPropertySource;
//import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
//
//import java.io.*;
//import java.util.List;
//import java.util.regex.Matcher;
//import java.util.regex.Pattern;
//
//import static org.junit.Assert.*;
//
///**
// * Created by lijie on 2017/4/24.
// */
//@RunWith(SpringJUnit4ClassRunner.class)
//@ContextConfiguration(classes = TestConfig.class)
////@SpringApplicationConfiguration(classes = ExampleApplication.class)
//@TestPropertySource(locations="classpath:application.properties")
//public class SystemAreaServiceTest {
//
//    @Autowired
//    SystemAreaRepository systemAreaRepository;
//
//    @Autowired
//    SystemAreaService systemAreaService;
//    SystemArea parent = new SystemArea();
//    @Before
//    public void before(){
//
////        parent.setName("全国");
////        parent.setCode("0");
////        parent.setSort(0l);
////        parent.setParentIds("");
////        systemAreaRepository.save(parent);
//    }
//
//    public String get(int count,char c){
//        StringBuffer sb = new StringBuffer();
//        for (int i=0; i<count; i++){
//            sb.append(c);
//        }
//        return sb.toString();
//    }
//    public String replaceBlank(String str) {
//        String dest = "";
//        if (str!=null) {
//            Pattern p = Pattern.compile("\\s*|\t|\r|\n");
//            Matcher m = p.matcher(str);
//            dest = m.replaceAll("");
//        }
//        return dest;
//    }
//    public SystemArea convert(String data){
//        String[] strs = data.split("-");
//        SystemArea systemArea = new SystemArea();
//        systemArea.setCode(strs[0]);
//        systemArea.setName(strs[1]);
//        systemArea.setLevel(systemArea.getCode().endsWith("0000")? 1 :
//                systemArea.getCode().endsWith("00") ? 2 : 3);
//        String code = systemArea.getCode();
//        while (code.endsWith("00")){
//            code = code.substring(0, code.length()-2);
//        }
//        String temp = code.substring(0, code.length()-2);
//        String parentCode = systemArea.getLevel() == 1 ? "0" : temp+get(6-temp.length(), '0');
////        List<SystemArea> list = systemAreaRepository.findAll();
////
////        System.out.println(Json.toJsonString(list));
//        SystemArea area = systemAreaRepository.findOneByCode(parentCode);
////        for (SystemArea item : list){
////            if(item.getCode().equals(parentCode)){
////                area = item; break;
////            }
////        }
//        systemArea.setParentId(area.getId());
//        return  systemArea;
//    }
//
//    @Test
//    public void save() throws Exception {
//        List<String> datas  =  getData();
//        if(PublicUtil.isNotEmpty(datas)){
//            SystemArea systemArea = null;
//            long index=1;
//            for (String data : datas){
//                systemArea = convert(data);
////                systemArea.setCode();
//                systemAreaService.save(systemArea);
//                index++;
//            }
//
//            List<SystemArea> list = systemAreaRepository.findAll();
//            System.out.println(Json.toJsonString(list));
//        }
//    }
//
//    public List<String> getData(){
//        List<String> list = Lists.newArrayList();
//        try { // 防止文件建立或读取失败，用catch捕捉错误并打印，也可以throw
//
//            /* 读入TXT文件 */
//            String pathname = "F:\\albedo\\albedo-boot\\albedo-boot-data\\albedo-boot-data-mybatis\\albedo-boot-data-mybatis-repository\\src\\test\\resources\\sources"; // 绝对路径或相对路径都可以，这里是绝对路径，写入文件时演示相对路径
//            File filename = new File(pathname); // 要读取以上路径的input。txt文件
//            InputStreamReader reader = new InputStreamReader(
//                    new FileInputStream(filename)); // 建立一个输入流对象reader
//            BufferedReader br = new BufferedReader(reader); // 建立一个对象，它把文件内容转成计算机能读懂的语言
//            String line = br.readLine();
//            while (line != null) {
//                list.add(line);
//                line = br.readLine(); // 一次读入一行数据
//            }
//
////            /* 写入Txt文件 */
////            File writename = new File(".\\result\\en\\output.txt"); // 相对路径，如果没有则要建立一个新的output。txt文件
////            writename.createNewFile(); // 创建新文件
////            BufferedWriter out = new BufferedWriter(new FileWriter(writename));
////            out.write("我会写入文件啦\r\n"); // \r\n即为换行
////            out.flush(); // 把缓存区内容压入文件
////            out.close(); // 最后记得关闭文件
//
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//        return list;
//    }
//
//
//}