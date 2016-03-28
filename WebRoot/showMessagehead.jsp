<%@ include file="head_without_jsp.jsp"%>
<%
String idKey = (String) request.getAttribute("destination");
if (idKey == null) {
	idKey = "";
}
%>

<div class="span10" id="datacontent">
<form id="form2" action="showMessage?method=show" target="frame3" method="post">	
<table class="table">
						<thead>
							<tr>
								<th colspan="5">Search By Receiver Node:</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td class="span4">Node ID:</td>
								<td class="span1"><input type="text" name="destination" value="<%=idKey%>" /></td>
								<td class="span6">
									<button class="btn btn-primary" type="submit">Search</button>
								</td>
							</tr>
						</tbody>		
					</table>
					</form>
</div>
</body>
</html>