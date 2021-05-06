package com.memTen.jedis;

import jedis.JedisUtil;
import redis.clients.jedis.Jedis;
import redis.clients.jedis.JedisPool;

public class JedisHandler {

	private static JedisPool pool = JedisUtil.getJedisPool();
	
	public static String randAuthCode() {
		StringBuffer code = new StringBuffer();
		String elements = "01234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
		for (int i = 0; i < 10; i++)
			code.append(elements.charAt((int) (Math.random() * elements.length())));
		return code.toString();
	}
	
	public String setAuthCode(String mem_username) {
		Jedis jedis = pool.getResource();
		jedis.auth("123456");
		
		String authCode = randAuthCode();
		jedis.select(1);
		jedis.set(mem_username, authCode);
		jedis.expire(mem_username, 86400);
		
		jedis.close();
		return authCode;
	}
	
	public static String getAuthCode(String mem_username) {
		Jedis jedis = pool.getResource();
		jedis.auth("123456");
		
		jedis.select(1);
		String savedCode = jedis.get(mem_username);
		
		jedis.close();	
		return savedCode;
	}
	
}
