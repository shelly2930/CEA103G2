package com.rooVieApp.websocket.jedis;

import java.util.List;

import com.rooVieApp.websocket.model.ControlTimeVO;

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
	
	public static void saveControlTime(String identity, String message_controltime) {
		System.out.println(identity);
		String key = new StringBuilder(identity).toString();
		Jedis jedis = null;
		jedis = pool.getResource();
		jedis.auth("123456");
		jedis.select(5);
		jedis.set(key, message_controltime);
		jedis.close();
	}
	
	public static String getControlTime(String identity) {
		String key = new StringBuilder(identity).toString();
		Jedis jedis = null;
		jedis = pool.getResource();
		jedis.auth("123456");
		jedis.select(5);
		String message_controltime = jedis.get(key);
		jedis.close();
		return message_controltime;
	}
	
	public static void updateControlTime(String identity, String message_controltime) {
		String key = new StringBuilder(identity).toString();
		Jedis jedis = null;
		jedis = pool.getResource();
		jedis.auth("123456");
		jedis.select(5);
		jedis.set(key, message_controltime);
		jedis.close();
	}
	
	public static void main(String[] args) {
		System.out.println(getControlTime("2"));

	}
}
