<%@ include file="realhead.jsp"%>
<script type="text/javascript">
function check() {
	var len = document.querySelectorAll('input[type="checkbox"]:checked').length;
	var x = <%=res%>.length;
	if (x != 0 && len == 0 ) {
		alert("You must select at least one pattern!");
		return false;
	}
	return true;
}
</script>
<div class="span14" id="datacontent">
		<table class="table">
						<thead>
							<tr>
								<th colspan="5">Add Pattern</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td class="span10"><% 
    	if (res.size() != 0) {
    	 out.println("Please choose the neighbor patterns");}
    	for (int i = 0; i < res.size(); i++) {
    		out.print("<input type=\"checkbox\" id = \"checkedC\" name= \"checkedC\" value= "+res.get(i)+">" + res.get(i));
    	} %></td>
						
								<td class="span3">
									<a class="btn btn-primary"  onclick = "if (check()){addConnector();}" type="submit">Generate Pattern</a>
								</td>
							</tr>
						</tbody>
					</table></div>