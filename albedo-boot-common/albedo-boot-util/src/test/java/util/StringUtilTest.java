package util;

import com.albedo.java.util.StringUtil;
import com.albedo.java.util.base.Reflections;

import java.lang.reflect.Field;

/**
 * Created by lijie on 2017/5/8.
 */
public class StringUtilTest {

    @org.junit.Test
    public void toCamelCase() throws Exception {

        ConstantDictPay obj = ConstantDictPay.class.newInstance();
        Field[] fields = obj.getClass().getFields();
        for (Field field : fields) {
            String fileStr = Reflections.getFieldValue(obj, field).toString().toLowerCase()
                    .replace("alipay_", "")
                    .replace("weixin_", "");
            System.out.println("private String " + StringUtil.toCamelCase(fileStr) + ";");
        }


    }

}
