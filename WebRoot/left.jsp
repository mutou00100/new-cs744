<%@ include file="head_without_jsp.jsp"%>
<meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
  <link href="https://cdn.datatables.net/1.10.11/css/jquery.dataTables.min.css" rel="stylesheet">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
  <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
  <script src="https://code.jquery.com/jquery-1.12.0.min.js"></script>
    <script src="https://cdn.datatables.net/1.10.11/js/jquery.dataTables.min.js"></script>
<script>
$('#example').DataTable( {
        "lengthMenu": [[5, 10, 15, -1], [5, 10, 15, "All"]],
        "order": [[ 3, "desc" ]]
    } );
</script>
<div class="container-fluid">
		<div class="row-fluid">
			<div class="span2">
				<ul class="nav nav-tabs nav-stacked">
					<%if (request.getSession().getAttribute("firstname") == "admin"){%>
					<% out.print("<li><a href=\"addUser.jsp\" target=\"frame3\">Add a User</a></li>");%>
					<% out.print("<li><a href=\"listUser.action\" target=\"frame3\">Check Users</a></li>");}%>
      				<li><s:a href="addNode.jsp" target="mainframe">Add Non-Connector Node</s:a></li>
					<li><s:a href="addConnector.jsp" target="mainframe">Add Pattern</s:a></li>			
  					<li><s:a href="deleteNode.jsp" target="mainframe">Delete Node</s:a></li>
  					<li><s:a href="sendMessage.jsp" target="mainframe">Send Message</s:a></li>
  					<li><s:a href="showMessagehead.jsp" target="mainframe">Show Message</s:a></li>
  					<li><s:a href="activateNode.jsp" target="mainframe">Activate Node</s:a></li>
  					<li><s:a href="inactivateNode.jsp" target="mainframe">Inactivate Node</s:a></li>
  					<li><s:a href="footer.jsp" target="frame3">Show Network</s:a></li>
  					<li><s:a href="footer.jsp" target="frame3">Show Network</s:a></li>
  					<li><s:a class="btn btn-info btn-lg" data-toggle="modal" data-target="#myModal" target="frame3">Open Modal</s:a></li>
				</ul>
			</div>