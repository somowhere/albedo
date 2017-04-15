package org.springframework.data.mybatis.replication.datasource;

import javax.sql.DataSource;
import java.util.List;
import java.util.Random;

/**
 * @author Jarvis Song
 */
public class RandomDatasourceSelectPolicy implements DatasourceSelectPolicy {
    private Random random = new Random();

    @Override
    public int select(List<DataSource> slaves) {
        int i = random.nextInt(slaves.size());
        return i;
    }
}
