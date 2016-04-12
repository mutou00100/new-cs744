<div class="span10" id="datacontent">	
<table class="table">
						<thead>
							<tr>
								<th colspan="5">Search By User ID:</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td class="span4">User ID:</td>
								<td class="span1"><input type="text" id = "uId" name="destination" /></td>
								<td class="span6">
								<button type="button" onclick="checkUsers()" data-toggle="modal" data-target="#myModal3" >Recieved Message</button>
								</td>
							</tr>
						</tbody>		
					</table>
</div>

	<!-- Modal -->
  <div class="modal fade" id="myModal5" role="dialog">
    <div class="modal-dialog">
    
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h4 class="modal-title">User list
          </h4>
        </div>
        <div class="modal-body"> 
          <table id="example1" class="display" cellspacing="0" width="100%">
        <thead>
            <tr>
                <th>ID</th>
                <th>First</th>
                <th>Last Name</th>
                <th>Option</th>
            </tr>
        </thead>
        <tfoot>
            <tr>
                <th>ID</th>
                <th>First Name</th>
                <th>Last Name</th>
                <th>Option</th>
            </tr>
        </tfoot>
        <tbody id="rtbody">
</tbody>
    </table>
             </div>
<script>
function createRTbody(L){
	 if (table!=undefined){
         table.destroy();
       }
  var  s="";
  //[[137,142,'2016-04-01 14:09:16','123']]"
for(var i=0;i<L.length;i++){
    s+='<tr><td>'+L[i][0]+'</td><td>'+L[i][1]+'</td><td>'+L[i][2]+'</td><td>'+L[i][3]+'</td></tr>';
        }
        document.getElementById('rtbody').innerHTML=s;
       
        table = $('#example1').DataTable( {
        "lengthMenu": [[5, 10, 15, -1], [5, 10, 15, "All"]],
        "order": [[ 3, "desc" ]]
    } );$("#myModal5").modal("show");
      }
</script>
        <div class="modal-footer">
          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        </div>
      </div></div></div>
</body>
</html>