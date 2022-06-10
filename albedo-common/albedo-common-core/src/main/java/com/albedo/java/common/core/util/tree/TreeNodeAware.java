/*
 *  Copyright (c) 2019-2022  <a href="https://github.com/somowhere/albedo">Albedo</a>, somewhere (somewhere0813@gmail.com).
 *  <p>
 *  you may not use this file except in compliance with the License.
 *  You may obtain a copy of the License at
 *  <p>
 * https://www.gnu.org/licenses/lgpl.html
 *  <p>
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

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
	Long getId();

	/**
	 * getParentId
	 *
	 * @return
	 */
	Long getParentId();

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
