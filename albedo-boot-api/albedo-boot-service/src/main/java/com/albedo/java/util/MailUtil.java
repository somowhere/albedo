package com.albedo.java.util;

import com.albedo.java.modules.gen.util.GenUtil;
import com.albedo.java.util.mapper.JaxbMapper;
import org.apache.commons.io.Charsets;
import org.apache.commons.io.IOUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.core.io.support.PathMatchingResourcePatternResolver;

import java.io.IOException;

public class MailUtil {

    private static Logger logger = LoggerFactory.getLogger(MailUtil.class);

    public static String fileToString(String fileName) {
        String pathName = "classpath*:/mails/" + fileName;
        logger.debug("file to object: {} ", pathName);

        PathMatchingResourcePatternResolver resourceLoader = new PathMatchingResourcePatternResolver();

        String content = null;
        try {
            content = IOUtils.toString(resourceLoader.getResources(pathName)[0].getInputStream(), Charsets.toCharset("utf-8"));
        } catch (IOException e) {
            logger.warn("error convert: {}", e.getMessage());
        }
        return content;
    }

}
