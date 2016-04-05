<%@ include file="realhead.jsp"%>
			<div class="span10" id="datacontent">
					<table class="table">
						<thead>
							<tr>
								<th colspan="5">Activate Node</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td class="span2">Pattern:</td>
								<td class="span2"><select name="gid" id= "gid" onChange="getCity(this,document.getElementById('city'))">
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
								</select></td>
								<td class="span2">Node ID:</td>
								<td class="span3"><select id="city" name="nid"></select></td>
								<td class="span4">
									<button class="btn btn-primary" onclick = "activateNode();" type="submit">Activate</button>
								</td>
							</tr>
						</tbody>
					</table>