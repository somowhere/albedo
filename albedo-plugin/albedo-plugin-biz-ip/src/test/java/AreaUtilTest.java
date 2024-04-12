import com.albedo.java.plugins.ip.Area;
import com.albedo.java.plugins.ip.enums.AreaTypeEnum;
import com.albedo.java.plugins.ip.util.AreaUtil;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertEquals;

/**
 * {@link AreaUtil} 的单元测试
 *
 * @author 芋道源码
 */
public class AreaUtilTest {

    @Test
    public void testGetArea() {
        // 调用：北京
        Area area = AreaUtil.getArea(110100);
        // 断言
        assertEquals(area.getId(), 110100);
        assertEquals(area.getName(), "北京市");
        assertEquals(area.getType(), AreaTypeEnum.CITY.getType());
        assertEquals(area.getParent().getId(), 110000);
        assertEquals(area.getChildren().size(), 16);
    }

    @Test
    public void testFormat() {
        assertEquals(AreaUtil.format(110105), "北京 北京市 朝阳区");
        assertEquals(AreaUtil.format(1), "中国");
        assertEquals(AreaUtil.format(2), "蒙古");
    }

}
