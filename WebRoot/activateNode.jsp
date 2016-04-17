<%@ include file="realhead.jsp"%>

<script type="text/javascript">

function check() {
	if ($('#nID').val()== null||$('#nID').val()== null||$('#nID').val()== null) {
		alert("Please chooose a node!");
		return false;
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
        	obj=JSON.parse(result);
        	belongC=obj['belongC'];
        	$("#cID").html("<option disabled selected> -- select a Pattern -- </option>");
        	$("#cID").append("<option value = '0'>select no Pattern</option>");
        	for(i=0;i<belongC.length;i++){
        	$("#cID").append("<option value='" + belongC[i] + "'> Connector: " + belongC[i] + "</option>");
        	}
        	$("#nID").html("<option disabled selected value> -- select a Node -- </option>");
        	}
        });
});
$('#cID').change(function(){
	 var cNode = $('#cID').val();
	 if (cNode == '0') {
	 	$("#nID").html("<option disabled selected value> -- select a Node -- </option>");
	  	$("#nID").append("<option value ='" + $('#dID').val() + "'>" + "Domain: "+ $('#dID').val() + "</option>");
	 } else {
  	  var data={"cNode":cNode};
	  var mydata=JSON.stringify(data);
		$.ajax({
		        type : "POST",
		        url : "showNforC",
		        data: mydata,
		        contentType: 'application/json;charset=UTF-8',
		       	success: function(result){obj=JSON.parse(result);
	  	        	var belongN=obj['belongN'];
	  	        	$("#nID").html("<option disabled selected value> -- select a Node -- </option>");
	  	        	$("#nID").append("<option value ='" + cNode + "'>" + "Connector: "+ cNode + "</option>");
	  	        	for(i=0;i<belongN.length;i++){
	  	        	$("#nID").append("<option value='" + belongN[i] + "'>" + belongN[i] + "</option>");
	  	        	}}
	  	        });
	  	      }
	  	    });
});
</script>
			<div class="span10" id="datacontent">
			<p><b>Activate Node</p>
					<table class="table">
						<tbody>
							<tr>
								<td><select name="dID" id= "dID" class="span1">
								<option disabled selected value> -- select a Domain -- </option>
										<%
											if (res1 != null && res1.size() != 0) {
												for (int i = 0; i < res1.size(); i++) {
													int domain = res1.get(i);
													out.println("<option value = " +  domain + "> Domain: " +  domain
															+ "</option>");
												}
											}
										%>
								</select></td>
								<td id="ctd"><select id="cID">  
                <option disabled selected value> -- select a Pattern -- </option>
            </select> 
            </td>
								<td id="ntd"><select id="nID">  
                <option disabled selected value> -- select a Node -- </option> 
            </select>  </td>
								<td class="span4">
									<button class="btn btn-primary" onclick = "if (check()){activateNode();}" type="submit">Activate</button>
								</td>
							</tr>
						</tbody>
					</table>
				</div>