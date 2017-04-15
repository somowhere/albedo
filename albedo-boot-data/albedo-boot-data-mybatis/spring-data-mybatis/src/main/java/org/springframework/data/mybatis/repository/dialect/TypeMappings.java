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

package org.springframework.data.mybatis.repository.dialect;

import org.springframework.data.mapping.model.MappingException;
import org.springframework.data.mybatis.repository.util.StringUtils;

import java.util.HashMap;
import java.util.Map;
import java.util.TreeMap;

/**
 * @author Jarvis Song
 */
public class TypeMappings {
    private Map<Integer, String>            defaults = new HashMap<Integer, String>();
    private Map<Integer, Map<Long, String>> weighted = new HashMap<Integer, Map<Long, String>>();

    public String get(int typeCode) throws MappingException {
        final String result = defaults.get(typeCode);
        if (result == null) {
            throw new MappingException("No Dialect mapping for JDBC type: " + typeCode);
        }
        return result;
    }

    public String get(int typeCode, long size, int precision, int scale) throws MappingException {
        final Map<Long, String> map = weighted.get(typeCode);
        if (map != null && map.size() > 0) {
            // iterate entries ordered by capacity to find first fit
            for (Map.Entry<Long, String> entry : map.entrySet()) {
                if (size <= entry.getKey()) {
                    return replace(entry.getValue(), size, precision, scale);
                }
            }
        }
        // if we get here one of 2 things happened:
        //		1) There was no weighted registration for that typeCode
        //		2) There was no weighting whose max capacity was big enough to contain size
        return replace(get(typeCode), size, precision, scale);
    }

    private static String replace(String type, long size, int precision, int scale) {
        type = StringUtils.replaceOnce(type, "$s", Integer.toString(scale));
        type = StringUtils.replaceOnce(type, "$l", Long.toString(size));
        return StringUtils.replaceOnce(type, "$p", Integer.toString(precision));
    }

    public void put(int typeCode, long capacity, String value) {
        Map<Long, String> map = weighted.get(typeCode);
        if (map == null) {
            // add new ordered map
            map = new TreeMap<Long, String>();
            weighted.put(typeCode, map);
        }
        map.put(capacity, value);
    }


    public void put(int typeCode, String value) {
        defaults.put(typeCode, value);
    }
}
