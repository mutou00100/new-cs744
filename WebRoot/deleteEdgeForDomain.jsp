<%@ include file="realhead.jsp"%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"> </script>
<script type="text/javascript" >
$(document).ready(function() {
$('#dID1').change(function() {
    var node = $('#dID1').val();
    var res=<%=res1%>;
    var index = res.indexOf(parseInt(node));
	if (index > -1) {
	    res.splice(index, 1);
	}
    $("#dID2").html("<option disabled selected value> -- select an Pattern -- </option>");
	for(i=0;i<res.length;i++){
	$("#dID2").append("<option value='" + res[i] + "'>" + res[i] + "</option>");
	}
});
});
</script>
			<div class="span12" id="datacontent">

					<table class="table">
						<thead>
							<tr>
								<th colspan="5">Delete Edge For Domain</th>
							</tr>
						</thead>
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
            <td><a class="btn btn-primary"  onclick = "deleteDD()" type="submit">Delete</a></td>
							</tr>
						</tbody>
					</table>
			</div>