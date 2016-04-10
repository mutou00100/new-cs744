<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@ page import="com.entity.Question"%>
<%@ include file="realhead.jsp"%>
<%@ page import="com.dao.QuestionDao"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
	+ request.getServerName() + ":" + request.getServerPort()
	+ path + "/";
	QuestionDao qd = new QuestionDao();
	List<Question> questions = qd.getQuestions();
%>
<link type="text/css" rel="stylesheet" href="css/setQues.css" />
<div id="Modal3" class="modal fade">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title">Add User</h4>
      </div>
<div id="wrapper">
	<form name="question" class="login-form" action="changeQuestion"
		method="post" onsubmit="return validate(this)">
		<span id="ansReminder"></span>
			<div class="content">
			<select class="input username" id="ques1" name="ques1">
				<%
					//to get from the database
								if (questions != null && questions.size() != 0) {
									for (int i = 0; i < questions.size(); i++) {
								Question question = questions.get(i);
								int id = question.getId();
								String content = question.getContent();
								out.println("<option value = "+id+">"+content+"</option>");
									}
								}
				%>
			</select> <input type="text" name="ans1" class="input username"> <span id="msg"></span> <br />

			<select class="input username" id="ques2" name="ques2">
				<%
					//to get from the database
								if (questions != null && questions.size() != 0) {
									for (int i = 0; i < questions.size(); i++) {
								Question question = questions.get(i);
								int id = question.getId();
								String content = question.getContent();
								out.println("<option value = "+id+">"+content+"</option>");
									}
								}
				%>
			</select> <input type="text" name="ans2" class="input username"> <span id="msg"></span> <br />
			<select id="ques3" name="ques3" class="input username">
				<%
					//to get from the database
								if (questions != null && questions.size() != 0) {
									for (int i = 0; i < questions.size(); i++) {
										Question question = questions.get(i);
										int id = question.getId();
										String content = question.getContent();
										out.println("<option value = "+id+">"+content+"</option>");
									}
								}
				%>
			</select> <input type="text" name="ans3" class="input username"> <span id="msg"></span> <br />
			</div>
			<div class="footer">
			<input type="submit" name="submit" value="submit" class="button">
			</div>

			<script>
			function checkContentNull(f) {
				if (f.ans1.value.length == 0 || f.ans2.value.length == 0
						|| f.ans3.value.length == 0) {
						alert("The answer can't be null");	
					return false;
				} else {
					return true;
				}
			}
			
			
			function checkDuplicateQuestion(f) {
				if (f.ques1.value == f.ques2.value || f.ques1.value == f.ques3.value || f.ques2.value == f.ques3.value){
					alert("Please choose 3 different questions");	
					return false;
				} else {
					return true;
				}
			}
			function validate(f) {
				return  checkContentNull(f)&&checkDuplicateQuestion(f);
			}
		</script>
	</form>
	</div>
			</div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
  </div>
</body>
</html>
