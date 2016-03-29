<%@ include file="realhead.jsp"%>
<script type="text/javascript">
function check() {
		if (form2.uid.value == null || form2.uid.value == "" ) {
			alert ("The ID of user can't be null!");
			return false;
		}if (form2.password.value == null || form2.password.value=="" ) {
			alert ("The password can't be null!!");
			return false;
		}if (form2.firstname.value == null || form2.firstname.value == "" ) {
			alert ("The first name of user can't be null!");
			return false;
		}if (form2.lastname.value == null || form2.lastname.value == "" ) {
			alert ("The last name of user can't be null!");
			return false;
		}
		return true;
}
</script>
			<div id="userModal" class="modal fade">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title">Add User</h4>
      </div>
      <s:form id="form2" action="addUser" method="post">
					<fieldset>
      <div class="modal-body">
				<s:fielderror cssClass="error"></s:fielderror>
						<div class="control-group">
							<div class="controls">
								<label class="control-label">User ID:</label>
								<s:textfield id="uid" name="uid"></s:textfield>
								<span class="help-block">(Please enter the ID of the
									user!)</span>
							</div>
						</div>
						<div class="control-group">
							<div class="controls">
								<label class="control-label">First Name:</label>
								<s:textfield id="firstname" name="firstname"></s:textfield>
								<span class="help-block">(Please enter the first name of the
									user!)</span>
							</div>
						</div>
						<div class="control-group">
							<div class="controls">
								<label class="control-label">Last Name:</label>
								<s:textfield id="lastname" name="lastname"></s:textfield>
								<span class="help-block">(Please enter the last name of the
									user!)</span>
							</div>
						</div>
						<div class="control-group">
							<div class="controls">
								<label class="control-label">Password :</label>
								<s:password id="password" name="password"></s:password>
								<span class="help-block">(Please enter the password of the professor!)</span>
							</div>
						</div>
						</div>
						<div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        <input class="btn btn-primary" name="submit" type="submit" value="submit" onclick="return check();"/>
      </div>
					</fieldset>
				</s:form>
			</div>
			</div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</body>
</html>
