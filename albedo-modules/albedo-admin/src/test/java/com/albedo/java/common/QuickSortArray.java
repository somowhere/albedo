package com.albedo.java.common;

import com.albedo.java.common.core.util.Json;
import org.junit.jupiter.api.Test;

import java.util.Arrays;

import static cn.hutool.core.util.ArrayUtil.swap;

public class QuickSortArray {

	@Test
	public void doTest() {
		int[] sortArray = {10, 6, 1, 8, 12, 31, 3, 22, 5, 7, 2, 9};
		System.out.println(Json.toJSONString(sort(sortArray)));
	}

	public int[] sort(int[] sourceArray) {
		int[] arr = Arrays.copyOf(sourceArray, sourceArray.length);
		return quickSort(arr, 0, arr.length - 1);
	}

	private int[] quickSort(int[] arr, int left, int right) {
		if (left < right) {
			int partitionIndex = partition(arr, left, right);
			System.out.println(Json.toJSONString(arr));
			quickSort(arr, left, partitionIndex - 1);
			System.out.println(Json.toJSONString(arr));
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
