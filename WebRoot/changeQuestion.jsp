<script>
$(document).ready(function() {
$('#changeSecurityQuestion').click(function() {
        $.ajax({url: 'showQuesAndAns',   
                type: "POST",   
                data: JSON.stringify({"uid":uid}),
        		contentType: 'application/json;charset=UTF-8',
                success: function(result){
	        	obj=JSON.parse(result);
	        	ques_and_ans=obj['QuesAndAns'];
	        	all_questions=obj['AllQuestions'];
	        	var keys =  Object.keys(all_questions);
	        	$("#ques1").html("<option selected value='"+ques_and_ans[0]+"'>"+all_questions[ques_and_ans[0]]+"</option>");
	        	for(i=0;i<keys.length;i++){
	        	if (keys[i]!=ques_and_ans[0] && keys[i]!=ques_and_ans[1]&&keys[i]!=ques_and_ans[2] ){
	        		$("#ques1").append("<option value='"+keys[i]+"'>"+all_questions[keys[i]]+"</option>");
	        	}}
	        	$("#ques2").html("<option selected value='"+ques_and_ans[1]+"'>"+all_questions[ques_and_ans[1]]+"</option>");
	        	for(i=0;i<keys.length;i++){
	        	if (keys[i]!=ques_and_ans[0] && keys[i]!=ques_and_ans[1]&&keys[i]!=ques_and_ans[2] ){
	        		$("#ques2").append("<option value='"+keys[i]+"'>"+all_questions[keys[i]]+"</option>");
	        	}}
	        	$("#ques3").html("<option selected value='"+ques_and_ans[2]+"'>"+all_questions[ques_and_ans[2]]+"</option>");
	        	for(i=0;i<keys.length;i++){
	        	if (keys[i]!=ques_and_ans[0] && keys[i]!=ques_and_ans[1]&&keys[i]!=ques_and_ans[2] ){
	        		$("#ques3").append("<option value='"+keys[i]+"'>"+all_questions[keys[i]]+"</option>");
	        	}}
	        	$("#ans1").val(ques_and_ans[3]);
	        	$("#ans2").val(ques_and_ans[4]);
	        	$("#ans3").val(ques_and_ans[5]);
	        	//document.getElementById('changeSecurityQuestion').setAttribute("data-target","#myModal4");
  	    }});
});
$('#changeQuestion').click(function() {
  				var ques1 = $("#ques1").val();
                var ques2 = $("#ques2").val();
                var ques3 = $("#ques3").val();
                var ans1 = $('#ans1').val().trim();
                var ans2 = $('#ans2').val().trim();
                var ans3 = $('#ans3').val().trim();  
                if (ques1 == ques2 ||ques2 == ques3 || ques3 == ques1) {
                	alert("Please choose three different questions!");
                } else if (ans1 == null || ans2 == null||ans2 == null||ans1 == "" || ans2 == ""||ans2 == "") {
                	alert("No answers can be null");
                } else {
        $.ajax({url: 'changeQuestion',   
                type: "POST",      
                data: JSON.stringify({"uid":uid,"ques1":ques1,"ques2":ques2, "ques3":ques3, "ans1":ans1, "ans2":ans2,"ans3":ans3}),
        		contentType: 'application/json;charset=UTF-8',
                success: function(result){
                alert("You have changed the questions succesfully");
  	    }});}
});
});


</script>
<!-- Modal -->
	<div id="myModal4" class="modal fade">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title">Change Security Question</h4>
				</div>
				<div class="modal-body">
					<div class="control-group">
					
					<select class="input username" id="ques1" name="ques1"> </select> <br /><br />
					<input type="text" id="ans1" class="form-control"> <br />
					
				
					<select class="input username" id="ques2" name="ques2"> </select> <br /><br />
					<input type="text" id="ans2" class="form-control"> <br />
					
					
					<select class="input username" id="ques3" name="ques3" class="input username"> </select> <br /><br />
					<input type="text" id="ans3" class="form-control"> <br />
					
			</div>
			<div class="footer">
			</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
					<input class="btn btn-primary" id = "changeQuestion"
						value="submit" />
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>
	
	
