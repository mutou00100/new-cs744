<%@ include file="realhead.jsp"%>
<script type="text/javascript">
	var belongC;
	function check() {
		if ($('#dID').val() == null || $('#cID1').val() == null
				|| $('#cID2').val() == null) {
			alert("Please chooose two nodes to connect!");
			return false;
		}
		return true;
	}
	$(document)
			.ready(
					function() {
						$('#dID')
								.change(
										function() {
											var dNode = $('#dID').val();
											var data = {
												"dNode" : dNode
											};
											var mydata = JSON.stringify(data);
											$.ajax({
														type : "POST",
														url : "showCforD",
														data : mydata,
														contentType : 'application/json;charset=UTF-8',
														success : function(
																result) {
															var obj = JSON
																	.parse(result);
															belongC = obj['belongC'];
															$("#cID1")
																	.html(
																			"<option disabled selected value> -- select an Pattern -- </option>");
															for (var i = 0; i < belongC.length; i++) {
																$("#cID1")
																		.append(
																				"<option value='" + belongC[i] + "'>"
																						+ belongC[i]
																						+ "</option>");
															}
														}
													});
										});
						$('#cID1')
								.change(
										function() {
											var node = $('#cID1').val();
											var selection = belongC;
											var index = selection
													.indexOf(parseInt(node));
											if (index > -1) {
												selection.splice(index, 1);
											}
											$("#cID2")
													.html(
															"<option disabled selected value> -- select an Pattern -- </option>");
											for (var i = 0; i < selection.length; i++) {
												$("#cID2").append(
														"<option value='" + selection[i] + "'>"
																+ selection[i]
																+ "</option>");
											}
										});
					});
</script>
<div class="span12" id="datacontent">
<p><b>Add Connection Between Patterns</p>
	<table class="table">
		
		<tbody>
			<tr>
				<td>Domain:</td>
				<td class="input"><select name="dID" id="dID" class="span1">
						<option disabled selected value>-- select an Domain --</option>
						<%
							if (res1 != null && res1.size() != 0) {
								for (int i = 0; i < res1.size(); i++) {
									int domain = res1.get(i);
									out.println("<option value = " + domain + ">" + domain
											+ "</option>");
								}
							}
						%>
				</select></td>
				<td>Pattern:</td>
				<td class="span2"><select id="cID1">
						<option disabled selected value>-- select an Pattern --</option>
				</select></td>
				<td>Node:</td>
				<td class="span2"><select id="cID2">
						<option disabled selected value>-- select an Pattern --</option>
				</select></td>
				<td><button class="btn btn-primary" type="submit"
					onclick="if(check()){addCC();}">Add
						</button>
				</td>
			</tr>
		</tbody>
	</table>
</div>