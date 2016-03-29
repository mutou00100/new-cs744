package com.entity;

import java.sql.Date;
//test
public class Message {
	private String id;
	public Message(String id, int origin, int dest, String content){
		this.id = id;
		this.origin = origin;
		this.destination = dest;
		this.content = content;
	}
	public String getId() {
		return id;
	}
	public void setId(Date id) {
		this.id = id;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public int getOrigin() {
		return origin;
	}
	public void setOrigin(int origin) {
		this.origin = origin;
	}
	public int getDestination() {
		return destination;
	}
	public void setDestination(int destination) {
		this.destination = destination;
	}
	private String content;
	private int origin;
	private int destination;
}
