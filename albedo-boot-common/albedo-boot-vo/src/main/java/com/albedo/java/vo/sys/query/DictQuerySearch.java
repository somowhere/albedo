package com.albedo.java.vo.sys.query;

import com.albedo.java.util.base.Encodes;
import lombok.Data;

/**
 * Created by lijie on 2017/3/2.
 */
@Data
public class DictQuerySearch {

    private String dictQueries;

    public void setDictQueries(String dictQueries) {
        this.dictQueries = Encodes.unescapeHtml(dictQueries);
    }

}
