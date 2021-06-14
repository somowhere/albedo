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

package com.albedo.java.common.core.util;

/**
 * 媒体类型工具类
 *
 * @author somewhere
 */
public class MimeTypeUtil {
	public static final String IMAGE_PNG = "image/png";

	public static final String IMAGE_JPG = "image/jpg";

	public static final String IMAGE_JPEG = "image/jpeg";

	public static final String IMAGE_BMP = "image/bmp";

	public static final String IMAGE_GIF = "image/gif";

	public static final String[] IMAGE_EXTENSION = {"bmp", "gif", "jpg", "jpeg", "png"};

	public static final String[] FLASH_EXTENSION = {"swf", "flv"};

	public static final String[] MEDIA_EXTENSION = {"swf", "flv", "mp3", "wav", "wma", "wmv", "mid", "avi", "mpg",
		"asf", "rm", "rmvb"};

	public static final String[] DEFAULT_ALLOWED_EXTENSION = {
		// 图片
		"bmp", "gif", "jpg", "jpeg", "png",
		// word excel powerpoint
		"doc", "docx", "xls", "xlsx", "ppt", "pptx", "html", "htm", "txt",
		// 压缩文件
		"rar", "zip", "gz", "bz2",
		// pdf
		"pdf"};

	public static String getExtension(String prefix) {
		switch (prefix) {
			case IMAGE_PNG:
				return "png";
			case IMAGE_JPG:
				return "jpg";
			case IMAGE_JPEG:
				return "jpeg";
			case IMAGE_BMP:
				return "bmp";
			case IMAGE_GIF:
				return "gif";
			default:
				return "";
		}
	}
}
