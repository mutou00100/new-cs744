<%@ include file="realhead.jsp"%>
<script type="text/javascript" >
function check() {
	if ($('#dID1').val()== null ||$('#dID2').val()== null) {
		alert("Please chooose a connection!");
		return false;
	}
	return true;
}
$(document).ready(function() {
$('#dID1').change(function() {
    var node = $('#dID1').val();
    var type="DD";
    var data={"type":type,"node":node}
	var mydata=JSON.stringify(data)
	$.ajax({
        type : "POST",
        url : "searchConnectedNode",
        data: mydata,
        contentType: 'application/json;charset=UTF-8',
        success: function(result){
        	var obj=JSON.parse(result);
        	var dNeighbour=obj['neighbour'];
        	$("#dID2").html("<option disabled selected value> -- select an Domain -- </option>");
        	for(i=0;i<dNeighbour.length;i++){
        	$("#dID2").append("<option value='" + dNeighbour[i] + "'>" + dNeighbour[i] + "</option>");
        	}
        }
	});
});
}); 
</script>
			<div class="span12" id="datacontent">
<p><b>Delete Connection Between Domain</p>
					<table class="table">
						
						<tbody>
							<tr>
								<td><select name="dID1" id= "dID1" class="span1">
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
								<td id="ctd"><select id="dID2">  
                <option disabled selected value> -- select an Domain -- </option>
            </select> 
            </td>
            <td><a class="btn btn-primary"  onclick = "if(check()){deleteDD();}" type="submit">Delete</a></td>
							</tr>
						</tbody>
					</table>
			</div>