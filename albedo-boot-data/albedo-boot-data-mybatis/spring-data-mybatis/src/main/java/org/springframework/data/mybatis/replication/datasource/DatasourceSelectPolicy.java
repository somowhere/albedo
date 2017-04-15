package org.springframework.data.mybatis.replication.datasource;

import javax.sql.DataSource;
import java.util.List;

/**
 * @author Jarvis Song
 */
public interface DatasourceSelectPolicy {

    int select(List<DataSource> slaves);

}
