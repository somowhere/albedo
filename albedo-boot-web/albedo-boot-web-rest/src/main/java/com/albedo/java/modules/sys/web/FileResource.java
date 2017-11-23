package com.albedo.java.modules.sys.web;

import com.albedo.java.common.security.SecurityUtil;
import com.albedo.java.web.rest.ResultBuilder;
import com.albedo.java.web.rest.base.BaseResource;
import org.apache.commons.io.FileUtils;
import org.apache.commons.io.FilenameUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import javax.activation.MimetypesFileTypeMap;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Calendar;
import java.util.LinkedList;
import java.util.List;
import java.util.UUID;

/**
 * @author somewhere
 */
@Controller
@RequestMapping(value = "${albedo.adminPath}/file")
public class FileResource extends BaseResource {


    /**
     * @param files
     * @return
     */
    @RequestMapping(value = "/upload", method = RequestMethod.POST)
    public ResponseEntity upload(@RequestParam("uploadFile") MultipartFile[] files) {
        List<String> fileList = new LinkedList<>();
        String directory = SecurityUtil.albedoProperties.getStaticFileDirectory();
        String dir = mkdirs(directory);

        for (int i = 0; i < files.length; i++) {
            String fileName = new StringBuilder().append(dir).append(UUID.randomUUID().toString().replaceAll("-", "")).append(".")
                    .append(FilenameUtils.getExtension(files[i].getOriginalFilename())).toString();
            try {
                FileCopyUtils.copy(files[i].getBytes(), new FileOutputStream(fileName));
            } catch (IOException e) {
                e.printStackTrace();
            }

            fileList.add(fileName.replaceAll(directory, ""));
        }
        return ResultBuilder.buildOk(StringUtils.join(fileList, ","), "上传成功");

    }

    private String mkdirs(String directory) {
        Calendar now = Calendar.getInstance();
        int year = now.get(Calendar.YEAR);
        int month = now.get(Calendar.MONTH) + 1;
        int day = now.get(Calendar.DAY_OF_MONTH);
        String dir = new StringBuilder().append(directory).append("/").append(year).append("/").append(month).append("/").append(day).append("/").toString();
        File file = new File(dir);
        if (!file.exists()) {
            file.mkdirs();
        }
        return dir;
    }

    /**
     * @param response
     * @param year
     * @param month
     * @param day
     * @param fileName
     */
    @RequestMapping(value = "/get/{year}/{month}/{day}/{fileName:.+}", method = RequestMethod.GET)
    public void get(HttpServletResponse response, @PathVariable String year, @PathVariable String month, @PathVariable String day, @PathVariable String fileName) {
        try {
            String directory = SecurityUtil.albedoProperties.getStaticFileDirectory();
            String dir = new StringBuilder().append(directory).append("/").append(year).append("/").append(month).append("/").append(day).toString();
            File file = FileUtils.getFile(dir, fileName);
            byte[] bytes = FileCopyUtils.copyToByteArray(file);
            String contentType = new MimetypesFileTypeMap().getContentType(file);
            response.setContentType(contentType);
            response.setHeader("Content-disposition", "attachment; filename=\"" + file.getName() + "\"");
            FileCopyUtils.copy(bytes, response.getOutputStream());
        } catch (IOException e) {
            logger.error(e.getMessage());
        }
    }
}
