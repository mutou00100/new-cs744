<%@ include file="realhead.jsp"%>
<script type="text/javascript" >
function check() {
	if ($('#dID').val()== null ||$('#cID').val()== null) {
		alert("Please chooose a pattern!");
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
        	$("#cID").html("<option disabled selected value> -- select a Pattern -- </option>");
        	$("#nID1").html("<option disabled selected value> -- select a Node -- </option>");
        	$("#nID2").html("<option disabled selected value> -- select a Node -- </option>");
        	for(i=0;i<belongC.length;i++){
        	$("#cID").append("<option value='" + belongC[i] + "'>" + belongC[i] + "</option>");
        	}}
        });
});
$('#cID').change(function(){
	 var cNode = $('#cID').val();
  	  var data={"cNode":cNode};
	var mydata=JSON.stringify(data);
	$.ajax({
	        type : "POST",
	        url : "showNforC",
	        data: mydata,
	        contentType: 'application/json;charset=UTF-8',
	       	success: function(result){obj=JSON.parse(result);
  	        	var belongN=obj['belongN'];
  	        	$("#nID1").html("<option disabled selected value>- select Neighbor Node 1 -</option>");
  	        	$("#nID2").html("<option disabled selected value>- select Neighbor Node 2 -</option>");
  	        	for(i=0;i<belongN.length;i++){
  	        	$("#nID1").append("<option value='" + belongN[i] + "'>" + belongN[i] + "</option>");
  	        	}}
  	        });
  	    });
$('#nID1').change(function(){
	var node = $('#nID1').val();
	var cNode = $('#cID').val();
	  var data={"cNode":cNode};
	var mydata=JSON.stringify(data);
	$.ajax({
	        type : "POST",
	        url : "showNforC",
	        data: mydata,
	        contentType: 'application/json;charset=UTF-8',
	       	success: function(result){obj=JSON.parse(result);
	        	var belongN=obj['belongN'];
	        	var index = belongN.indexOf(parseInt(node));
	        	if (index > -1) {
	        	    belongN.splice(index, 1);
	        	}
	        	$("#nID2").html("<option disabled selected value>- select Neighbor Node 2 -</option>");
	        	for(i=0;i<belongN.length;i++){
	        	$("#nID2").append("<option value='" + belongN[i] + "'>" + belongN[i] + "</option>");
	        	}}
	        });
});
});
</script>
			<div class="span12" id="datacontent">
<p><b>Add Non-connector Node</p>
					<table class="table">
						<tbody>
							<tr>
								<td><select name="dID" id= "dID" class="span1">
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
								<td id="ctd"><select id="cID">  
                <option disabled selected value> -- select a Pattern -- </option>
            </select> 
            </td>
								<td id="ntd"><select id="nID1">  
                <option disabled selected value> - select Neighbor Node 1 - </option> 
            </select>  </td>
            <td id="ntd"><select id="nID2">  
                <option disabled selected value> - select Neighbor Node 2 - </option> 
            </select>  </td>
            <td><input type="checkbox" name="connectToC" value="yes">Connect To Connector Node</td>
            <td><a class="btn btn-primary"  onclick = "if (check()){addNonNode();}" type="submit">Generate Node</a></td>
							</tr>
						</tbody>
					</table>
			</div>