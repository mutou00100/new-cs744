<%@ include file="head_without_jsp.jsp"%>
<%@ include file="head.jsp"%>
<head>
</head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<script>
	function add() {
		document.getElementById('myModal2').style.display = 'block';
	}
	function closediv_add() {
		document.getElementById('myModal2').style.display = 'none';
	}
</script>

<style>
.list-group {
	margin-left: 1%;
	min-width: 40px;
	width: 15%;
	float: left;
	vertical-align: middle;
}

.list-group button {
	background-color: #FFFFFF;
}

div#one {
	float: left;
	margin-right: 80%;
}

div#two {
	margin-left: 20%;
}
</style>
<body>

	<div id="show"></div>
	<section>
		<div class="list-group">
			<%
				if (request.getSession().getAttribute("firstname") == "admin"){
			%>
			<%
				out.print("<button id=\"checkUsers\" type=\"button\" class=\"list-group-item\" onClick=\"show(this.id)\">Check users</button>");				
				out.print("<button id=\"addUser\" type=\"button\" class=\"list-group-item\" onClick=\"show(this.id)\" data-toggle=\"modal\" data-target=\"#userModal\">Add User</button>");
				}
			%>
			<button id="addNode" type="button" class="list-group-item"
				onClick="show(this.id)">Add Non-Connector Node</button>
			<button id="addPattern" type="button" class="list-group-item"
				onClick="show(this.id)">Add Pattern</button>
			<button id="deleteNode" type="button" class="list-group-item"
				onClick="show(this.id)">Delete Node</button>
			<button id="sendMessage" type="button" class="list-group-item"
				onClick="show(this.id)">Send Message</button>
			<button id="activateNode" type="button" class="list-group-item" onClick="show(this.id)">Activate Node</button>
			<button id="inactivateNode" type="button" class="list-group-item"
				onClick="show(this.id)">Inactivate Node</button>
			<button id="addSecurityQuestion" type="button" class="list-group-item"
				onClick="add()" data-toggle="modal" data-target="#myModal2">Add Security Question</button>
			<button id = "Recieved Message" type="button" class="list-group-item" onclick="show(this.id)" >Recieved Message</button>
		<button id = "blockedMessage" type="button" class="list-group-item" onclick="createTbody()" data-toggle="modal" data-target="#myModal">Blocked Message</button>
		</div>
		<div id="two"><%@ include file="footer.jsp"%></div>
	</section>
	<script>
		function show(id) {
			if (id == "addNode") {
				$('#show').load('addNode.jsp');
			} else if (id == "addPattern") {
				$('#show').load('addConnector.jsp');
			} else if (id == "deleteNode") {
				$('#show').load('deleteNode.jsp');
			} else if (id == "sendMessage") {
				$('#show').load('sendMessage.jsp');
			} else if (id == "activateNode") {
				$('#show').load('activateNode.jsp');
			} else if (id == "inactivateNode") {
				$('#show').load('inactivateNode.jsp');
			} else if (id == "addUser") {
				$('#show').load('addUser.jsp');
			}else if (id == "changeSecurityQuestion") {
				$('#show').load('changeQuestion.jsp');
			}else if (id == "Recieved Message") {
				$('#show').load('receivedMessage.jsp');
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
                <th>Cur</th>
                <th>Ori</th>
                <th>Dest</th>
                <th>Date</th>
                <th>Msg</th>
            </tr>
        </thead>
        <tfoot>
            <tr>
                <th>Cur</th>
                <th>Ori</th>
                <th>Dest</th>
                <th>Date</th>
                <th>Msg</th>
            </tr>
        </tfoot>
        <tbody id="tbody">
</tbody>
    </table>
             </div><script>
function createTbody(){
	if (table!=undefined){
        table.destroy();
      }
  var L=blockedlist;
  var s="";
for(var i=0;i<L.length;i++){
    s+='<tr><td>'+L[i][0]+'</td><td>'+L[i][1]+'</td><td>'+L[i][2]+'</td><td>'+L[i][3]+'</td><td>'+L[i][4]+'</td></tr>'
        }
        document.getElementById('tbody').innerHTML=s;
        table = $('#example').DataTable({
        "lengthMenu": [[5, 10, 15, -1], [5, 10, 15, "All"]],
        "order": [[ 3, "desc" ]]
    } );
        $("#myModal").modal("show");
        
      }

function receiveStack(n){
		for(var i=0;i<blockedlist.length;i++){
			if(parseInt(blockedlist[i][0])==n){
				stack.push(blockedlist[i]);
			}
		}
		if(stack.length!=0){
		resend();}
			}
function resend(){
	if(stack!=undefined){
		if(stack.length!=0){
		var L=stack.pop();
		alert(L[0]);
		cur=L[0];
		dest=L[2];
		msg=L[4];
		ori=L[1];
		sendMessage(cur,dest,msg,ori);
		//sendMessage(cur, dest, message, ori)
		var index = blockedlist.indexOf(L);
		if (index > -1) {
    		blockedlist.splice(index, 1);
		}
	}}
}
</script>
        <div class="modal-footer">
          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        </div>
      </div>
      
    </div>
  </div>
	<!-- Modal -->
	<div id="myModal2" class="modal fade">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title">Add Security Question</h4>
				</div>
				<div class="modal-body">
					<div class="control-group">
						<div class="controls">
							<textarea class="form-control" rows="5" id="content"
								name="content"></textarea>
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
					<input class="btn btn-primary" onClick="addQuestion();"
						value="submit" />
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>
	<!-- /.modal -->    
    </div>
  </div>
</body>