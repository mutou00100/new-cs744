<%@ page language="java" contentType="text/html; charset=GBK"  
    pageEncoding="GBK"%>  
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">  
<html>  
<head>  
<meta http-equiv="Content-Type" content="text/html; charset=GBK">  
<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.0/jquery.min.js"></script>  
<title >polling test</title>  
</head>  
<body>  
<div id="message"></div>  
</body>  
<script type="text/javascript">  
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
            $("#message").append(data);  
        }  
        catch(e){  
            updater.onError();  
            return;  
        }  
        interval = window.setTimeout(updater.poll, 0);  
    },  
    onError: function(){  
       // console.log("Poll error;");  
    }  
};  
updater.poll();  
</script>  
</html>  