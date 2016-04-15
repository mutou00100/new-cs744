<%@ include file="realhead.jsp"%>
<script type="text/javascript" >
function check() {
	if ($('#dID').val()== null ||$('#cID').val()== null||$('#nID').val()== null) {
		alert("Please chooose a connection!");
		return false;
	}
	return true;
}
$(document).ready(function() {
$('#dID').change(function() {
    var dNode = $('#dID').val();
    var data={"dNode":dNode};
	var mydata=JSON.stringify(data);
	$.ajax({
        type : "POST",
        url : "showCforD",
        data: mydata,
        contentType: 'application/json;charset=UTF-8',
        success: function(result){
        	var obj=JSON.parse(result);
        	var belongC=obj['belongC'];
        	$("#cID").html("<option disabled selected value> -- select a Pattern -- </option>");
        	$("#nID").html("<option disabled selected value> -- select a Node -- </option>");
        	for(var i=0;i<belongC.length;i++){
        	$("#cID").append("<option value='" + belongC[i] + "'>" + belongC[i] + "</option>");
        	}}
        });
});
$('#cID').change(function(){
	 var cNode = $('#cID').val();
	 var type="CN";
 	  var data={"node":cNode,"type":type};
	var mydata=JSON.stringify(data);
	$.ajax({
	        type : "POST",
	        url : "searchConnectedNode",
	        data: mydata,
	        contentType: 'application/json;charset=UTF-8',
	       	success: function(result){obj=JSON.parse(result);
 	        	var connectedN=obj['neighbour'];
 	        	$("#nID").html("<option disabled selected value> -- select a Node -- </option>");
 	        	for(var i=0;i<connectedN.length;i++){
 	        	$("#nID").append("<option value='" +connectedN[i] + "'>" + connectedN[i] + "</option>");
 	        	}}
 	        });
 	    });
});
</script>
			<div class="span12" id="datacontent">
<p><b>Delete Connection Between Connector node and Non-Connector node</p>
					<table class="table">
						
						<tbody>
							<tr>
								<td>Domain:</td>
								<td class="input"><select name="dID" id= "dID" class="span1">
								<option disabled selected value> -- select a Domain -- </option>
										<%
											if (res1 != null && res1.size() != 0) {
												for (int i = 0; i < res1.size(); i++) {
													int domain = res1.get(i);
													out.println("<option value = " +  domain + ">" +  domain
															+ "</option>");
												}
											}
										%>
								</select></td>
					<td>Pattern:</td>
								<td class="input"><select id="cID">  
                <option disabled selected value> -- select a Pattern -- </option>
            </select></td>
            					<td>Node:</td>
								<td class="input"><select id="nID">  
                <option disabled selected value> -- select a Non-connector node -- </option>
            </select></td>
								<td>
									<a class="btn btn-primary" type="submit" onclick="if (check()){deleteCN();}">Delete</a>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
