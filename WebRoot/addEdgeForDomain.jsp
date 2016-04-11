<%@ include file="realhead.jsp"%>
<script type="text/javascript" > 
function check() {
	if ($('#dID1').val()== null ||$('#dID2').val()== null) {
		alert("Please chooose two nodes to connect!");
		return false;
	}
	return true;
}
$('#dID1').change(function() {
    var node = $('#dID1').val();
    var type="DD";
    var data={"type":type,"node":node}
	var mydata=JSON.stringify(data)
	$.ajax({
        type : "POST",
        url : "searchNonConnectedNode",
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
</script>
			<div class="span12" id="datacontent">

					<table class="table">
						<thead>
							<tr>
								<th colspan="5">Add Connection Between Domain</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td><select name="dID1" id= "dID1" class="span1">
										<option disabled selected value>-- select an Domain --</option>
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
								<td id="ctd"><select id="dID2">  
                <option disabled selected value> -- select an Domain -- </option>
            </select> 
            </td>
            <td><a class="btn btn-primary"  onclick = "if (check()){addDD();}" type="submit">Add</a></td>
							</tr>
						</tbody>
					</table>
			</div>