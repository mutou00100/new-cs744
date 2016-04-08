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
var res = <%=res%>;

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
$('#domainIdforPattern').change(function() {
    var dNode = $('#domainIdforPattern').val();
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
        	var s =''
        	for(i=0;i<belongC.length;i++){
        		s+='<input type="checkbox" id = "belongC" name= "belongC" value=' + belongC[i] +'>'+belongC[i]
        	}
            document.getElementById('containerForConnector').innerHTML=s
        	}
        });
});
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
							<td><select name="dID" id= "domainIdforPattern" class="span1">
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
								<td id = "containerForConnector"class="span10"></td>
								<td class="span3">
									<a class="btn btn-primary" onclick = "if (check()){addConnector();}" type="submit">Generate Pattern</a>
								</td>
							</tr>
						</tbody>
					</table></div>