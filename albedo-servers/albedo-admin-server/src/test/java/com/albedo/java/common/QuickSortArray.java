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

package com.albedo.java.common;

import cn.hutool.json.JSONUtil;
import org.junit.jupiter.api.Test;

import java.util.Arrays;

import static cn.hutool.core.util.ArrayUtil.swap;

public class QuickSortArray {

	@Test
	public void doTest() {
		int[] sortArray = {10, 6, 1, 8, 12, 31, 3, 22, 5, 7, 2, 9};
		System.out.println(JSONUtil.toJsonStr(sort(sortArray)));
	}

	public int[] sort(int[] sourceArray) {
		int[] arr = Arrays.copyOf(sourceArray, sourceArray.length);
		return quickSort(arr, 0, arr.length - 1);
	}

	private int[] quickSort(int[] arr, int left, int right) {
		if (left < right) {
			int partitionIndex = partition(arr, left, right);
			System.out.println(JSONUtil.toJsonStr(arr));
			quickSort(arr, left, partitionIndex - 1);
			System.out.println(JSONUtil.toJsonStr(arr));
			quickSort(arr, partitionIndex + 1, right);
		}
		return arr;
	}

	private int partition(int[] arr, int left, int right) {
		int pivot = left;
		int index = pivot + 1;
		for (int i = index; i <= right; i++) {
			if (arr[i] < arr[pivot]) {
				if (i != index) {
					swap(arr, i, index);
				}
				index++;
			}
		}
		swap(arr, pivot, index - 1);
		return index - 1;
	}

}
