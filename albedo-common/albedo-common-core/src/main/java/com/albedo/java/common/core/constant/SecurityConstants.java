
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

package com.albedo.java.common.core.constant;

/**
 * @author somewhere
 * @date 2019/2/1
 */
public interface SecurityConstants {

	/**
	 * 角色前缀
	 */
	String ROLE = "ROLE_";

	/**
	 * 前缀
	 */
	String PROJECT_PREFIX = "albedo_";

	/**
	 * oauth 相关前缀
	 */
	String OAUTH_PREFIX = "oauth:";

	/**
	 * 项目的license
	 */
	String PROJECT_LICENSE = "made by albedo";

	/**
	 * 内部
	 */
	String FROM_IN = "Y";

	/**
	 * 标志
	 */
	String FROM = "from";

	/**
	 * 默认登录URL
	 */
	String AUTHENTICATE_URL = "/authenticate";

	/**
	 * grant_type
	 */
	String REFRESH_TOKEN = "refresh_token";

	/**
	 * oauth 客户端信息
	 */
	String CLIENT_DETAILS_KEY = PROJECT_PREFIX + OAUTH_PREFIX + "client:details";

	/**
	 * {bcrypt} 加密的特征码
	 */
	String BCRYPT = "{bcrypt}";

	/**
	 * sys_oauth_client_detail 表的字段，不包括client_id、client_secret
	 */
	String CLIENT_FIELDS = "client_id, CONCAT('{noop}',client_secret) as client_secret, resource_ids, scope, "
		+ "authorized_grant_types, web_server_redirect_uri, authorities, access_token_validity, "
		+ "refresh_token_validity, additional_information, autoapprove";

	/**
	 * JdbcClientDetailsService 查询语句
	 */
	String BASE_FIND_STATEMENT = "select " + CLIENT_FIELDS + " from sys_oauth_client_detail";

	/**
	 * 默认的查询语句
	 */
	String DEFAULT_FIND_STATEMENT = BASE_FIND_STATEMENT + " order by client_id";

	/**
	 * 按条件client_id 查询
	 */
	String DEFAULT_SELECT_STATEMENT = BASE_FIND_STATEMENT + " where client_id = ?";

	/***
	 * 资源服务器默认bean名称
	 */
	String RESOURCE_SERVER_CONFIGURER = "resourceServerConfigurerAdapter";

	/**
	 * 默认生成图形验证码宽度
	 */
	String DEFAULT_IMAGE_WIDTH = "100";

	/**
	 * 默认生成图像验证码高度
	 */
	String DEFAULT_IMAGE_HEIGHT = "40";

	/**
	 * 默认生成图形验证码长度
	 */
	String DEFAULT_IMAGE_LENGTH = "4";

	/**
	 * 默认生成图形验证码过期时间
	 */
	int DEFAULT_IMAGE_EXPIRE = 60;

	/**
	 * 边框颜色，合法值： r,g,b (and optional alpha) 或者 white,black,blue.
	 */
	String DEFAULT_COLOR_FONT = "black";

	/**
	 * 图片边框
	 */
	String DEFAULT_IMAGE_BORDER = "no";

	/**
	 * 默认图片间隔
	 */
	String DEFAULT_CHAR_SPACE = "5";

	/**
	 * 默认保存code的前缀
	 */
	String DEFAULT_CODE_KEY = "default_code_key";

	/**
	 * 默认保存登录的前缀
	 */
	String DEFAULT_LOGIN_KEY = "default_login_key";

	/**
	 * 默认保存登录的前缀
	 */
	String DEFAULT_LOGIN_JWT_KEY = "default_login_jwt_key_";

	String DEFAULT_LOGIN_JWT_MAP_KEY = "default_login_jwt_map_key";

	/**
	 * 默认保存24小时后登录的前缀
	 */
	String DEFAULT_LOGIN_AFTER_24_KEY = "default_login_after_24_key";

	/**
	 * 验证码文字大小
	 */
	String DEFAULT_IMAGE_FONT_SIZE = "30";


}
