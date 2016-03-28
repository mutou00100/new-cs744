<%@ include file="realhead.jsp"%>
<% 
if (allnodes.size() == 0){%>
   <script>
    alert("Please add a pattern first");
   </script>
   <% }
%>
<script type="text/javascript">
	function check() {
		var vn1 = document.getElementById("n1").value;
		var vn2 = document.getElementById("n2").value;
		var gid = document.getElementById("gid").value;
		if ( vn1==""&& vn2 =="") {
			return true;
		}
		if (gid == vn1) {
			alert("The node1 can't be the connector!");
			return false;
		}if (gid == vn2) {
			alert("The node2 can't be the connector!");
			return false;
		}if (vn1 == vn2 && vn1 != "" && vn2 != "") {
			alert("The node1 and node2 can't be the same!");
			return false;
		}
		var nubmer1 = parseInt(document.getElementById("n1").value);
		var nubmer2 = parseInt(document.getElementById("n2").value);
		if (vn1 !=""&&(nubmer1<=0||!(/^\d+$/.test(nubmer1)))){
				 alert("Please enter a Integer!");
	     return false;
			}
			if (vn2 !=""&&(nubmer2<=0||!(/^\d+$/.test(nubmer2)))){
				alert("Please enter a Integer!");
				return false;
			}
		return true;
	}
</script>
			<div class="span12" id="datacontent">

					<table class="table">
						<thead>
							<tr>
								<th colspan="5">Add Non-connector Node</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>Pattern:</td>
								<td><select name="gid" id= "gid" class="span1">
										<%
											if (allPatterns != null && allPatterns.size() != 0) {
												for (int i = 0; i < allPatterns.size(); i++) {
													int pattern = allPatterns.get(i);
													out.println("<option value = " +  pattern + ">" +  pattern
															+ "</option>");
												}
											}
										%>
								</select></td>
								<td>NonConnector Node1:</td>
								<td class="input"><input name="n1" id= "n1" class="input-small"
									size="10" type="text" value=""></input></td>
								<td>NonConnector Node2:</td>
								<td class="input"><input class="input-small" id= "n2" name="n2"
									size="10" type="text" value=""></input></td>
								<td class="input"><input name="flag" id="flag" type="checkbox" value="0">Connect to Connector</input></td>
								<td>
									<a class="btn btn-primary" type="submit" onclick="if(check()){addNonNode();}">Add</button>
								</td>
							</tr>
						</tbody>
					</table>