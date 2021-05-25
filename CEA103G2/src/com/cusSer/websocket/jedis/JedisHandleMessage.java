package com.cusSer.websocket.jedis;

import java.util.List;
import java.util.Set;

import redis.clients.jedis.Jedis;
import redis.clients.jedis.JedisPool;

public class JedisHandleMessage {
	// 此範例key的設計為(發送者名稱:接收者名稱)，實際應採用(發送者會員編號:接收者會員編號)

	private static JedisPool pool = JedisPoolUtil.getJedisPool();

	public static List<String> getHistoryMsg(String key) {
		String keymessage = new StringBuilder(key).toString();
		Jedis jedis = null;
		jedis = pool.getResource();
		jedis.auth("123456");
		jedis.select(2);
		
		List<String> historyData = jedis.lrange(keymessage, 0, -1);
		jedis.close();
		return historyData;
	}

	public static void saveChatMessage(String key , String message) {
		// 對雙方來說，都要各存著歷史聊天記錄
		//麥 senderKey和receiverKey應該是Redis存取用的KEY
		String keymessage = new StringBuilder(key).toString();
		Jedis jedis = pool.getResource();
		jedis.auth("123456");
		jedis.select(2);
		jedis.rpush(keymessage, message);//[(key): message]
		jedis.close();
	}
	
	public static Set<String> getAllkey() {
		Jedis jedis = null;
		jedis = pool.getResource();
		jedis.auth("123456");
		jedis.select(2);
		Set<String> allkey = jedis.keys("*");
		jedis.close();
		return allkey;
	}

}
