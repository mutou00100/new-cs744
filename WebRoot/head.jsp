 <class="brand"><h2 style="margin-top: 2px;margin-bottom: -15px;"><center></>Concentric Ring Network</center></h2>
 <div align="right" style="margin-right:30px"  >
  Current User : <%=request.getSession().getAttribute("firstname")%>
 <a href="Logout"  target="_parent">Log Out</a>
 </div>
 <script>
 var uid = "<%=request.getSession().getAttribute("uid")%>";
 </script>