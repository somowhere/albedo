package com.albedo.java.common.core.util.tree;

import java.util.List;

public interface TreeNodeAware<T> {

	String getId();

	String getParentId();

	List<T> getChildren();

	void setChildren(List<T> children);
}
