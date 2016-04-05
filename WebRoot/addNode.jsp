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
		var vn1 = document.getElementsByName("n1")[0].value;
		var vn2 = document.getElementsByName("n2")[0].value;
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
		var nubmer1 = parseInt(document.getElementsByName("n1")[0].value);
		var nubmer2 = parseInt(document.getElementsByName("n2")[0].value);
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
								<td class="span2"><select name=gid" id= "gid" onChange="getCity(this,document.getElementById('city1'))">
										<option value="0">Please select a pattern</option>
										<%
											if (allPatterns != null && allPatterns.size() != 0) {
												for (int i = 0; i < allPatterns.size(); i++) {
													int pattern = allPatterns.get(i);
													out.println("<option value = " +  pattern + ">" +  pattern
															+ "</option>");
												}
											}
										%>
								</select>
								</td>
								<td>NonConnector Node1:</td>
								<td><select id="city1" name="n1"></select></td>
								<td>NonConnector Node2:</td>
								<td><select id="city2" name="n2"></select></td>
								<td class="input"><input name="flag" id="flag" type="checkbox" value="0">Connect to Connector</input></td>
								<td>
									<a class="btn btn-primary" type="submit" onclick="if(check()){addNonNode();}">Add</button>
								</td>
							</tr>
						</tbody>
					</table>