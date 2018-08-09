package com.mongo.util;

import org.bson.Document;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.mongodb.MongoClient;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;

public class MongoUtil {
	private static final Logger logger = LoggerFactory.getLogger(MongoUtil.class);
	
	private static MongoClient mgc;
	
	public static MongoClient getMondb() {
		if(mgc == null) {
			try {
				mgc =  new MongoClient("192.168.0.64", 27017);
			} catch (Exception e) {
				logger.error(e.getMessage());
			}
		}
		return mgc;
	}
	
	// MongoDatabase 가져오기
	public static MongoDatabase getDb(String dbname) {
		return getMondb().getDatabase(dbname);
	}
	
	// Collection 가져오기
	public static MongoCollection<Document> getCollection(String dbname, String colname) {
		return getDb(dbname).getCollection(colname);
	}
}