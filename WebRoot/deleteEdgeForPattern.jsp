<%@ include file="realhead.jsp"%>
<script type="text/javascript" >
function check() {
	if ($('#dID').val()== null ||$('#cID1').val()== null||$('#cID2').val()== null) {
		alert("Please chooose a connection!");
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
        	var obj=JSON.parse(result);
        	var belongC=obj['belongC'];
        	$("#cID1").html("<option disabled selected value> -- select a Pattern -- </option>");
        	$("#cID2").html("<option disabled selected value> -- select a Pattern -- </option>");
        	for(i=0;i<belongC.length;i++){
        	$("#cID1").append("<option value='" + belongC[i] + "'>" + belongC[i] + "</option>");
        	}}
        });
});
$('#cID1').change(function(){
	var node = $('#cID1').val();
    var type="CC";
    var data={"type":type,"node":node}
	var mydata=JSON.stringify(data)
	$.ajax({
        type : "POST",
        url : "searchConnectedNode",
        data: mydata,
        contentType: 'application/json;charset=UTF-8',
        success: function(result){
        	var obj=JSON.parse(result);
        	var cNeighbour=obj['neighbour'];
        	$("#cID2").html("<option disabled selected value> -- select a Pattern -- </option>");
        	for(i=0;i<cNeighbour.length;i++){
        	$("#cID2").append("<option value='" + cNeighbour[i] + "'>" + cNeighbour[i] + "</option>");
        }}
	});
  	    });
});
</script>
			<div class="span12" id="datacontent">
<p><b>Delete Connection Between Pattern</p>
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
								<td class="span2">
								<select id="cID1">  
                <option disabled selected value> -- select a Pattern -- </option>
            </select>
								</td>
								<td>Pattern:</td>
								<td class="span2"><select id="cID2">  
                <option disabled selected value> -- select a Pattern -- </option>
            </select>
								</td>
								<td>
									<a class="btn btn-primary" type="submit" onclick="if (check()){deleteCC();}">Delete</button></a>
								</td>
							</tr>
						</tbody>
					</table>