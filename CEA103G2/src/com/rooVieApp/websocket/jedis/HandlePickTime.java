package com.rooVieApp.websocket.jedis;

import java.util.List;

import redis.clients.jedis.Jedis;
import redis.clients.jedis.JedisPool;

import jedis.JedisUtil;
public class HandlePickTime {
	private static JedisPool pool = JedisUtil.getJedisPool();

	public static List<String> getHistoryMsg(String identity) {
		String key = new StringBuilder(identity).toString();
		Jedis jedis = null;
		jedis = pool.getResource();
		jedis.auth("123456");
		List<String> historyData = jedis.lrange(key, 0, -1);
		jedis.close();
		return historyData;
	}

	public static void saveChatMessage(String identity, String message) {
		// 對雙方來說，都要各存著歷史聊天記錄
		System.out.println("COMING");
		String identityKey = new StringBuilder(identity).toString();
		Jedis jedis = pool.getResource();
		jedis.auth("123456");
		jedis.rpush(identityKey, message);
		jedis.close();
	}
}
