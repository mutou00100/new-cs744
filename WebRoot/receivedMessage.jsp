<%@ include file="realhead.jsp"%>
<script type="text/javascript" >
function check() {
	if ($('#dID').val()== null||$('#cID').val()== null||$('#nID').val()== null) {
		alert("You must choose a node !");
		return false;
	}
	return true;
}
$(document).ready(function() {
$('#dID').change(function() {
    var dNode = $('#dID').val();
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
        	$("#cID").html("<option disabled selected value> -- select a Pattern -- </option>");
        	for(i=0;i<belongC.length;i++){
        	$("#cID").append("<option value='" + belongC[i] + "'> Connector: " + belongC[i] + "</option>");
        	}
        	$("#nID").html("<option disabled selected value> -- select a Node -- </option>");
        	}
        });
});
$('#cID').change(function(){
	 var cNode = $('#cID').val();
  	  var data={"cNode":cNode};
	var mydata=JSON.stringify(data);
	$.ajax({
	        type : "POST",
	        url : "showNforC",
	        data: mydata,
	        contentType: 'application/json;charset=UTF-8',
	       	success: function(result){obj=JSON.parse(result);
  	        	var belongN=obj['belongN'];
  	        	$("#nID").html("<option disabled selected value> -- select a Node -- </option>");
  	        	$("#nID").append("<option value ='" + cNode + "'>" + "Connector: "+ cNode + "</option>");
  	        	for(i=0;i<belongN.length;i++){
  	        	$("#nID").append("<option value='" + belongN[i] + "'>" + belongN[i] + "</option>");
  	        	}}
  	        });
  	    });
});
$('#messageTemp').click(function() {
	if (check())
	{receivedMessage();
	document.getElementById('messageTemp').setAttribute("data-target","#myModal3");
} else {
	document.getElementById('messageTemp').setAttribute("data-target","");
	
}});
</script>
			<div class="span12" id="datacontent">
<p><b>Search By Receiver Node</p>
					<table class="table">
						
						<tbody>
							<tr>
								<td><select name="dID" id= "dID" class="span1">
								<option disabled selected value> -- select a Domain -- </option>
										<%
											if (res1 != null && res1.size() != 0) {
												for (int i = 0; i < res1.size(); i++) {
													int domain = res1.get(i);
													out.println("<option value = " +  domain + "> Domain: " +  domain
															+ "</option>");
												}
											}
										%>
								</select></td>
								<td id="ctd"><select id="cID">  
                <option disabled selected value> -- select a Pattern -- </option>
            </select> 
            </td>
								<td id="ntd"><select id="nID">  
                <option disabled selected value> -- select a Node -- </option> 
            </select>  </td>
            <td>
           <button class="btn btn-primary" id = "messageTemp"type="button" data-toggle="modal" >Recieved Message</button>
							</td>
						</tbody>
					</table>
			</div>
	<!-- Modal -->
  <div class="modal fade" id="myModal3" role="dialog">
    <div class="modal-dialog">
    
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h4 class="modal-title">Received Messages list
          </h4>
        </div>
        <div class="modal-body"> 
          <table id="example1" class="display" cellspacing="0" width="100%">
        <thead>
            <tr>
                <th>Ori</th>
                <th>Dest</th>
                <th>Date</th>
                <th>Msg</th>
            </tr>
        </thead>
        <tfoot>
            <tr>
                <th>Ori</th>
                <th>Dest</th>
                <th>Date</th>
                <th>Msg</th>
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
    s+='<tr><td>'+L[i][0]+'</td><td>'+L[i][1]+'</td><td>'+L[i][2]+'</td><td>'+L[i][3]+'</td></tr>'
        }
        document.getElementById('rtbody').innerHTML=s;
       
        table = $('#example1').DataTable( {
        "lengthMenu": [[5, 10, 15, -1], [5, 10, 15, "All"]],
        "order": [[ 3, "desc" ]]
    } );$("#myModal3").modal("show");
      }
</script>
        <div class="modal-footer">
          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        </div>
      </div></div></div>
</body>
</html>