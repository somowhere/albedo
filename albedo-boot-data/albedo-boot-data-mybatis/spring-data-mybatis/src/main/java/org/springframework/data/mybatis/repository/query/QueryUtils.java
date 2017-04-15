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

package org.springframework.data.mybatis.repository.query;

import org.springframework.util.StringUtils;

import java.util.regex.Pattern;

import static java.util.regex.Pattern.CASE_INSENSITIVE;

/**
 * query utils.
 *
 * @author Jarvis Song
 */
public abstract class QueryUtils {

    private static final String  IDENTIFIER      = "[\\p{Lu}\\P{InBASIC_LATIN}\\p{Alnum}._$]+";
    private static final Pattern NAMED_PARAMETER = Pattern.compile(":" + IDENTIFIER + "|\\#" + IDENTIFIER,
            CASE_INSENSITIVE);

    public static boolean hasNamedParameter(String query) {
        return StringUtils.hasText(query) && NAMED_PARAMETER.matcher(query).find();
    }

}
