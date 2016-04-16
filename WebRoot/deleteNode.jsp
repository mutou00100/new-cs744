<%@ include file="realhead.jsp"%>
<script type="text/javascript" >
function check() {
	if ($('#dID').val()== null || $('#cID').val()== null || $('#nID').val()== null) {
		alert("Please select one node!");
		return false;
	} else {
		var length = $('#nID').children('option').length;
		if (length > 2 && $('#nID').val()==$('#cID').val()) {
			alert("You can't delete a connector node when the pattern has non-connecotor node");
			return false;
		} else if (confirm("Are you sure you want to delete node " + $('#nID').val()+"?")) {
			return true;
		} 
	}
	return false;}

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
        	$("#cID").append("<option value='" + belongC[i] + "'>Connector: " + belongC[i] + "</option>");
        	}}
        });
});
$('#cID').change(function(){
	 var cNode = $('#cID').val();
	 var dNode = $('#dID').val();
 	  var data={"cNode":cNode};
	var mydata=JSON.stringify(data);
	$.ajax({
	        type : "POST",
	        url : "showNforC",
	        data: mydata,
	        contentType: 'application/json;charset=UTF-8',
	       	success: function(result){obj=JSON.parse(result);
 	        	var belongN=obj['belongN'];
 	        	$("#nID").html("<option disabled selected value> -- select a Node -- </option><option value="+ cNode + ">Connector: " + cNode + "</option>");
 	        	for(var i=0;i<belongN.length;i++){
 	        	$("#nID").append("<option value='" + belongN[i] + "'>" + belongN[i] + "</option>");
 	        	}}
 	        });
 	    });
});
</script>
			<div class="span12" id="datacontent">
			<p><b>Delete Node</p>
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
													out.println("<option value = " +  domain + ">Domain: " +  domain
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
                <option disabled selected value> -- select a Node -- </option>
            </select></td>
								<td>
									<a class="btn btn-primary" type="submit" onclick="if (check()){deleteNode();}">Delete</a>
								</td>
							</tr>
						</tbody>
					</table>
				</div>