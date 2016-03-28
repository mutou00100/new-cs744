<%@ include file="head_without_jsp.jsp"%>
<%@ page import="com.utils.SeparatePage"%>
<%
SeparatePage sp = (SeparatePage) request.getAttribute("sp");
String spStr = sp.getSeparateString();
HttpServletResponse resp=(HttpServletResponse) response;
List<Message> userList = sp.getSearchData();
String idKey = (String) request.getAttribute("destination");
String role = (String) session.getAttribute("role");
String cols = "4";
String isAdmin = null;
String userid = (String) session.getAttribute("currId");
%>

<div class="span14" id="datacontent">
					
		<table width="1100" class="table">
			<%if (userList != null && userList.size() != 0) {%>
			<p><tr>
			    <th>Date</th>
				<th>Sender</th>
				<th>Receiver</th>
				<th>Content</th>

			</tr></p>


			<%
				//to get from the database
								if (userList != null && userList.size() != 0)
								{
									for (int i = 0; i < userList.size(); i++)
									 {
										Message user = userList.get(i);
											String id = user.getId();
											int ori = user.getOrigin();
											int dest = user.getDestination();
											String content = user.getContent();
			%>

			<tr>
				<td><%=id%></td>
				<td><%=ori%></td>
				<td><%=dest%></td>
				<td><%=content%></td>

			</tr>
			<%
				}
			%>
			<tr>
				<td colspan="22"><%=spStr%></td>
			</tr>
			<%
				} 	
						else { out.println("<tr><td colspan='21'>not found </td></tr>");}
			}%>
			
		</table>
</div>
		</div>
	</div>
</body>
</html>