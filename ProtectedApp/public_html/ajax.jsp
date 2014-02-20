<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page contentType="text/html;charset=ISO-8859-1"%>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1"/>
</head>
<body>
<%@include file="links.jsp" %>

<script language="JavaScript">

//function makeAJAXCall() {
//    xmlhttp = window.XMLHttpRequest?new XMLHttpRequest(): new ActiveXObject("Microsoft.XMLHTTP");
//    xmlhttp.onreadystatechange = parseResponse;
//    xmlhttp.open("GET", "reloader.jsp");
//    //xmlhttp.setRequestHeader("If-Modified-Since", "Sat, 1 Jan 2000 00:00:00 GMT");
//    xmlhttp.send(null);   
//}
//
//function parseResponse() {
//    if ((xmlhttp.readyState == 4) && (xmlhttp.status == 200))
//    {
//        alert( "Got response" );
//        xmlhttp.get
//    }    
//}

var timer = null;
var lastHost = "";
var lastServer = "";
var lastCount = 0;

var numRequests = 0;

function reqListener () {
    //console.log(this.responseText);
    numRequests++;
    
    var host = this.getResponseHeader("ServerHost");
    var server = this.getResponseHeader("ManagedServer");
    var count = parseInt( this.getResponseHeader("RequestCount") );
    
    document.getElementById("numrequests").innerHTML = numRequests;
    document.getElementById("host").innerHTML = host;
    document.getElementById("server").innerHTML = server;
    document.getElementById("count").innerHTML = count;

    
    // Handle the "First time" case
    if ( "" == lastHost )
        lastHost = host;
    
    if ( "" == lastServer )
        lastServer = server;
    
    if ( "" == lastCount )
        lastCount = count;

    //alert( "Last Host: " + lastHost + "\r\n" + "Host: " + host );
    
    var error = "";
    if ( host != lastHost )
        error += "* host changed from " + lastHost + " to " + host + "\r\n";

    if ( server != lastServer )
        error += "* server changed from " + lastServer + " to " + server + "\r\n";

    // count is a different case    
    if ( count < lastCount )
        error += "* count decreased from " + lastCount + " to " + count + "\r\n";
    
    if ( "" != error ) {
        stopTimer();
        alert( "ERROR:" + error );
    }
    else
        console.log( "no errors" );
    
    //startTimer();
    //makeAJAXCall();
  
};


function makeAJAXCall()
{
    //window.clearInterval(timer);
    
    var oReq = new XMLHttpRequest();
    oReq.onload = reqListener;
    
    //oReq.addEventListener("progress", updateProgress, false);
    //oReq.addEventListener("load", transferComplete, false);
    //oReq.addEventListener("error", transferFailed, false);
    //oReq.addEventListener("abort", transferCanceled, false);
    
    
    oReq.open("get", "reloader.jsp", true);
    oReq.send();
}

function updateProgress (oEvent) {
    var percentComplete = "Unknown";

    if (oEvent.lengthComputable) {
        var percentComplete = oEvent.loaded / oEvent.total;
    }
    
    console.log( "Progress: " + percentComplete );
}

function transferComplete(evt) {
    console.log("The transfer is complete.");
}

function transferFailed(evt) {
    alert("An error occurred makeing AJAX call.");
}

function transferCanceled(evt) {
    alert("The transfer has been canceled by the user.");
}

function startTimer() {
    if ( null == timer )
        timer = setInterval(function(){makeAJAXCall()},400);

    //document.getElementById("startButton").disabled="disabled";
    document.forms["buttons"].startButton.disabled="disabled";
    document.forms["buttons"].stopButton.disabled="";
}

function stopTimer() {
    window.clearInterval(timer);
    timer = null;
    document.forms["buttons"].stopButton.disabled="disabled";
    document.forms["buttons"].startButton.disabled="";
}


</script>
<form name="buttons">
<table border=0>
<tr><td align="right" bgcolor="Silver">Num Requests Sent:</td><td width="300"><div id="numrequests"></div></td></tr>
<tr><td align="right" bgcolor="Silver">Count:</td><td><div id="count"></div></td></tr>
<tr><td align="right" bgcolor="Silver">Host:</td><td><div id="host"></div></td></tr>
<tr><td align="right" bgcolor="Silver">Server:</td><td><div id="server"></div></td></tr>
<tr><td colspan="2" align="center" bgcolor="Silver">
<input type="button" name="startButton" value=" Start AJAX calls" onclick="startTimer();"/>
<input type="button" name="stopButton" value=" Stop " onclick="stopTimer();" disabled="disabled"/>
</td></tr>
<tr><td colspan="2" align="center" bgcolor="Silver">
<input type="checkbox" name="morecookies">Ask for additional cookies</input>
</td></tr>
</table>
</form>

<P/>
</body>
</html>