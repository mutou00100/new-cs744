<%@ include file="realhead.jsp"%>
<script type="text/javascript">
function check() {
	var ori = document.getElementById("ori").value;
	var dest = document.getElementById("dest").value;
	var message = document.getElementById("message").value;
	if ( ori==""|| dest ==""||message == "") {
		alert("None of sender, receiver node and message can be null");
		return false;
	}
	var nubmer1 = parseInt(document.getElementById("ori").value);
	var nubmer2 = parseInt(document.getElementById("dest").value);
	if (ori !=""&&(nubmer1<=0||!(/^\d+$/.test(nubmer1)))){
			 alert("Please enter a Integer!");
     return false;
		}
		if (dest !=""&&(nubmer2<=0||!(/^\d+$/.test(nubmer2)))){
			alert("Please enter a Integer!");
			return false;
		}
	return true;
}
function sendMessageInMain() {
	var ori= document.getElementById('ori').value;
	var dest= document.getElementById('dest').value;
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
								<td>sender:</td>
								<td class="span2"><select name="ori" id= "ori">
										<%
											if (allnodes != null && allnodes.size() != 0) {
												for (int i = 0; i < allnodes.size(); i++) {
													if (allnodes.get(i).getStatus()==0){
													int pattern = allnodes.get(i).getnID();
													out.println("<option value = " +  pattern + ">" +  pattern
															+ "</option>");
													}
												}
											}
										%>
								</select></td>
								<td>receiver:</td>
								<td class="span2"><select name="dest" id= "dest">
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
