package com.fh.entity.system;

public class SignData {
	public String id;
	public String name;
	public SignData() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	@Override
	public String toString() {
		return "SignData [id=" + id + ", name=" + name + "]";
	}
	
}
