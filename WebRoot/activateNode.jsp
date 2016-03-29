<%@ include file="realhead.jsp"%>
<script type="text/javascript">
	function check() {
		var x =  document.getElementById("nid").value;
		if (x == null || x == "") {
			alert("The node can't be the null!");
			return false;
		}
		var nubmer1 = parseInt(document.getElementById("nid").value);
		if (nubmer1<=0||!(/^\d+$/.test(nubmer1))){
			 alert("Please enter a Integer!");
		     return false;
		} 
			return true;
	}
</script>
			<div class="span10" id="datacontent">
					<table class="table">
						<thead>
							<tr>
								<th colspan="5">Activate Node</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td class="span4">Node ID:</td>
								<td class="span2"><select name="nid" id= "nid" class="span1">
										<%
											if (allnodes != null && allnodes.size() != 0) {
												for (int i = 0; i < allnodes.size(); i++) {
													int pattern = allnodes.get(i).getnID();
													out.println("<option value = " +  pattern + ">" +  pattern
															+ "</option>");
												}
											}
										%>
								</select></td>
								<td class="span6">
									<button class="btn btn-primary" onclick = "if(check()){activateNode();}" type="submit">Activate</button>
								</td>
							</tr>
						</tbody>
					</table>