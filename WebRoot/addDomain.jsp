<%@ include file="realhead.jsp"%>
<script type="text/javascript">
function check() {
	var len = document.querySelectorAll('input[type="checkbox"]:checked').length;
	var x = document.getElementsByName("checkedC").length;
	if (x != 0&&len == 0 ) {
		alert("You must select at least one domain!");
		return false;
	}
	return true;
}
var resD = <%=resD%>;
function addCheckList(newValue){
var box = document.getElementById('containerForConnector');
var checkbox = document.createElement('input');
checkbox.type = "checkbox";
checkbox.name = "checkedC";
checkbox.value = newValue;
checkbox.id = "checkedC";

box.appendChild(checkbox);
box.appendChild(document.createTextNode(newValue));
}
</script>
<div class="span14" id="datacontent">
		<table class="table">
						<thead>
							<tr>
								<th colspan="5">Add Domain</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td id = "containerForConnector"class="span10"><% 
    	if (resD.size() != 0) {
    	 out.println("Please choose the neighbor domains");}
    	for (int i = 0; i < resD.size(); i++) {
    		out.print("<input type=\"checkbox\" id = \"checkedC\" name= \"checkedC\" value= "+resD.get(i)+">" + resD.get(i));
    	} %></td>
						
								<td class="span3">
									<a class="btn btn-primary" onclick = "if (check()){addDomain();}" type="submit">Generate Domain</a>
								</td>
							</tr>
						</tbody>
					</table></div>