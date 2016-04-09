<%@ include file="realhead.jsp"%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"> </script>
<script type="text/javascript" > 
function check() {
	if ($('#dID1').val()== null ||$('#dID2').val()== null) {
		alert("Please chooose two nodes to connect!");
		return false;
	}
	return true;
}
$(document).ready(function() {
$('#dID1').change(function() {
	var selection = <%=res1%>
    var node = $('#dID1').val();
	var index = selection.indexOf(parseInt(node));
       	if (index > -1) {
       	    selection.splice(index, 1);
       	}
     	$("#dID2").html("<option disabled selected value> -- select an Domain -- </option>");
     	for(i=0;i<selection.length;i++){
     	$("#dID2").append("<option value='" + selection[i] + "'>" + selection[i] + "</option>");
     	}
        });
}); 
</script>
			<div class="span12" id="datacontent">

					<table class="table">
						<thead>
							<tr>
								<th colspan="5">Add Edge Between Domain</th>
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