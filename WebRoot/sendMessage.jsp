<%@ include file="realhead.jsp"%>
<script type="text/javascript">
function check() {
	var message = document.getElementById("message").value;
	var ori = document.getElementById("ori").value;
	var dest = document.getElementById("dest").value;
	if (ori == 0 || dest == 0) {
		alert("Please chooose both sender and receiver node!");
		return false
	}
	if ( message == null ||message == "") {
		alert("Message can be null!");
		return false;
	}
	return true;
}
function sendMessageInMain() {
	var ori= document.getElementsByName('ori')[0].value;
	var dest= document.getElementsByName('dest')[0].value;
	var message= document.getElementById('message').value;
	sendMessage(ori, dest, message, ori);
}
</script>
<div class="span10" id="datacontent">
					
					<table class="table">
						<thead>
							<tr>
								<th colspan="5">Send Message</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td class="span2"><select name="ori" id= "ori">
										<option value="0">Sender</option>
										<%
											if (allPatterns != null && allNonDnodes.size() != 0) {
												for (int i = 0; i < allNonDnodes.size(); i++) {
													int node = allNonDnodes.get(i);
													out.println("<option value = " +  node + ">" +  node
															+ "</option>");
												}
											}
										%>
								</select>
								<td class="span2"><select name="dest" id= "dest">
										<option value="0">Receiver</option>
										<%
											if (allPatterns != null && allNonDnodes.size() != 0) {
												for (int i = 0; i < allNonDnodes.size(); i++) {
													int node = allNonDnodes.get(i);
													out.println("<option value = " +  node + ">" +  node
															+ "</option>");
												}
											}
										%>
								</select>
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
