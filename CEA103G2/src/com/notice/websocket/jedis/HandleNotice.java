package com.notice.websocket.jedis;

import java.util.List;

import jedis.JedisUtil;
import redis.clients.jedis.Jedis;
import redis.clients.jedis.JedisPool;

public class HandleNotice {
	private static JedisPool pool = JedisUtil.getJedisPool();

	
	public static List<String> getHistory(String identity) {
		String key = new StringBuilder(identity).toString();
		Jedis jedis = null;
		jedis = pool.getResource();
		jedis.auth("123456");
		jedis.select(6);
		List<String> historyData = jedis.lrange(key, 0, -1);
		jedis.close();
		return historyData;
	}

	public static void saveHistory(String identity, String message) {
		// 對雙方來說，都要各存著歷史聊天記錄
		System.out.println("COMING");
		String identityKey = new StringBuilder(identity).toString();
		Jedis jedis = pool.getResource();
		jedis.auth("123456");
		jedis.select(6);
		jedis.rpush(identityKey, message);
		jedis.close();
	}
	
}
