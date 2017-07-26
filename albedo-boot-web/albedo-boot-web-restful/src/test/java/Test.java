import com.albedo.java.vo.sys.UserForm;
import com.alibaba.fastjson.JSON;

/**
 * Created by lijie on 2017/7/18.
 */
public class Test {
    public static void main(String[] args) {
        String str = "{\"orgId\":\"1\",\"loginId\":\"anonymoususer\",\"phone\":\"\",\"email\":\"anonymous@localhost1\",\"roleIdList\":{\"0\":\"5faa80a30a374148b5e0943f2a6fcb47\",\"1\":\"43186a6c08d247c098ea357e28cc75f4\",\"2\":\"2b8883fa01c94c058737979dedca7e99\"},\"status\":0,\"id\":\"2\"}";
        UserForm userForm = JSON.parseObject(str, UserForm.class);
        System.out.println(userForm);
    }
}
