<%@ include file="realhead.jsp"%>
<script type="text/javascript">

function check() {
	if ($('#nid').val()== null) {
		alert("Please chooose a node!");
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
								<td class="span2">Node:</td>
								<td class="span2"><select name="nid" id= "nid">
										<option disabled selected value> -- Please select a node -- </option>
										<%
											if (allnodes != null && allnodes.size() != 0) {
												for (int i = 0; i < allnodes.size(); i++) {
													int node = allnodes.get(i).getnID();
													out.println("<option value = " +  node + ">" +  node
														+ "</option>");
												}
											}
										%>
								</select></td>
								<td class="span4">
									<button class="btn btn-primary" onclick = "if (check()){activateNode();}" type="submit">Activate</button>
								</td>
							</tr>
						</tbody>
					</table>
				</div>