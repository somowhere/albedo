package com.albedo.java.common.security.util;


/**
 * Utility class for generating random Strings.
 */
public final class RandomUtil extends cn.hutool.core.util.RandomUtil {

	private static final int DEF_COUNT = 20;

	private RandomUtil() {
	}

	/**
	 * Generate a password.
	 *
	 * @return the generated password.
	 */
	public static String generatePassword() {
		return RandomUtil.randomString(DEF_COUNT);
	}

	/**
	 * Generate an activation key.
	 *
	 * @return the generated activation key.
	 */
	public static String generateActivationKey() {
		return RandomUtil.randomNumbers(DEF_COUNT);
	}

	/**
	 * Generate a reset key.
	 *
	 * @return the generated reset key.
	 */
	public static String generateResetKey() {
		return RandomUtil.randomNumbers(DEF_COUNT);
	}

	/**
	 * Generate a unique series to validate a persistent token, used in the
	 * authentication remember-me mechanism.
	 *
	 * @return the generated series data.
	 */
	public static String generateSeriesData() {
		return RandomUtil.randomString(DEF_COUNT);
	}

	/**
	 * Generate a persistent token, used in the authentication remember-me mechanism.
	 *
	 * @return the generated token data.
	 */
	public static String generateTokenData() {
		return RandomUtil.randomString(DEF_COUNT);
	}
}
