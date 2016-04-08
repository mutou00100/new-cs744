<%@ page language="java" import="java.util.*" import="com.entity.Edge" import="com.dao.NodeDao" import="com.entity.Node" pageEncoding="UTF-8"%>
<%@ page import="com.entity.Message"%>
<%@ page import="com.dao.MessageDao"%>

<%String error = "";
	NodeDao  nd = new NodeDao();
	MessageDao md = new MessageDao();
	ArrayList<Integer> resN = nd.getAllN();
	ArrayList<Integer> res = nd.getAllC();
	ArrayList<Integer> res1 = nd.getAllD();
	ArrayList<Integer> resD = nd.getAllD();
	ArrayList<Integer> allNonDnodes = new ArrayList<Integer>();
	allNonDnodes.addAll(resN);
	allNonDnodes.addAll(res);
	List<Node> allnodes = nd.getAllNodes();
	List<Edge> edge = nd.getCEdges();
	List<Edge> edgeCC = nd.getEdgesForC();
	List<Edge> edgeNN = nd.getEdgesForN();
	List<Edge> edgeDD = nd.getEdgesForD();
	List<Edge> edgeCN = nd.getCEdges();
	List<Edge> edgeCD = nd.getDEdges();
	//List<Edge> edgeDD = nd.getDEdges();
	edge.addAll(nd.getNEdges());
	List<Integer> allPatterns = nd.getAllC();
	ArrayList<Integer> pathNode = new ArrayList<Integer>();
	if (request.getAttribute("pathNode") != null) {
		pathNode = (ArrayList<Integer>)request.getAttribute("pathNode");
	}
	HashSet<Edge> hs = new HashSet<Edge>();
	HashSet<Edge> hs1 = new HashSet<Edge>();
	if (edgeCC.size() != 0){
		hs1 = new HashSet<Edge>(edgeCC);
	}
	%>
	<% 
if (request.getAttribute("error") == null) {
	} else {
			 error = (String) request.getAttribute("error");
				%>
   <script>
    alert("<%=error%>");</script>
   <% }
%>
