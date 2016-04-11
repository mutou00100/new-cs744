<%@ include file="realhead.jsp"%>
<script type="text/javascript">
	function check() {
		if (form2.uid.value == null || form2.uid.value == "") {
			alert("The ID of user can't be null!");
			return false;
		}
		if (form2.password.value == null || form2.password.value == "") {
			alert("The password can't be null!!");
			return false;
		}
		if (form2.firstname.value == null || form2.firstname.value == "") {
			alert("The first name of user can't be null!");
			return false;
		}
		if (form2.lastname.value == null || form2.lastname.value == "") {
			alert("The last name of user can't be null!");
			return false;
		}
		return true;
	}
</script>
<div id="userModal" class="modal fade">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title">Add User</h4>
			</div>
			<div class="modal-body">
				<form>
					<div class="form-group">
						<label for="recipient-name" class="control-label">User ID:</label>
						<input type="text" class="form-control" id="uID">
					</div>
					<div class="form-group">
						<label for="message-text" class="control-label">First Name:</label>
						<input type="text" class="form-control" id="firstName">
					</div>
					<div class="form-group">
						<label for="message-text" class="control-label">Last Name:</label>
						<input type="text" class="form-control" id="lastName">
					</div>
					<div class="form-group">
						<label for="message-text" class="control-label">Passwprd:</label>
						<input type="password" class="form-control" id="password">
					</div>
				</form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
				<button type="button" class="btn btn-primary" onClick="if(check()){addUser();}">Submit</button>
			</div>
		</div>
	</div>
	<!-- /.modal-content -->
</div>
<!-- /.modal-dialog -->
</body>
</html>
