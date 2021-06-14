/*
 *  Copyright (c) 2019-2021  <a href="https://github.com/somowhere/albedo">Albedo</a>, somewhere (somewhere0813@gmail.com).
 *  <p>
 *  Licensed under the GNU Lesser General Public License 3.0 (the "License");
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

package com.albedo.java.common.core.vo;

import com.albedo.java.common.core.util.StringUtil;
import com.baomidou.mybatisplus.core.metadata.OrderItem;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

/**
 * @author somewhere
 * @description
 * @date 2020/5/31 17:09
 */
@Data
@NoArgsConstructor
public class PageModel<T> extends Page<T> {


	public static final String F_DESC = "desc";
	public static final String F_ASC = "asc";
	public static final Integer SORT_STR_LENGTH = 2;

	public PageModel(List<T> records, int total) {
		this.setRecords(records);
		this.setTotal(total);
	}

	public void setSorts(String sorts) {
		String[] split = sorts.split(StringUtil.SPLIT_DEFAULT);
		if (split.length == SORT_STR_LENGTH) {
			getOrders().add(F_DESC.equals(split[1]) ? OrderItem.desc(split[0]) : OrderItem.asc(split[0]));
		}
	}

	@Override
	public String toString() {
		return "PageModel(current=" + getCurrent() + ",size=" + getSize() + ",orders=" + getOrders() + ") ";
	}

}
