<%@ include file="realhead.jsp"%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
<script type="text/javascript" >
function check() {
	if ($('#dID').val()== null ||$('#cID').val()== null||$('#nID').val()== null) {
		alert("Please chooose two nodes to connect!");
		return false
	}
	return true;
}
$(document).ready(function() {
$('#dID').change(function() {
    var dNode = $('#dID').val();
    var data={"dNode":dNode}
	var mydata=JSON.stringify(data)
	$.ajax({
        type : "POST",
        url : "showCforD",
        data: mydata,
        contentType: 'application/json;charset=UTF-8',
        success: function(result){
        	var obj=JSON.parse(result);
        	var belongC=obj['belongC'];
        	$("#cID").html("<option disabled selected value> -- select an Pattern -- </option>");
        	for(i=0;i<belongC.length;i++){
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
 	        	$("#nID").html("<option disabled selected value> -- select an Node -- </option>");
 	        	for(i=0;i<connectedN.length;i++){
 	        	$("#nID").append("<option value='" +connectedN[i] + "'>" + connectedN[i] + "</option>");
 	        	}}
 	        });
 	    });
});
</script>
			<div class="span12" id="datacontent">

					<table class="table">
						<thead>
							<tr>
								<th colspan="5">Delete Edge Between Connector node and Non-Connector node</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td class="input"><select name="dID" id= "dID" class="span1">
										<%
											if (res1 != null && res1.size() != 0) {
												out.println("<option disabled selected value> -- select an Domain -- </option>");
												for (int i = 0; i < res1.size(); i++) {
													int domain = res1.get(i);
													out.println("<option value = " +  domain + ">" +  domain
															+ "</option>");
												}
											}
										%>
								</select></td>
								<td class="input"><select id="cID">  
                <option disabled selected value> -- select an Pattern -- </option>
            </select></td>
								<td class="input"><select id="nID">  
                <option disabled selected value> -- select an Non-connector node -- </option>
            </select></td>
								<td>
									<a class="btn btn-primary" type="submit" onclick="deleteCN()">Delete</button>
								</td>
							</tr>
						</tbody>
					</table>