package com.albedo.java.plugins.ip.util;

import cn.hutool.core.io.resource.ResourceUtil;
import cn.hutool.core.net.NetUtil;
import com.albedo.java.plugins.ip.Area;
import lombok.SneakyThrows;
import lombok.extern.slf4j.Slf4j;
import org.lionsoul.ip2region.xdb.Searcher;

import java.io.IOException;

@Slf4j
public class IpUtil {
	public static final String LOCAL_IP = "0:0:0:0:0:0:0:1";
	/**
	 * 初始化 SEARCHER
	 */
	@SuppressWarnings("InstantiationOfUtilityClass")
	private final static IpUtil INSTANCE = new IpUtil();

	/**
	 * IP 查询器，启动加载到内存中
	 */
	private static Searcher SEARCHER;

	/**
	 * 私有化构造
	 */
	private IpUtil() {
		try {
			long now = System.currentTimeMillis();
			byte[] bytes = ResourceUtil.readBytes("ip2region.xdb");
			SEARCHER = Searcher.newWithBuffer(bytes);
			log.info("启动加载 IpUtil 成功，耗时 ({}) 毫秒", System.currentTimeMillis() - now);
		} catch (IOException e) {
			log.error("启动加载 IpUtil 失败", e);
		}
	}

	/**
	 * 查询 IP 对应的地区编号
	 *
	 * @param ip IP 地址，格式为 127.0.0.1
	 * @return 地区id
	 */
	@SneakyThrows
	public static Integer getAreaId(String ip) {
		return Integer.parseInt(SEARCHER.search(ip.trim()));
	}

	/**
	 * 查询 IP 对应的地区编号
	 *
	 * @param ip IP 地址的时间戳，格式参考{@link Searcher#checkIP(String)} 的返回
	 * @return 地区编号
	 */
	@SneakyThrows
	public static Integer getAreaId(long ip) {
		return Integer.parseInt(SEARCHER.search(ip));
	}

	/**
	 * 查询 IP 对应的地区
	 *
	 * @param ip IP 地址，格式为 127.0.0.1
	 * @return 地区
	 */
	public static Area getArea(String ip) {
		return AreaUtil.getArea(getAreaId(ip));
	}

	/**
	 * 查询 IP 对应的地区
	 *
	 * @param ip IP 地址，格式为 127.0.0.1
	 * @return 地区
	 */
	public static String getAreaName(String ip) {
		if (LOCAL_IP.equals(ip) || NetUtil.isInnerIP(ip)) {
			return "内网IP";
		}
		Area area = AreaUtil.getArea(getAreaId(ip));
		return area == null ? "unknown" : area.getName();
	}

	/**
	 * 查询 IP 对应的地区
	 *
	 * @param ip IP 地址的时间戳，格式参考{@link Searcher#checkIP(String)} 的返回
	 * @return 地区
	 */
	public static Area getArea(long ip) {
		return AreaUtil.getArea(getAreaId(ip));
	}

}
