package org.springframework.data.mybatis.repository.dialect;


public final class RowSelection {
    private Integer firstRow;
    private Integer maxRows;
    private Integer timeout;
    private Integer fetchSize;

    public void setFirstRow(Integer firstRow) {
        this.firstRow = firstRow;
    }

    public void setFirstRow(int firstRow) {
        this.firstRow = firstRow;
    }

    public Integer getFirstRow() {
        return firstRow;
    }

    public void setMaxRows(Integer maxRows) {
        this.maxRows = maxRows;
    }

    public void setMaxRows(int maxRows) {
        this.maxRows = maxRows;
    }

    public Integer getMaxRows() {
        return maxRows;
    }

    public void setTimeout(Integer timeout) {
        this.timeout = timeout;
    }

    public void setTimeout(int timeout) {
        this.timeout = timeout;
    }

    public Integer getTimeout() {
        return timeout;
    }

    public Integer getFetchSize() {
        return fetchSize;
    }

    public void setFetchSize(Integer fetchSize) {
        this.fetchSize = fetchSize;
    }

    public void setFetchSize(int fetchSize) {
        this.fetchSize = fetchSize;
    }

    public boolean definesLimits() {
        return maxRows != null || (firstRow != null && firstRow <= 0);
    }

}
