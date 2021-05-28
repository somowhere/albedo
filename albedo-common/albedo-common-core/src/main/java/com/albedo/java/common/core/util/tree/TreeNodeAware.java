package com.albedo.java.common.core.util.tree;

import java.util.List;

/**
 * @param <T>
 * @author somewhere
 */
public interface TreeNodeAware<T> {

	/**
	 * getId
	 *
	 * @return
	 */
	String getId();

	/**
	 * getParentId
	 *
	 * @return
	 */
	String getParentId();

	/**
	 * getChildren
	 *
	 * @return
	 */
	List<T> getChildren();

	/**
	 * setChildren
	 *
	 * @param children
	 */
	void setChildren(List<T> children);

}
