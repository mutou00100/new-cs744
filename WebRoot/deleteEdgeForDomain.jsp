<%@ include file="realhead.jsp"%>
<script type="text/javascript">
	function check() {
		var vn1 = document.getElementsByName("n1")[0].value;
		var vn2 = document.getElementsByName("n2")[0].value;
		var gid = document.getElementById("gid").value;
		if ( vn1==""&& vn2 =="") {
			return true;
		}
		if (gid == vn1) {
			alert("The node1 can't be the connector!");
			return false;
		}if (gid == vn2) {
			alert("The node2 can't be the connector!");
			return false;
		}if (vn1 == vn2 && vn1 != "" && vn2 != "") {
			alert("The node1 and node2 can't be the same!");
			return false;
		}
		var nubmer1 = parseInt(document.getElementsByName("n1")[0].value);
		var nubmer2 = parseInt(document.getElementsByName("n2")[0].value);
		if (vn1 !=""&&(nubmer1<=0||!(/^\d+$/.test(nubmer1)))){
				 alert("Please enter a Integer!");
	     return false;
			}
			if (vn2 !=""&&(nubmer2<=0||!(/^\d+$/.test(nubmer2)))){
				alert("Please enter a Integer!");
				return false;
			}
		return true;
	}
</script>
			<div class="span12" id="datacontent">

					<table class="table">
						<thead>
							<tr>
								<th colspan="5">Delete Edge Between Domain</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td class="input"><input class="input-small" id= "domainId1" name="message"
									size="10" type="text" value="">domain 1</input></td>
								<td class="input"><input class="input-small" id= "domainId2" name="message"
									size="10" type="text" value="">domain 2</input></td>
								<td>
									<a class="btn btn-primary" type="submit" onclick="if(check()){addNonNode();}">Add</button>
								</td>
							</tr>
						</tbody>
					</table>