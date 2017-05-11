package com.albedo.java.thrift.rpc.common.util;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Random;

public class RandomUtils {
	public static String getRandom(int c) {
		Random r = new Random();
		SimpleDateFormat format = new SimpleDateFormat("ssSSS");
		Date d = new Date();
		StringBuffer sb = new StringBuffer();
		sb.append(format.format(d));
		sb.append(r.nextInt(10));
		return sb.toString();
	}
	public static String getRandomWithLength(int length) {
		Random random = new Random();
		StringBuilder ret = new StringBuilder();
		for (int i = 0; i < length; i++) {
			boolean isChar = (random.nextInt(2) % 2 == 0);
			if (isChar) {
				int choice = (random.nextInt(2) % 2 == 0) ? 65 : 97;
				ret.append((char) (choice + random.nextInt(26)));
			} else {
				ret.append(Integer.toString(random.nextInt(10)));
			}
		}
		return ret.toString();
	}
	public static int randomInt(int start,int end){
		Random r=new Random();
		return r.nextInt(end-start)+start;
	}
}