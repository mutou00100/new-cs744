<%@ include file="head_without_jsp.jsp"%>

<%String error = "";
	NodeDao nd = new NodeDao();
	ArrayList<Integer> res = nd.getAllC();
	List<Node> allnodes = nd.getAllNodes();
	List<Edge> edge = nd.getCEdges();
	List<Edge> edgeCC = nd.getEdgesForC();
	List<Edge> edgeNN = nd.getEdgesForN();
	List<Edge> edgeCN = nd.getCEdges();
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
