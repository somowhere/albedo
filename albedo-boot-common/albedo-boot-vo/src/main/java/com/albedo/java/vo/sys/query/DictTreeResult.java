package com.albedo.java.vo.sys.query;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * Created by lijie on 2017/3/2.
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
public class DictTreeResult {

    private String id;
    private String pid;
    private String name;
    private String value;
    private String label;


}
