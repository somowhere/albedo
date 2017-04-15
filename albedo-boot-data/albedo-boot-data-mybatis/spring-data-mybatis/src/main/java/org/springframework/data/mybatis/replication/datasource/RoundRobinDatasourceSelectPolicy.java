package org.springframework.data.mybatis.replication.datasource;

import javax.sql.DataSource;
import java.util.List;
import java.util.concurrent.atomic.AtomicInteger;

/**
 * @author Jarvis Song
 */
public class RoundRobinDatasourceSelectPolicy implements DatasourceSelectPolicy {

    private AtomicInteger count = new AtomicInteger(0);


    @Override
    public int select(List<DataSource> slaves) {
        int index = Math.abs(count.incrementAndGet()) % slaves.size();
        return index;
    }

}
