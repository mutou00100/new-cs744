<%@ include file="realhead.jsp"%>
<script type="text/javascript">
	var message = document.getElementById("message").value;
	var ori = document.getElementById("ori").value;
	var dest = document.getElementById("dest").value;
function check() {
	if (ori == null || dest == null) {
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
	sendMessage(ori, dest, message, ori);
}

var updateActivelist = {
update:function(){
	$.ajax({
        type : "POST",
        url : "getAllActiveNodes",
        data: mydata,
        contentType: 'application/json;charset=UTF-8',
        success: function(result){
        	var obj=JSON.parse(result);
        	var curlist=obj['activelist'];
        	$("#ori").html("<option disabled selected value> -- sender -- </option>");
        	for(var i=0;i<curlist.length;i++){
        	$("#ori").append("<option value='" + curlist[i] + "'>" + curlist[i] + "</option>");
        	}}
        });
}
};
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
										<option disabled selected value> -- sender -- </option>
										<%
											if (inactivelist != null && inactivelist.size() != 0) {
												for (int i = 0; i < inactivelist.size(); i++) {
													int node = inactivelist.get(i);
													out.println("<option value = " +  node + ">" +  node
															+ "</option>");
												}
											}
										%>
								</select>
								<td class="span2"><select name="dest" id= "dest">
										<option disabled selected value> -- receiver -- </option>
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
