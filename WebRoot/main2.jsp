<html>
<div></div>
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
        <tbody><script>
L=[[35,50,60,'4/5','hello world'],[32,50,60,'3/5','hello world'],[35,50,60,'4/5','hello world'],[35,50,60,'4/5','hello world'],[35,50,60,'7/5','hello world'],[35,50,60,'4/5','hello world'],[35,50,60,'4/5','hello world'],[35,50,60,'4/5','hello world'],[35,50,60,'4/5','hello world'],[35,50,60,'4/5','hello world'],[35,50,60,'4/5','hello world'],[35,50,60,'4/5','hello world'],[35,50,60,'4/5','hello world'],[35,50,60,'4/5','hello world'],[35,50,60,'4/5','hello world'],[35,50,60,'4/5','hello world'],[35,50,60,'4/5','hello world'],[35,50,60,'4/5','hello world'],[35,50,60,'4/5','hello world'],[35,50,60,'4/5','hello world'],[35,50,60,'4/5','hello world'],[35,50,60,'4/5','hello world'],[35,50,60,'4/5','hello world'],[35,50,60,'4/5','hello world'],[35,50,60,'4/5','hello world']]
for(i=0;i<L.length;i++){
    document.write('<tr><td>'+L[i][0]+'</td>')
    document.write('<td>'+L[i][1]+'</td>')
    document.write('<td>'+L[i][2]+'</td>')
    document.write('<td>'+L[i][3]+'</td>')
    document.write('<td>'+L[i][4]+'</td></tr>')
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
</div>


</html>