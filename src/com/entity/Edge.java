package com.entity;

public class Edge {
	private int eID;
	private int nID1;
	private int nID2;
	public Edge(int eID, int node1, int node2) {
		this.nID1 = node1;
		this.nID2 = node2;
		this.eID = eID;
	}
	public Edge(int node1, int node2) {
		this.nID1 = node1;
		this.nID2 = node2;
	}
	public int getNode1() {
		return nID1;
	}
	public void setNode1(int node1) {
		this.nID1 = node1;
	}
	@Override
	public int hashCode() {
		return nID1*nID2;
	}
	@Override
	public boolean equals(Object obj) {
		Edge other = (Edge) obj;
		if ((nID1 == other.nID1 && nID2 == other.nID2) || (nID1 == other.nID2 && nID2 == other.nID1))
			return true;
		return false;
	}
	public int getNode2() {
		return nID2;
	}
	public void setNode2(int node2) {
		this.nID2 = node2;
	}
	public int geteID() {
		return eID;
	}
	public void seteID(int eID) {
		this.eID = eID;
	}
}
