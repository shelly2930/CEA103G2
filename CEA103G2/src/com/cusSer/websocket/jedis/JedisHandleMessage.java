package com.cusSer.websocket.jedis;

import java.util.List;
import java.util.Set;

import redis.clients.jedis.Jedis;
import redis.clients.jedis.JedisPool;

public class JedisHandleMessage {
	// ���d��key���]�p��(�o�e�̦W��:�����̦W��)�A������ĥ�(�o�e�̷|���s��:�����̷|���s��)

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
		// ������ӻ��A���n�U�s�۾��v��ѰO��
		//�� senderKey�MreceiverKey���ӬORedis�s���Ϊ�KEY
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
