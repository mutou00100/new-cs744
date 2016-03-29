<%@ include file="realhead.jsp"%>
<script type="text/javascript">
	//考虑到当pattern中只有一个点的情况，故并不一定需要左右节点，当pattern节点大于2时才需要，交由后台判断并返回错误信息。
	function check() {
		var x =  document.getElementById("nid").value;
		if (x == null || x == "") {
			alert("The node can't be the null!");
			return false;
		}
		var nubmer1 = parseInt(document.getElementById("nid").value);
		if (nubmer1<=0||!(/^\d+$/.test(nubmer1))){
			 alert("Please enter a Integer!");
		     return false;
		} 
			return true;
	}
</script>
			<div class="span10" id="datacontent">
					<table class="table">
						<thead>
							<tr>
								<th colspan="5">Activate Node</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td class="span4">Node ID:</td>
								<td class="span1"><input class="input-small" name="nid" id="nid"
									size="10" type="text" value=""></input></td>
								<td class="span6">
									<button class="btn btn-primary" onclick = "if(check()){activateNode();}" type="submit">Activate</button>
								</td>
							</tr>
						</tbody>
					</table>