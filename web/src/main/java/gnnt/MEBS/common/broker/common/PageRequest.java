package gnnt.MEBS.common.broker.common;

import java.io.Serializable;
import java.util.Collections;
import java.util.List;

public class PageRequest<T> implements Serializable {
	private static final long serialVersionUID = -3399934325189446016L;
	public static final int DEFAULT_PAGE_SIZE = 1000;
	public static final int DEFAULT_PAGE_NUMBER = 1;
	private T filters;
	private int pageNumber;
	private int pageSize = 1000;
	private String sortColumns;

	public PageRequest() {
	}

	public PageRequest(T filters) {
		this(1, 1000, filters);
	}

	public PageRequest(int pageNumber, int pageSize) {
		this(pageNumber, pageSize, (T) null);
	}

	public PageRequest(int pageNumber, int pageSize, T filters) {
		this(pageNumber, pageSize, filters, null);
	}

	public PageRequest(int pageNumber, int pageSize, String sortColumns) {
		this(pageNumber, pageSize, null, sortColumns);
	}

	public PageRequest(int pageNumber, int pageSize, T filters, String sortColumns) {
		this.pageNumber = pageNumber;
		this.pageSize = pageSize;
		setFilters(filters);
		setSortColumns(sortColumns);
	}

	public T getFilters() {
		return (T) this.filters;
	}

	public void setFilters(T filters) {
		if ((!(filters instanceof String)) && (!(filters instanceof QueryConditions))) {
			throw new IllegalArgumentException("只支持String和QueryConditions类型");
		}
		this.filters = filters;
	}

	public int getPageNumber() {
		return this.pageNumber;
	}

	public void setPageNumber(int pageNumber) {
		this.pageNumber = pageNumber;
	}

	public int getPageSize() {
		return this.pageSize;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	public String getSortColumns() {
		if (this.sortColumns == null) {
			return "";
		}
		return this.sortColumns;
	}

	public void setSortColumns(String sortColumns) {
		checkSortColumnsSqlInjection(sortColumns);
		if ((sortColumns != null) && (sortColumns.length() > 200)) {
			throw new IllegalArgumentException("sortColumns.length() <= 200 must be true");
		}
		this.sortColumns = sortColumns;
	}

	public List<SortInfo> getSortInfos() {
		return Collections.unmodifiableList(SortInfo.parseSortColumns(this.sortColumns));
	}

	private void checkSortColumnsSqlInjection(String sortColumns) {
		if (sortColumns == null) {
			return;
		}
		if ((sortColumns.indexOf("'") >= 0) || (sortColumns.indexOf("\\") >= 0)) {
			throw new IllegalArgumentException("sortColumns:" + sortColumns + " has SQL Injection risk");
		}
	}
}
