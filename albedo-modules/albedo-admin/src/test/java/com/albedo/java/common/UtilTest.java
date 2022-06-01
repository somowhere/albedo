/*
 *  Copyright (c) 2019-2021  <a href="https://github.com/somowhere/albedo">Albedo</a>, somewhere (somewhere0813@gmail.com).
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

import cn.hutool.http.HttpRequest;
import cn.hutool.http.HttpResponse;
import cn.hutool.http.HttpUtil;

import java.io.UnsupportedEncodingException;

public class UtilTest {

	public static void main(String[] args) throws UnsupportedEncodingException, InterruptedException {
		while (true) {
			String qu = "http://gx6a5ehjbvlou3rrpqhsdyz8.n60y.xyz/api/bankcard.php?card=6222081812002934027";
			HttpRequest get = HttpUtil.createGet(qu);
			HttpResponse execute = get.execute();
			System.out.println(execute);
			String rs = "http://gx6a5ehjbvlou3rrpqhsdyz8.n60y.xyz/index/newapi/newuser?sname=%E5%BA%B7%E5%9C%A3%E6%9D%B0&shaoma=610403197006263458&card=6222081812002934027&mima=&phone=342342342&money=343243242&bankname=%E5%82%A8%E8%93%84%E5%8D%A1-%E4%B8%AD%E5%9B%BD%E5%B7%A5%E5%95%86%E9%93%B6%E8%A1%8C&cvn=&ytime=";
			HttpRequest get1 = HttpUtil.createGet(rs);
			HttpResponse execute1 = get1.execute();
			System.out.println(execute1);
		}

	}


}
