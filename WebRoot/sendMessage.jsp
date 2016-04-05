<%@ include file="realhead.jsp"%>
<script type="text/javascript">
function check() {
	var message = document.getElementById("message").value;
	if ( message == null ||message == "") {
		alert("Message can be null");
		return false;
	}
	return true;
}
function sendMessageInMain() {
	var ori= document.getElementsByName('ori')[0].value;
	var dest= document.getElementsByName('dest')[0].value;
	var message= document.getElementById('message').value;
	var oid = document.getElementById('oid').value;
	var did = document.getElementById('did').value;
	if (!ori){
		ori = oid;
	}
	if (!dest){
		dest = did;
	}
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
								<td>sender:</td>
								<td class="span2"><select name="oid" id= "oid" onChange="getCity(this, document.getElementById('city1'))">
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
								<select id="city1" name="ori"></select></td>
								<td>receiver:</td>
								<td class="span2"><select name="did" id= "did" onChange="getCity(this, document.getElementById('city2'))">
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
								<select id="city2" name="dest"></select></td>
								<td>message:</td>
								<td class="input"><input class="input-small" id= "message" name="message"
									size="10" type="text" value=""></input></td>
								<td>
									<button class="btn btn-primary" type="submit"
									 onclick = "if(check()){sendMessageInMain();}">Send</button>
								</td>
							</tr>
						</tbody>
					</table>
					</div>
