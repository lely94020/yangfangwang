package com.yangfangwang.util;

public class PageUtil {
    private int pageSize = 8;
    private int currentPage = 1;
    private int totalRecords;
    private int totalPages;

    public PageUtil() {}

    public PageUtil(int pageSize) {
        this.pageSize = pageSize;
    }

    public int getPageSize() { return pageSize; }
    public void setPageSize(int pageSize) { this.pageSize = pageSize; }

    public int getCurrentPage() { return currentPage; }
    public void setCurrentPage(int currentPage) {
        if (currentPage < 1) currentPage = 1;
        this.currentPage = currentPage;
    }

    public int getTotalRecords() { return totalRecords; }
    public void setTotalRecords(int totalRecords) {
        this.totalRecords = totalRecords;
        this.totalPages = (int) Math.ceil((double) totalRecords / pageSize);
    }

    public int getTotalPages() { return totalPages; }

    public int getOffset() {
        return (currentPage - 1) * pageSize;
    }

    public boolean hasPrevious() { return currentPage > 1; }
    public boolean hasNext() { return currentPage < totalPages; }
}
