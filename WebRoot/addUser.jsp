<script type="text/javascript">
	function check() {
		var ref = /^[a-zA-Z]+$/;
		var reg = /^\w*$/;
		if ($('#uID').val() == null || $('#uID').val() == "") {
			alert("The ID of user can't be null!");
			return false;
		}
		if ($('#firstName').val() == null || $('#firstName').val() == "") {
			alert("The first name can't be null!!");
			return false;
		}
		if ($('#lastName').val() == null || $('#lastName').val() == "") {
			alert("The last name of user can't be null!");
			return false;
		}
		if ($('#password').val() == null || $('#password').val() == "") {
			alert("The password of user can't be null!");
			return false;
		}
		if (!ref.test($('#lastName').val()) || !ref.test($('#firstName').val())) {
			alert("The first name or last name of user can't contain any number or special character!");
			return false;
		}
		if (!reg.test($('#uID').val())) {
			alert("The user ID can't contain the special character!");
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
