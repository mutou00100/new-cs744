<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ include file="realhead.jsp"%>
<script type="text/javascript">
	function del() {
		if (confirm("Are you sure you want to delete that student?")) {
			return true;
		}
		return false;
	}
</script>
			<div class="span10" id="datacontent">
				<ul class="breadcrumb">
					<li><a href="/cs744/jsp/addUser.jsp">Add a User</a><span
						class="divider">/</span></li>
					<li class="active">All Users</li>
				</ul>
				<ul class="nav nav-tabs">
					<li class="active"><a>The list of users</a></li>
				</ul>
				<table class="table table-hover">
					<thead>
						<tr>
							<th>ID</th>
							<th>First Name</th>
							<th>Last Name</th>
							<th>Operation</th>
						</tr>
					</thead>
					<s:iterator value="#request.ulist" id="user">
						<tbody>
							<tr>
								<td><s:property value="#user.uid" /></td>
								<td><s:property value="#user.firstName" /></td>
								<td><s:property value="#user.lastName" /></td>
								<td>
									<div>
										<s:a href="deleteUser.action?uid=%{#user.uid}"
											onclick="return del();">
											<span class="btn btn-danger"><i class="icon-trash"></i>Delete</span>
										</s:a>
									</div>
								</td>
							</tr>
						</tbody>
					</s:iterator>
				</table>
			</div>
		</div>
	</div>
</body>
</html>