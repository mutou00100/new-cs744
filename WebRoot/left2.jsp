<%@ include file="head.jsp"%>
<head>
  <title>Bootstrap Example</title>
 
<meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
  <link href="https://cdn.datatables.net/1.10.11/css/jquery.dataTables.min.css" rel="stylesheet">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
  <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
  <script src="https://code.jquery.com/jquery-1.12.0.min.js"></script>
    <script src="https://cdn.datatables.net/1.10.11/js/jquery.dataTables.min.js"></script>
</head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<style>

.list-group { 
	margin-left:1%;
    min-width: 40px;
    width: 15%;
    float:left;
    vertical-align: middle;
    
 }
 .list-group button{
  background-color: #FFFFFF;
 }
 
div#one{
float:left;
margin-right:80%;
}
div#two{
margin-left:20%;
}
  </style>
<body>

<div id = "show"></div>
<section>
 <div class="list-group">
		<%if (request.getSession().getAttribute("firstname") == "admin"){%>
		<% out.print("<li><button=\"addUser.jsp\" target=\"frame3\">Add a User</a></li>");%>
		<% out.print("<li><a href=\"listUser.action\" target=\"frame3\">Check Users</a></li>");}%>
   		<button id = "addNode" type="button" class="list-group-item" onClick="show(this.id)">Add Non-Connector Node</button>
		<button id = "addPattern" type="button" class="list-group-item" onClick="show(this.id)">Add Pattern</button>		
		<button id = "deleteNode" type="button" class="list-group-item" onClick="show(this.id)">Delete Node</button>
		<button id = "sendMessage" type="button" class="list-group-item" onClick="show(this.id)">Send Message</button>
		<button id = "activateNode" type="button" class="list-group-item" onClick="show(this.id)">Activate Node</button>
		<button id = "inactivateNode" type="button" class="list-group-item" onClick="show(this.id)">Inactivate Node</button>
		<button id = "blockedMessage" type="button" class="list-group-item" onclick="createTbody()" data-toggle="modal" data-target="#myModal">Open Modal</button>
	</div>
	<div id = "two"><%@ include file="footer.jsp"%></div></section>
<script>
	function show(id) {
		if (id == "addNode") {
			 $('#show').load('addNode.jsp');
		} else if (id == "addPattern"){
			$('#show').load('addConnector.jsp');
		}else if (id == "deleteNode"){
			$('#show').load('deleteNode.jsp');
		}else if (id == "sendMessage"){
			$('#show').load('sendMessage.jsp');
		}else if (id == "activateNode"){
			$('#show').load('activateNode.jsp');
		}else if (id == "inactivateNode"){
			$('#show').load('inactivateNode.jsp');
		}
	}
</script>
			 <!-- Modal -->
  <div class="modal fade" id="myModal" role="dialog">
    <div class="modal-dialog">
    
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h4 class="modal-title">Blocked Messages list
          </h4>
        </div>
        <div class="modal-body"> 
          <table id="example" class="display" cellspacing="0" width="100%">
        <thead>
            <tr>
                <th>Current</th>
                <th>Original</th>
                <th>Destination</th>
                <th>Date</th>
                <th>Content</th>
            </tr>
        </thead>
        <tfoot>
            <tr>
                <th>Current</th>
                <th>Original</th>
                <th>Destination</th>
                <th>Date</th>
                <th>Content</th>
            </tr>
        </tfoot>
        <tbody id="tbody">
<script>
table;
function createTbody(){
  L=blockedlist;
  s="";
for(var i=0;i<L.length;i++){
    s+='<tr><td>'+L[i][0]+'</td><td>'+L[i][1]+'</td><td>'+L[i][2]+'</td><td>'+L[i][3]+'</td><td>'+L[i][4]+'</td></tr>'
        }
        document.getElementById('tbody').innerHTML=s;
        if (table!=undefined){
          table.destroy();
        }
        table = $('#example').DataTable( {
        "lengthMenu": [[5, 10, 15, -1], [5, 10, 15, "All"]],
        "order": [[ 3, "desc" ]]
    } );

        $("#myModal").modal("show");
      }
</script>
</tbody>
    </table>
             </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        </div>
      </div>
      
    </div>
  </div>
<script>
$('#example').DataTable( {
        "lengthMenu": [[5, 10, 15, -1], [5, 10, 15, "All"]],
        "order": [[ 3, "desc" ]]
    } );
stack=[]
function receiveStack(n){
		for(i=0;i<bolcklist.length();i++){
			if(blocklist[i][0]==n){
				stack.push([blocklist[i]])
			}
		}
		if(stack!=[]){
		resend(stack.pop())}
			}
function resend(L){
		cur=L[0]
		dest=L[2]
		msg=L[4]
		ori=L[1]
		sendMessage(cur,dest,msg,ori)
		var index = blocklist.indexOf(L)
		if (index > -1) {
    		blocklist.splice(index, 1);
		}
}
</script>
</body>