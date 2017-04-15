package org.springframework.data.mybatis.repository.dialect.identity;

public class MySQLIdentityColumnSupport extends IdentityColumnSupportImpl {
    @Override
    public boolean supportsIdentityColumns() {
        return true;
    }

    @Override
    public String getIdentitySelectString(String table, String column, int type) {
        return "select last_insert_id()";
    }

    @Override
    public String getIdentityColumnString(int type) {
         return "not null auto_increment";
    }
}
