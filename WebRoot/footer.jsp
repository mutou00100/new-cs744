
<%@ include file="realhead.jsp"%>      
<body onload="draw();"> 
<div id="mynetwork" ></div>

<script type="text/javascript">
    var blockedlist = [];
 	inactivelist = [];
   	var nodes, edges, network;
    var DIR = 'img/';
	EDGE_LENGTH_MAIN = 300;
	EDGE_LENGTH_SUB = 100; 
	EDGE_LENGTH_DD = 400; 
	EDGE_LENGTH_CD = 200; 
	process = 0;
	var stack = [];
	var table;
	function draw() {
		nodes = new vis.DataSet();
		edges = new vis.DataSet();
<%
  		if(allnodes != null) { 
  			for (int i=0;i<allnodes.size();i++){%>
				<%if(allnodes.get(i).getType().equals("c")){%>
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
          },});<%}
          		if (allnodes.get(i).getType().equals("d")){%>
				nodes.add({id :<%=allnodes.get(i).getnID()%>,label : 'Domain' +<%=allnodes.get(i).getnID()%>,image : DIR + 'Network-Domain-icon.png',shape : 'circularImage', color: {
            background: '#6AAFFF',
            border: '#6AAFFF'
          },});<%}  
          
          %>
          <%if (allnodes.get(i).getStatus()!=0 && allnodes.get(i).getType().equals("n")){%>
				nodes.update({id :<%=allnodes.get(i).getnID()%>,
				image : DIR + 'inactivate.png',shape : 'circularImage',
				 color: {
            background: '#6AAFFF',
            border: '#6AAFFF'
          }});
				inactivelist.push(<%=allnodes.get(i).getnID()%>);
				<%}if (allnodes.get(i).getStatus()!=0 && allnodes.get(i).getType().equals("c")){%>
				nodes.update({id :<%=allnodes.get(i).getnID()%>,
					image : DIR + 'inactivatedC.png',shape : 'circularImage',
					 color: {
	            background: '#6AAFFF',
	            border: '#6AAFFF'
	          }});
				inactivelist.push(<%=allnodes.get(i).getnID()%>);
  			<%}}}%>
		
	
		<%
  		if(edge != null) { //
  			for (int i=0;i<edgeCC.size();i++){
  			%>
			edges.add({id: <%=edgeCC.get(i).geteID()%>, from :<%=edgeCC.get(i).getNode1()%>, to :<%=edgeCC.get(i).getNode2()%>,smooth: {type: 'dynamic'},length : EDGE_LENGTH_MAIN});
			<%}
			for (int i=0;i<edgeCN.size();i++){
  			%>	
			edges.add({from :<%=edgeCN.get(i).getNode1()%>, to :<%=edgeCN.get(i).getNode2()%>,smooth:false,length : EDGE_LENGTH_SUB});
			<%}
			for (int i=0;i<edgeNN.size();i++){	%>
			edges.add({id: <%=edgeNN.get(i).geteID()%>, from :<%=edgeNN.get(i).getNode1()%>, to :<%=edgeNN.get(i).getNode2()%>,smooth: {type: 'dynamic'},length : EDGE_LENGTH_SUB});
			<%}
			for (int i=0;i<edgeCD.size();i++){	%>
			edges.add({from :<%=edgeCD.get(i).getNode1()%>, to :<%=edgeCD.get(i).getNode2()%>,smooth: {type: 'dynamic'},length :EDGE_LENGTH_CD});
			<%}
			for (int i=0;i<edgeDD.size();i++){	%>
			edges.add({from :<%=edgeDD.get(i).getNode1()%>, to :<%=edgeDD.get(i).getNode2()%>,smooth:false,length :EDGE_LENGTH_DD,dashes:true});
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
	//	updater.poll(); 
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
					if (oriThisTIme == parseInt(ori)){
						path.push(parseInt(ori));
					}
					if (txt3.length == 2) {
						path.push(parseInt(cur));
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
	function getCity(province,child){
		var pv=province.value; 
		createXMLHttp() ;
		xmlHttp.open("POST","getNodes?cid="+pv) ;
		xmlHttp.onreadystatechange = function(){
			if(xmlHttp.readyState == 4){
			if(xmlHttp.status == 200){
				var txt1 = xmlHttp.responseText;
				var txt2 = txt1.split(",");
				child.options.length = 0;
				var city2 = document.getElementById("city2");
				if (city2 != null){
					city2.options.length = 0;
				}
				var newArr = txt2;
				for(var i=0; i<newArr.length; i++) 
				{
				var str = newArr[i];
				var op = document.createElement('option');
				op.text = str;
				op.value = str;
				child.appendChild(op); 
				if (city2 != null){
				city2.options.add(new Option(str,str));
				}
				} 
			}					
			}
		};
		xmlHttp.send(); 
	}
	function startWalking(dest, message,path,ori,arrival, i){ 	
		var count = 0;
		process = 0;
		var j = i;
		for (; j < path.length; j++) {
			count++;
			setTime(dest, message,path,ori,arrival, j, count);
		}
					
  	}
  	function setTime(dest, message,path,ori,arrival, i,count){
  			setTimeout(function() {
				if (process == 0) {
					var temp = i;
					var test1 = path[i];
					var test = inactivelist.indexOf(path[i])>=0;
					var d=new Date();	
					var s=String(d.getFullYear())+'-'+String(d.getMonth()+1)+ '-' +String(d.getDate())+' '+d.getHours()+':'+d.getMinutes()+':'+d.getSeconds();	
					if (inactivelist.indexOf(path[i])>=0) {							
						blockedlist.push([String(path[i]), ori,dest,s,message]);
						blockedSession();
						process =-1;
						setTimeout(function() { alert("A message is blocked at node" + path[i]);
						alert(stack);
						resend();}
						,1000);
					} else {
						if ((path[i] == dest) &&inactivelist.indexOf(path[i])<0) {
							storeMessage(ori, dest, message);
							setTimeout(function() { alert("A message is sent successfully");
							resend();}
						,1000);
							process =-1;
						} else if (arrival == -1 && path[i]!=ori) {
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
  		if (type == "DD") {
  			edges.add({id: node0, from :node1, to :node2,smooth:false,length : EDGE_LENGTH_DD,dashes:true});
  		} else if (type == "CD") {
  			edges.add({from :node1, to :node2,smooth: {type: 'dynamic'},length : EDGE_LENGTH_CD});
  		} else if (type == "CC"){
  			edges.add({id: node0, from :node1, to :node2,smooth: {type: 'dynamic'},length : EDGE_LENGTH_MAIN});
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
		});} else if (type == 'd'){
  		nodes.add({id :node, label : 'Domain'+node,image : DIR + 'Network-Domain-icon.png',shape : 'circularImage',
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
  	function addQuestion(){
		//var checkboxes= window.parent.document.getElementById('frame2').contentWindow.document.getElementsByName('checkedC');
	var checkboxes= document.getElementById('content').value;
	createXMLHttp() ;
	xmlHttp.open("POST","addQuestion?content="+checkboxes) ;
	xmlHttp.onreadystatechange = addQuestionCallback ;
	xmlHttp.send();
}
	function addQuestionCallback(){
	  	if(xmlHttp.readyState == 4){
					if(xmlHttp.status == 200){
						var xml = xmlHttp.responseXML;
						//var parser = new DOMParser();
						//var xml = parser.parseFromString(xmlHttp.responseText, "application/xml");
						if (typeof xml.getElementsByTagName("error")[0]  != "undefined") {
							alert(xml.getElementsByTagName("error")[0].childNodes[0].nodeValue);
						} else {
							alert(xml.getElementsByTagName("success")[0].childNodes[0].nodeValue);
	  						}		
						}
					}
	  	}
  	function addConnector(){
  			//var checkboxes= window.parent.document.getElementById('frame2').contentWindow.document.getElementsByName('checkedC');
			var checkboxes= document.getElementsByName('checkedC');
			var domainId = document.getElementById('domainIdforPattern').value;
			var checkedC = [];
			for (var i=0; i<checkboxes.length; i++) {
			    if (checkboxes[i].checked) {
			        checkedC.push(checkboxes[i].value);
			    }
			}
			createXMLHttp() ;
			xmlHttp.open("POST","addConnector?checkedC="+checkedC+"&&dID="+domainId) ;
			xmlHttp.onreadystatechange = addConnectorCallback ;
			xmlHttp.send();
  	}
  	function addConnectorCallback(){
  	if(xmlHttp.readyState == 4){
				if(xmlHttp.status == 200){
					var xml = xmlHttp.responseXML;
					if (typeof xml.getElementsByTagName("error")[0]  != "undefined") {
						alert(xml.getElementsByTagName("error")[0].childNodes[0].nodeValue);
					} else {
						addNode(xml.getElementsByTagName("node")[0].childNodes[0].nodeValue, "c");
  						for (var i = 0; i < xml.getElementsByTagName("node1").length; i++) {
  						addEdge(xml.getElementsByTagName("node0")[i].childNodes[0].nodeValue,xml.getElementsByTagName("node1")[i].childNodes[0].nodeValue,
  						xml.getElementsByTagName("node2")[i].childNodes[0].nodeValue, "CC");
  						}
						addEdge("",xml.getElementsByTagName("node00")[0].childNodes[0].nodeValue,
  						xml.getElementsByTagName("node11")[0].childNodes[0].nodeValue, "CD");
  						addCheckList(xml.getElementsByTagName("node")[0].childNodes[0].nodeValue);		
					}
				}
  	}}
  	function addDomain(){
  			//var checkboxes= window.parent.document.getElementById('frame2').contentWindow.document.getElementsByName('checkedC');
			var checkboxes= document.getElementsByName('checkedC');
			var checkedC = [];
			for (var i=0; i<checkboxes.length; i++) {
			    if (checkboxes[i].checked) {
			        checkedC.push(checkboxes[i].value);
			    }
			}
			createXMLHttp() ;
			xmlHttp.open("POST","addDomain?checkedC="+checkedC) ;
			xmlHttp.onreadystatechange = addDomainCallback ;
			xmlHttp.send();
  	}
  	function addDomainCallback(){
  	if(xmlHttp.readyState == 4){
				if(xmlHttp.status == 200){
					var xml = xmlHttp.responseXML;
					if (typeof xml.getElementsByTagName("error")[0]  != "undefined") {
						alert(xml.getElementsByTagName("error")[0].childNodes[0].nodeValue);
					} else {
						addNode(xml.getElementsByTagName("node")[0].childNodes[0].nodeValue, "d");
						addNode(xml.getElementsByTagName("nodeC")[0].childNodes[0].nodeValue, "c");
  						for (var i = 0; i < xml.getElementsByTagName("node1").length; i++) {
  						addEdge(xml.getElementsByTagName("node0")[i].childNodes[0].nodeValue,xml.getElementsByTagName("node1")[i].childNodes[0].nodeValue,
  						xml.getElementsByTagName("node2")[i].childNodes[0].nodeValue, "DD");
  						}
  						addEdge("",xml.getElementsByTagName("node11")[0].childNodes[0].nodeValue,
  						xml.getElementsByTagName("node22")[0].childNodes[0].nodeValue, "CD");
  						
  						addCheckList(xml.getElementsByTagName("node")[0].childNodes[0].nodeValue);		
					}
				}
  	}}
  	function removeNode(node) {
  		nodes.remove({id :node});
  	}
  	function deleteNode(){
			var nid = document.getElementsByName('nid')[0].value;
			var gid= document.getElementById('gid').value;
			if (!nid){
				nid = gid;
			}
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
						var obj=document.getElementsByName('nid')[0]; 
						//index,要删除选项的序号，这里取当前选中选项的序号 
						var index=obj.selectedIndex; 
						obj.options.remove(index); 					
						removeNode(xml.getElementsByTagName("node")[0].childNodes[0].nodeValue);
  						for (var i = 0; i < xml.getElementsByTagName("addEdge1").length; i++) {
  						addEdge(xml.getElementsByTagName("addEdge0")[i].childNodes[0].nodeValue,xml.getElementsByTagName("addEdge1")[i].childNodes[0].nodeValue,
  						xml.getElementsByTagName("addEdge2")[i].childNodes[0].nodeValue, "NN");
  						}		
					}
				}
  	}}
  	function addNonNode(){
  		var n1 = $('#nID1').val();
  		var n2 = $('#nID2').val();
  		var gid = $('#cID').val();
  		alert(gid);
  		if(n1==null){
  			n1=""
  		}
  		if(n2==null){
  			n2=""
  		}
  			var f= document.getElementsByName('connectToC');
  			var flag;
  			if (f[0].checked) {
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
					var node=xml.getElementsByTagName("node")[0].childNodes[0].nodeValue;
  						$("#nID1").append("<option value='" + node + "'>" + node + "</option>");
  						$("#nID2").append("<option value='" + node + "'>" + node + "</option>");
  	}}}}
  	
  	function activateNode(){
  			var nid= document.getElementsByName('nid')[0].value;
  			var gid= document.getElementById('gid').value;
  			if (!nid){
  				nid = gid;
  			}
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
						var index = inactivelist.indexOf(parseInt(text));
						if (index > -1) {
    						inactivelist.splice(index, 1);
						}
						nodes.update({id: text,image : DIR + 'Hardware-My-Computer-3-icon.png',shape : 'circularImage',color: {border: '#6AAFFF'}});
  							<%
  				        	for (int i=0;i<allPatterns.size();i++){
  				        	%>
  							if (text==<%=allPatterns.get(i) + ""%>){
  								nodes.update({id: text,image : DIR + 'Network-Pipe-icon.png',shape : 'circularImage',color: {border: '#6AAFFF'}});
  							}
  							<%}
  					    	%>
						receiveStack(parseInt(text));
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
        	if (data!= ""){
        		nodes.update({id: data, image : DIR + 'inactivate.png',shape : 'circularImage'});
    			inactivelist.push(parseInt(data));
        	<%
        	for (int i=0;i<allPatterns.size();i++){
        	%>
        	if (data == <%=allPatterns.get(i) + ""%>) {
          	 	nodes.update({id: data, image : DIR + 'inactivatedC.png',shape : 'circularImage'});
        	}
        <%}
    	%>
        	}
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
			if (speed != "") {
				createXMLHttp() ;
				xmlHttp.open("POST","inactivateNode?speed="+speed) ;
				xmlHttp.send() ;
			}
  	}
  	function storeMessage(ori, dest, message){
			createXMLHttp() ;
			xmlHttp.open("POST","storeMessage?ori="+ori+ "&&dest=" +dest +"&&message=" + message) ;
			xmlHttp.send() ;
  	}  
 	function receivedMessage(){
 			var x= document.getElementById('messageId');
  			var nid= document.getElementById('messageId').value;
			createXMLHttp() ;
			xmlHttp.open("POST","receivedMessage?nid="+nid) ;
			xmlHttp.onreadystatechange = receivedMessageCallback;
			xmlHttp.send() ;
  	}
  	function receivedMessageCallback(){
  	if(xmlHttp.readyState == 4){
				if(xmlHttp.status == 200){
					var text = xmlHttp.responseText;
					createRTbody(JSON.parse(text));
  				}
  		}
  	}
 	function blockedSession(){
		createXMLHttp() ;
		var k = blockedlist;
		var s = ""+blockedlist;
		var o = "blockedSession?blockedlist="+blockedlist;
		xmlHttp.open("POST","blockedSession?blockedlist="+blockedlist) ;
		xmlHttp.send() ;
  	}  
 	function deleteDD(){
		var d1 = $('#dID1').val();
		var d2 = $('#dID2').val();
		var type="DD"
		var data={"type":type,"node1":d1,"node2":d2}
		var mydata=JSON.stringify(data)
		$.ajax({
	        type : "POST",
	        url : "deleteEdge",
	        data: mydata,
	        contentType: 'application/json;charset=UTF-8',
	        success: function(result){
	        	var obj=JSON.parse(result);
	        	var eid=obj['eid'];
	        	var b = String(eid);
	        	var a = parseInt(b);
        		edges.remove(a);
	        	if(a==-1){
	        	alert("Each domain must connect to at least one domain!")}	
	        }
    	});
	}
		</script>