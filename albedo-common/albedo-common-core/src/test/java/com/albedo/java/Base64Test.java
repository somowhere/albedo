package com.albedo.java;

import cn.hutool.core.codec.Base64;
import org.junit.Test;

import java.nio.charset.StandardCharsets;

public class Base64Test {


	@Test
	/**
	 * YWxiZWRvOmFsYmVkbw==
	 */
	public void encode() {


		System.out.println(Base64.encode("albedo:albedo"));

	}

	/**
	 * c3dhZ2dlcjpzd2FnZ2Vy
	 *
	 * @throws Exception
	 */
	@Test
	public void decode() throws Exception {
		String encode = Base64.encode("swagger:swagger");
		System.out.println(encode);
		byte[] base64Token = encode.getBytes(StandardCharsets.UTF_8);
		byte[] decoded = Base64.decode(base64Token);
		String token = new String(decoded, StandardCharsets.UTF_8);
		System.out.println(token);

	}
}
