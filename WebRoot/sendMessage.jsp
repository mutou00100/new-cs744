<%@ include file="realhead.jsp"%>
<script type="text/javascript">
	function check() {
	var message = document.getElementById("message").value;
	var ori = document.getElementById("ori").value;
	if ($('#ori').val()== null || $('#dest').val()== null) {
		alert("Please chooose both sender and receiver node!");
		return false;
	}
	if ( message == null ||message == "") {
		alert("Message can be null!");
		return false;
	}
	if (inactivelist.indexOf(parseInt(ori))>=0) {	
		alert("You can't send message from inactive node!");
		return false;
	}
	return true;
}
function sendMessageInMain() {
	var message =  document.getElementById("message").value;
	var ori = document.getElementById("ori").value;
	var dest = document.getElementById("dest").value;
	sendMessage(ori, dest, message, ori);
}
</script>
<div class="span10" id="datacontent">
	<p><b>Send Message</p>				
					<table class="table">
						
						<tbody>
							<tr>
								<td class="span2"><select name="ori" id= "ori">
										<option disabled selected value> -- sender -- </option>
										<%
											if (allNonDnodes != null && allNonDnodes.size() != 0) {
												for (int i = 0; i < allNonDnodes.size(); i++) {
													int node = allNonDnodes.get(i);
													out.println("<option value = " +  node + ">" +  node
															+ "</option>");
												}
											}
										%>
								</select>
								</td>
								<td class="span2"><select name="dest" id= "dest">
										<option disabled selected value> -- receiver -- </option>
										<%
											if (allNonDnodes != null && allNonDnodes.size() != 0) {
												for (int i = 0; i < allNonDnodes.size(); i++) {
													int node = allNonDnodes.get(i);
													out.println("<option value = " +  node + ">" +  node
															+ "</option>");
												}
											}
										%>
								</select>
								</td>
								<td>message:</td>
								<td class="input"><input class="input-small" id= "message" name="message"
									size="10" type="text" value="" maxlength="50"></input></td>
								<td>
									<button class="btn btn-primary" type="submit"
									 onclick = "if(check()){sendMessageInMain();}">Send</button>
								</td>
							</tr>
						</tbody>
					</table>
					</div>
