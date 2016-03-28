<%@ include file="head_without_jsp.jsp"%>
 <a target="_blank" class="brand"><h1><center></>Concentric Ring Network</center></h1></a>
	<div class="navbar navbar-inverse">
		<div class="navbar-inner">
			<div class="container-fluid">
				<div class="nav-collapse navbar-responsive-collapse collapse">
					<ul class="nav pull-right">
						<li><a ><%=request.getSession().getAttribute("firstname")%></a></li>
						<li><a href="Logout"  target="_parent">log out</a></li>
						
					</ul>
				</div>

			</div>
		</div>
	</div>