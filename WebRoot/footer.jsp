<%@ include file="realhead.jsp"%>
<% 
if (request.getAttribute("error") == null) {
	} else {
			 error = (String) request.getAttribute("error");
				%>
   <script>
    alert("<%=error%>");</script>
   <% }
%>       
<body onload="draw();"> 
<div id="mynetwork" ></div>
<script type="text/javascript">
	var blockedlist = [];
	var inactivelist = [];
   	var nodes, edges, network;
    var DIR = 'img/';
	var EDGE_LENGTH_MAIN = 500;
	var EDGE_LENGTH_SUB = 100; 
	var process = 0;
	function draw() {
		nodes = new vis.DataSet();
		edges = new vis.DataSet();
<%
  		if(allnodes != null) { 
  			for (int i=0;i<allnodes.size();i++){%>
	
				<%if (allnodes.get(i).getType().equals("c")){%>
				nodes.add({id :<%=allnodes.get(i).getnID()%>, label : 'Pattern' +<%=allnodes.get(i).getnID()%>,image : DIR + 'Network-Pipe-icon.png',shape : 'circularImage',
				 color: {
            	background: '#6AAFFF',
            	border: '#6AAFFF'
         		},
				});
				
				<%}
				if (allnodes.get(i).getType().equals("n")){%>
				nodes.add({id :<%=allnodes.get(i).getnID()%>,label : 'Node' +<%=allnodes.get(i).getnID()%>,image : DIR + 'Hardware-My-Computer-3-icon.png',shape : 'circularImage', color: {
            background: '#6AAFFF',
            border: '#6AAFFF'
          },});<%}%>
          <%if (allnodes.get(i).getStatus()!=0){%>
				nodes.update({id :<%=allnodes.get(i).getnID()%>,
				 color: {
            background: '#6AAFFF',
            border: 'gray'
          }});
          	inactivelist.push(<%=allnodes.get(i).getnID()%>);
				<%}}}%>
		
	
		<%
  		if(edge != null) { // 有信息返
  			for (int i=0;i<edgeCC.size();i++){
  			%>
			edges.add({id: <%=edgeCC.get(i).geteID()%>, from :<%=edgeCC.get(i).getNode1()%>, to :<%=edgeCC.get(i).getNode2()%>,smooth: {type: 'dynamic'},length : EDGE_LENGTH_MAIN,dashes:true});
			<%}
			for (int i=0;i<edgeCN.size();i++){
  			%>	
			edges.add({from :<%=edgeCN.get(i).getNode1()%>, to :<%=edgeCN.get(i).getNode2()%>,smooth:false,length : EDGE_LENGTH_SUB});
			<%}
			for (int i=0;i<edgeNN.size();i++){	%>
			edges.add({id: <%=edgeNN.get(i).geteID()%>, from :<%=edgeNN.get(i).getNode1()%>, to :<%=edgeNN.get(i).getNode2()%>,smooth: {type: 'dynamic'},length : EDGE_LENGTH_SUB});
			<%}}
  		%>
	// create a network
		var container = document.getElementById('mynetwork');
		var data = {
			nodes : nodes,
			edges : edges
		};
		var options ={
		layout:{randomSeed:1},
		 nodes: {
		 borderWidth:6,
		  size:25,
          shapeProperties: {
            useBorderWithImage:true
          }
        },};
		network = new vis.Network(container, data, options);
		//updater.poll(); 
		}
		
		function createXMLHttp(){
			if(window.XMLHttpRequest){
				xmlHttp = new XMLHttpRequest() ;
			} else {
				xmlHttp = new ActiveXObject("Microsoft.XMLHTTP") ;
			}
		}
	function sendMessage(cur, dest, message, ori){
			createXMLHttp() ;
			xmlHttp.open("POST","sendMessage?ori="+cur+ "&&dest=" +dest +"&&message=" + message) ;
			xmlHttp.onreadystatechange = function(){
				if(xmlHttp.readyState == 4){
				if(xmlHttp.status == 200){
				    //path[ori,destination, message,... ]
					var txt1 = xmlHttp.responseText ;
					var txt2 = txt1.substring(1,txt1.length-1);
					var txt3 = txt2.split(",");
					var path=[];
					var arrival = parseInt(txt3[txt3.length - 2]);	
					var oriThisTIme = parseInt(txt3[txt3.length - 1]);			
					if (oriThisTIme == ori){
						path.push(ori);
					}
					for(var j=0;j<txt3.length-2;j++){
						path.push(parseInt(txt3[j]));
					}					
					startWalking(dest, message, path, ori, arrival, 0);
					}					
				}
			};
			xmlHttp.send() ;
	}
	function startWalking(dest, message,path,ori,arrival, i){ 	
		var count = 0;
		process = 0;
		for (; i < path.length; i++) {
			setTime(dest, message,path,ori,arrival, i, count);
			count++;
		}
					
  	}
  	function setTime(dest, message,path,ori,arrival, i,count){
  			setTimeout(function() {
				if (process == 0) {
					if (inactivelist.indexOf(path[i])>0) {	
					var d=new Date();
					var s=String(d.getMonth()+1)+ '/' +String(d.getDate())+'/';							
						blockedlist.push([path[i], ori,dest,s,message]);
						process =-1;
						setTimeout(function() { alert("blocked at node" + path[i]);}
						,1000);
					} else {
						if ((path[i] == dest) &&inactivelist.indexOf(path[i])<0) {
							storeMessage(path[i], dest, message);
							setTimeout(function() { alert("sent successfully");}
						,1000);
							process =-1;
						} else if (arrival == -1) {
							// blocked, find other ways
							process =-1;
							//startWalking(cur, dest, message,path,ori,arrival, i){ 	
							checkMessage(dest, message,path, ori, i+1);
						}
						nodes.update({id: path[i],color: {border: 'green'}});
						setTimeout(function() {
						nodes.update({id: path[i],color: {border: '#6AAFFF'}});}
					,1000);
					}
					}
				}
			,1000*count);
		}	

  	//startWalking(cur, dest, message,path,ori,arrival, i){ 	
  	function checkMessage(dest, message,path, ori, i){
			createXMLHttp() ;
			xmlHttp.open("POST","checkMessage?ori="+path[i]+ "&&dest=" +dest) ;
			xmlHttp.onreadystatechange = function (){
		  	if(xmlHttp.readyState == 4){
					if(xmlHttp.status == 200){
						var text = xmlHttp.responseText;
						if (text == "false") {
							startWalking(dest, message,path,ori,-1, i);
						}else {
						 	sendMessage(path[i],dest, message,ori);
						}
		  			}
	  			}
  			};
		  	xmlHttp.send() ;
	}    	
  	function addEdge(node0, node1, node2, type){
  		if (type == "CC"){
  			edges.add({id: node0, from :node1, to :node2,smooth: {type: 'dynamic'},length : EDGE_LENGTH_MAIN,dashes:true});
  		} else if (type == "CN"){
  			edges.add({from :node1, to :node2,smooth:false,length : EDGE_LENGTH_SUB});
  		} else {
  			edges.add({id: node0, from :node1, to :node2,smooth: {type: 'dynamic'},length : EDGE_LENGTH_SUB});
  		}
  	}
  	function addNode(node, type) {
  		if (type == 'c'){
  		nodes.add({id :node, label : 'Pattern'+node,image : DIR + 'Network-Pipe-icon.png',shape : 'circularImage',
		 borderWidth:6,
		  size:25,
	      color: {
            background: '#6AAFFF',
            border: '#6AAFFF'
          },
          shapeProperties: {
            useBorderWithImage:true
          }
		});} else {
			nodes.add({id :node, label : 'Node'+node,image : DIR + 'Hardware-My-Computer-3-icon.png',shape : 'circularImage',
		 borderWidth:6,
		  size:25,
	      color: {
            background: '#6AAFFF',
            border: '#6AAFFF'
          },
          shapeProperties: {
            useBorderWithImage:true
          }
		});
		}
  	}
  	function addConnector(){
  			//var checkboxes= window.parent.document.getElementById('frame2').contentWindow.document.getElementsByName('checkedC');
			var checkboxes= document.getElementsByName('checkedC');
			var checkedC = [];
			for (var i=0; i<checkboxes.length; i++) {
			    if (checkboxes[i].checked) {
			        checkedC.push(checkboxes[i].value);
			    }
			}
			createXMLHttp() ;
			xmlHttp.open("POST","addConnector?checkedC="+checkedC) ;
			xmlHttp.onreadystatechange = addConnectorCallback ;
			xmlHttp.send();
  	}
  	function addConnectorCallback(){
  	if(xmlHttp.readyState == 4){
				if(xmlHttp.status == 200){
					var xml = xmlHttp.responseXML;
					//var parser = new DOMParser();
					//var xml = parser.parseFromString(xmlHttp.responseText, "application/xml");
					if (typeof xml.getElementsByTagName("error")[0]  != "undefined") {
						alert(xml.getElementsByTagName("error")[0].childNodes[0].nodeValue);
					} else {
						addNode(xml.getElementsByTagName("node")[0].childNodes[0].nodeValue, "c");
  						for (var i = 0; i < xml.getElementsByTagName("node1").length; i++) {
  						addEdge(xml.getElementsByTagName("node0")[i].childNodes[0].nodeValue,xml.getElementsByTagName("node1")[i].childNodes[0].nodeValue,
  						xml.getElementsByTagName("node2")[i].childNodes[0].nodeValue, "CC");
  						}		
					}
				}
  	}}
  	function removeNode(node) {
  		nodes.remove({id :node});
  	}
  	function deleteNode(){
  			//var nid= window.parent.document.getElementById('frame2').contentWindow.document.getElementById('nid').value;
			var nid = document.getElementById('nid').value;
			createXMLHttp() ;
			xmlHttp.open("POST","deleteNode?nid="+nid) ;
			xmlHttp.onreadystatechange = deleteNodeCallback;
			xmlHttp.send() ;
  	}
  	function deleteNodeCallback(){
  	if(xmlHttp.readyState == 4){
				if(xmlHttp.status == 200){
					var xml = xmlHttp.responseXML;
					//var parser = new DOMParser();
					//var xml = parser.parseFromString(xmlHttp.responseText, "application/xml");
					if (typeof xml.getElementsByTagName("error")[0]  != "undefined") {
						alert(xml.getElementsByTagName("error")[0].childNodes[0].nodeValue);
					} else {
						removeNode(xml.getElementsByTagName("node")[0].childNodes[0].nodeValue);
  						for (var i = 0; i < xml.getElementsByTagName("addEdge1").length; i++) {
  						addEdge(xml.getElementsByTagName("addEdge0")[i].childNodes[0].nodeValue,xml.getElementsByTagName("addEdge1")[i].childNodes[0].nodeValue,
  						xml.getElementsByTagName("addEdge2")[i].childNodes[0].nodeValue, "NN");
  						}		
					}
				}
  	}}
  	function addNonNode(){
  			var gid= document.getElementById('gid').value;
  			var n1= document.getElementById('n1').value;
  			var n2= document.getElementById('n2').value;
  			var f= document.getElementById('flag').checked;
  			var flag;
  			if (f == true) {
  				flag = 0; 
  			} else {
  				flag = -1;
  			}
			createXMLHttp() ;
			xmlHttp.open("POST","addNode?gid="+gid+"&&n1="+n1+"&&n2="+n2+"&&flag="+flag) ;
			xmlHttp.onreadystatechange = addNonNodeCallback;
			xmlHttp.send() ;
  	}
  	function addNonNodeCallback(){
  	if(xmlHttp.readyState == 4){
				if(xmlHttp.status == 200){
					var xml = xmlHttp.responseXML;
				if (typeof xml.getElementsByTagName("error")[0]  != "undefined") {
						alert(xml.getElementsByTagName("error")[0].childNodes[0].nodeValue);
					} else {
						addNode(xml.getElementsByTagName("node")[0].childNodes[0].nodeValue,"n");
  						for (var i = 0; i < xml.getElementsByTagName("edgeCN1").length; i++) {
  						addEdge("",xml.getElementsByTagName("edgeCN1")[i].childNodes[0].nodeValue,
  						xml.getElementsByTagName("edgeCN2")[i].childNodes[0].nodeValue, "CN");
  						}		
  						for (var i = 0; i < xml.getElementsByTagName("edgeNN0").length; i++) {
  						addEdge(xml.getElementsByTagName("edgeNN0")[i].childNodes[0].nodeValue,xml.getElementsByTagName("edgeNN1")[i].childNodes[0].nodeValue,
  						xml.getElementsByTagName("edgeNN2")[i].childNodes[0].nodeValue, "NN");
  						}
  						for (var i = 0; i < xml.getElementsByTagName("edgeDelete").length; i++) {
  						edges.remove(xml.getElementsByTagName("edgeDelete")[i].childNodes[0].nodeValue);	
					}
  	}}}}
  	
  	function activateNode(){
  			var nid= document.getElementById('nid').value;
			createXMLHttp() ;
			xmlHttp.open("POST","activateNode?nid="+nid) ;
			xmlHttp.onreadystatechange = activateNodeCallback;
			xmlHttp.send() ;
  	}
  	function activateNodeCallback(){
  	if(xmlHttp.readyState == 4){
				if(xmlHttp.status == 200){
					var text = xmlHttp.responseText;
				if (text == "error") {
						alert("you can't activate this node");
					} else {
						nodes.update({id: text,color: {border: '#6AAFFF'}});
					}
  	}}}
    var updater = {  
    poll: function(){  
        $.ajax({url: 'inactivateNode',   
                type: "POST",   
                dataType: "text",  
                success: updater.onSuccess,  
                error: updater.onError});  
    },  
    onSuccess: function(data, dataStatus){  
        try{ 
        	if (data!= "") 
          	 nodes.update({id: data,color: {border: 'gray'}});
          	 inactivelist.push(data);
        }  
        catch(e){  
            updater.onError();  
            return;  
        }  
        interval = window.setTimeout(updater.poll, 0);  
    },  
    onError: function(){  
        console.log("Poll error;");  
    }  
};
    function controlSpeed(){
  			//var nid= window.parent.document.getElementById('frame2').contentWindow.document.getElementById('nid').value;
			var speed = document.getElementById('random').value;
			createXMLHttp() ;
			xmlHttp.open("POST","inactivateNode?speed="+speed) ;
			xmlHttp.send() ;
  	}
  	function storeMessage(ori, dest, message){
			createXMLHttp() ;
			xmlHttp.open("POST","storeMessage?ori="+ori+ "&&dest=" +dest +"&&message=" + message) ;
			xmlHttp.send() ;
  	}  
		</script>