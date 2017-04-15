/*
 *
 *   Copyright 2016 the original author or authors.
 *
 *   Licensed under the Apache License, Version 2.0 (the "License");
 *   you may not use this file except in compliance with the License.
 *   You may obtain a copy of the License at
 *
 *        http://www.apache.org/licenses/LICENSE-2.0
 *
 *   Unless required by applicable law or agreed to in writing, software
 *   distributed under the License is distributed on an "AS IS" BASIS,
 *   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *   See the License for the specific language governing permissions and
 *   limitations under the License.
 *
 */

package org.springframework.data.mybatis.repository.util;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * stirng utils.
 *
 * @author Jarvis Song
 */
public abstract class StringUtils {


    public static final char UNDERLINE = '_';

    public static final String EMPTY_STRING = "";


    public static boolean isEmpty(String str) {
        return str == null || EMPTY_STRING.equals(str.trim());
    }

    public static boolean isNotEmpty(String str) {
        return !isEmpty(str);
    }


    public static String camelToUnderline(String param) {
        if (isEmpty(param)) {
            return EMPTY_STRING;
        }
        int len = param.length();
        StringBuilder sb = new StringBuilder(len);
        for (int i = 0; i < len; i++) {
            char c = param.charAt(i);
            if (Character.isUpperCase(c) && i > 0) {
                sb.append(UNDERLINE);
            }
            sb.append(Character.toLowerCase(c));
        }
        return sb.toString();
    }


    public static String underlineToCamel(String param) {
        if (isEmpty(param)) {
            return EMPTY_STRING;
        }
        int len = param.length();
        StringBuilder sb = new StringBuilder(len);
        for (int i = 0; i < len; i++) {
            char c = param.charAt(i);
            if (c == UNDERLINE) {
                if (++i < len) {
                    sb.append(Character.toUpperCase(param.charAt(i)));
                }
            } else {
                sb.append(c);
            }
        }
        return sb.toString();
    }

    public static boolean isUpperCase(String str) {
        return match("^[A-Z]+$", str);
    }


    public static boolean match(String regex, String str) {
        Pattern pattern = Pattern.compile(regex);
        Matcher matcher = pattern.matcher(str);
        return matcher.matches();
    }

    public static String replaceOnce(String template, String placeholder, String replacement) {
        if (template == null) {
            return null;  // returnign null!
        }
        int loc = template.indexOf(placeholder);
        if (loc < 0) {
            return template;
        } else {
            return template.substring(0, loc) + replacement + template.substring(loc + placeholder.length());
        }
    }
}
