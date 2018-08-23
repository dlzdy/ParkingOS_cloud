var heigth = document.documentElement.clientHeight - 90;
$(".chat-thread")[0].style.height = heigth + "px";
/* $(".chat-thread")[0].style.marginBottom = 220 + "px"; */

var username,password,contacts,fromimg,toimg;
username = document.getElementById("username").value;
password = document.getElementById("password").value;
contacts = document.getElementById("contacts").value;
fromimg = document.getElementById("fromimg").value;
toimg = document.getElementById("toimg").value;

var groupFlagMark = "group--";
var msghistory = new Array();//��ʷ��Ϣ
var lasttime = null;
var showtime = true;//�Ƿ���ʾʱ��
var hasHis = false;//�Ƿ�����ʷ��Ϣ
var allInfo = null;//localstorage����

var today = new Date();
today.setHours(0);
today.setMinutes(0);
today.setSeconds(0);
today.setMilliseconds(0);
today = today/1000;//�����ʼʱ��

//****************һ����ʱ������clientHeight�ı仯begin****************//
function setHeight(clientHeight){
	var nowclientHeight = document.documentElement.clientHeight;
	var height = $(".chat-thread")[0].style.height;
	height = parseInt(height.split("px")[0]);
	$(".chat-thread")[0].style.height = (height - (clientHeight - nowclientHeight)) + "px";
}

window.sessionStorage.setItem("height",document.documentElement.clientHeight);

function checkHeight(){
	var h = window.sessionStorage.getItem("height");
	if(h != null){
		var cheight = document.documentElement.clientHeight;
		if(h != cheight){
			setHeight(h);
			window.localStorage.removeItem("typewriting");
			window.localStorage.setItem("typewriting",Math.abs(h - cheight));
			window.sessionStorage.setItem("height",cheight);
		}
	}
	setTimeout("checkHeight()",100);//0.1���ִ��
}
checkHeight();
//****************һ����ʱ������clientHeight�ı仯end****************//
var getLoacalTimeString = function(time) {
    var date = new Date(time);
    var month = "";
    if(time < today * 1000){
    	month = add_zero(date.getMonth() + 1) + "-" + add_zero(date.getDate()) + " ";
    }
    var time =month + add_zero(date.getHours()) + ":" + add_zero(date.getMinutes())/* + ":"
            + add_zero(date.getSeconds())*/;
    return time;
};

function add_zero(temp){
	 if(temp<10){
		 return "0"+temp;
	 }else{
		 return temp; 
	 }
}

var getLongTime = function(){
	return parseInt(new Date().getTime()/1000);
};

function checkhxuser(){//��ǰ�û���localStorage�洢���û��������������Ϣ
	var hxuser = window.localStorage.getItem("hxuser");
	if(hxuser != null && hxuser != username){
		var hxmsg = window.localStorage.getItem("hxmsg");
		if(hxmsg != null){
			window.localStorage.removeItem("hxmsg");
		}
	}
	window.localStorage.removeItem("hxuser");
	window.localStorage.setItem("hxuser",username);
}
checkhxuser();

//��ȡδ������Ϣ
function unreadMsg(){
	var hxmsg = window.localStorage.getItem("hxmsg");
	if(hxmsg != null){
		allInfo = eval("(" + hxmsg + ")");
		for(var i=0; i<allInfo.length;i++){
			var rosterobj = allInfo[i];
			var rwho = rosterobj.who;
			var rcontent = rosterobj.content;
			if(rwho == contacts){
				for(var j=0; j<rcontent.length; j++){
					var msgobj = rcontent[j];
					var flag = msgobj.flag;
					var from = msgobj.from;//0:������ϵ�� 1���Լ�����Ϣ
					if(parseInt(flag) == 0 && parseInt(from) == 0){//��������ϵ�˷���������δ����Ϣ
						var msg = msgobj.msg;
						var msgtime = msgobj.time;
						if(lasttime != null){//����1������ʾʱ��
							if(Math.abs(msgtime - lasttime) > 60){
								showtime = true;
								lasttime = msgtime;
							}else{
								showtime = false;
							}
						}else{
							showtime = true;
							lasttime = msgtime;
						}
						readMsg(msg,getLoacalTimeString(parseInt(msgtime)*1000),true);//��ȡδ����Ϣ
						msgobj.flag = 1;//���Ϊ�Ѷ�
					}
					
					if(parseInt(flag) > 0){//����ʷ��Ϣ
						hasHis = true;
						msghistory.push(msgobj);
					}
				}
				break;
			}
		}
		if(hasHis){
			$(".chat-thread").prepend('<li class="loadmore"  onclick="loadhis();">�鿴��ʷ��Ϣ</li>');
		}
		window.localStorage.removeItem("hxmsg");//Iphone�п��ܱ������Լ���һ��
		window.localStorage.setItem("hxmsg",JSON.stringify(allInfo));
	}
}
unreadMsg();

function updateLocalStorage(from,flag,who,msg){
	//д��Ϣ��¼
	var hascur = false;
	if(allInfo == null){
		allInfo = new Array();
	}else{
		for(var i=0; i<allInfo.length;i++){
			var rosterobj = allInfo[i];
			var rwho = rosterobj.who;
			var rcontent = rosterobj.content;
			if(rwho == who){
				var newmsg = new Object();
				newmsg.flag = flag;
				newmsg.msg = msg;
				newmsg.time = getLongTime();
				newmsg.from = from;
				rcontent.push(newmsg);
				hascur = true;
				break;
			}
		}
	}
	
	if(!hascur){
		var curObject = new Object();
		curObject.who = who;
		var msgInfo = new Array();
		var msgObject = new Object();
		msgObject.flag = flag;
		msgObject.msg = msg;
		msgObject.time = getLongTime();
		msgObject.from = from;
		msgInfo.push(msgObject);
		curObject.content = msgInfo;
		allInfo.push(curObject);
	}
	window.localStorage.removeItem("hxmsg");//Iphone�п��ܱ������Լ���һ��
	window.localStorage.setItem("hxmsg",JSON.stringify(allInfo));
}

function sendMsg(msg,time){
	if(showtime){
		$(".chat-thread").append('<li class="time">'+time+'</li>');
	}
	$(".chat-thread").append('<li class="contacts"><div><img class="imgcontacts" src="'+toimg+'"/></div><div class="contactsmsg">'+msg+'</div><div class="arrowright"></div></li>');
	var convo = document.getElementById("wechat");
	convo.scrollTop = convo.scrollHeight;
	var message = document.getElementById("message");
	message.value="";
	message.focus();
	//д��Ϣ��¼
	updateLocalStorage(1,1,contacts,msg);
}

function readMsg(msg,time,unread){//unread:true��ʾ�Ƕ��Ѿ��洢��δ����Ϣ false��ʾ�շ���������Ϣ����Ҫ�洢
	if(showtime){
		$(".chat-thread").append('<li class="time"><div>'+time+'</div></li>');
	}
	$(".chat-thread").append('<li class="me"><div><img class="imgme" src="'+fromimg+'"/></div><div class="memsg">'+msg+'</div><div class="arrowleft"></div></li>');
	if(!unread){
		var convo = document.getElementById("wechat");
		convo.scrollTop = convo.scrollHeight;
		//д��Ϣ��¼
		updateLocalStorage(0,1,contacts,msg);
	}
}

function readbeforeMsg(msg,time,msgobj){
	if(msgobj.from == 0){
		$(".chat-thread").prepend('<li class="me"><div><img class="imgme" src="'+fromimg+'"/></div><div class="memsg">'+msgobj.msg+'</div><div class="arrowleft"></div></li>');
	}else if(msgobj.from == 1){
		$(".chat-thread").prepend('<li class="contacts"><div><img class="imgcontacts" src="'+toimg+'"/></div><div class="contactsmsg">'+msgobj.msg+'</div><div class="arrowright"></div></li>');
	}
	if(showtime){
		$(".chat-thread").prepend('<li class="time"><div>'+time+'</div></li>');
	}
	convo.scrollTop = 0;
}

var conn = null;
conn = new Easemob.im.Connection();
var login = function(){
	conn.open({
	     apiUrl : Easemob.im.config.apiURL,
	     user : username,
	     pwd : password,
	     // ����ʱ�ṩappkey
	     appKey : Easemob.im.config.appkey
	});
};

// �����û��������¼ϵͳ
conn.init({
      onOpened : function() {
      	conn.setPresence();// ״̬��Ϊ����
		// ��������
        if (conn.isOpened()) {
            conn.heartBeat(conn);
        }
        /*if(!hasClass($(".mask")[0],"hide")){
        	$(".rules-title")[0].innerHTML = "���ӳɹ�";
 	        $(".img1")[0].src = "images/wxpublic/connected.png";
 	        setTimeout("hidemsg()",1000);//1���ִ��
        }*/
      },
      onTextMessage : function(message){
		var from = message.from;//��Ϣ�ķ�����
        var mestype = message.type;//��Ϣ���͵�������Ⱥ����Ϣ���Ǹ�����Ϣ
        var messageContent = message.data;//�ı���Ϣ��
        //TODO  ������Ϣ���toֵȥ��λ�Ǹ�Ⱥ��������¼
        var room = message.to;
        if (mestype == 'groupchat') {
            appendMsg(message.from, message.to, messageContent, mestype);
        } else {
            appendMsg(from, from, messageContent);
        }
	},
	//�쳣ʱ�Ļص�����
    onError : function(message) {
        handleError(message);
    }
});
login();//��¼

var sendText = function() {
	var msg = document.getElementById("message").value;
	if(msg == ""){
		return false;
	}
    var options = {
        to : contacts,
        msg : msg,
        type : "chat"
    };
    // Ⱥ����Ϣ�͸�����Ϣ���жϷ�֧
    if (contacts.indexOf(groupFlagMark) >= 0) {
        options.type = 'groupchat';
        options.to = curRoomId;
    }
    //easemobwebim-sdk�����ı���Ϣ�ķ��� toΪ���͸�˭��megΪ�ı���Ϣ����
    conn.sendTextMessage(options);
    //��ǰ��¼�˷��͵���Ϣ�����촰����ԭ����ʾ
    var msgtime = parseInt(new Date().getTime()/1000);
    if(lasttime != null){//����1������ʾʱ��
		if(Math.abs(msgtime - lasttime) > 60){
			showtime = true;
			lasttime = msgtime;
		}else{
			showtime = false;
		}
	}else{
		showtime = true;
		lasttime = msgtime;
	}
    sendMsg(msg,getLoacalTimeString(parseInt(msgtime)*1000));
};

function appendMsg(who, contact, message, chattype){
    if (chattype && chattype == 'groupchat') {
    	
    }
    // ��Ϣ�� {isemotion:true;body:[{type:txt,msg:ssss}{type:emotion,msg:imgdata}]}
    var localMsg = null;
    if (typeof message == 'string') {
        localMsg = Easemob.im.Helper.parseTextMessage(message);
        localMsg = localMsg.body;
    } else {
        localMsg = message.data;
    }
    var messageContent = localMsg;
    for (var i = 0; i < messageContent.length; i++) {
        var msg = messageContent[i];
        var type = msg.type;
        var data = msg.data;
        
        if (type == "emotion") {
            
        } else if (type == "pic" || type == 'audio' || type == 'video') {
            var filename = msg.filename;
           	
            if(type == 'audio' && msg.audioShim) {
                
            }
        } else {
        	if(who == contacts){//��ǰ��ϵ�ˣ�ֱ����ʾ����Ϊ�Ѷ���Ϣ
        		var msgtime = parseInt(new Date().getTime()/1000);
        		if(lasttime != null){//����1������ʾʱ��
					if(Math.abs(msgtime - lasttime) > 60){
						showtime = true;
						lasttime = msgtime;
					}else{
						showtime = false;
					}
				}else{
					showtime = true;
					lasttime = msgtime;
				}
        		readMsg(data,getLoacalTimeString(parseInt(msgtime)*1000),false);
        	}else{//�ǵ�ǰ��ϵ�ˣ�δ����Ϣ�洢����
        		updateLocalStorage(0,0,who,data);
        	}
        }
    }
}
var handleError = function(e){
	/*$(".mask").removeClass("hide");
	$(".rules-title")[0].innerHTML = "���ѵ��ߣ���������...";
    $(".img1")[0].src = "images/wxpublic/connecting.gif";*/
	conn.stopHeartBeat(conn);//�ϵ�����,��������
    setTimeout("login()",1500);//1.5���ִ��
};

function hidemsg(){
	addClass($(".mask")[0],"hide");
};

function backHeight(){
	var heigth = document.documentElement.clientHeight - 90;
	$(".chat-thread")[0].style.height = heigth + "px";
	$(".msgfunc").addClass("hide");
}

//===============���»�����ʾ��ʷ��Ϣbegin=============//
var _start = 0, _end = 0, _body = document.getElementById("convo");
_body.addEventListener("touchstart", touchStart, false);
_body.addEventListener("touchmove", touchMove, false);
function touchStart(event) {
	var touch = event.touches[0];
	_start = touch.pageY;
	
	//���ع�����
	var msgfuncid = document.getElementById("msgfuncid");
	if(!hasClass(msgfuncid, "hide")){
		setTimeout("backHeight()",500);//1.5���ִ��
	}
}

function touchMove(event) {
	var touch = event.touches[0];
	_end = (_start - touch.pageY);
	if(_end > 0){
//		$(".history").addClass("hide");
	}else{
//		$(".history").removeClass("hide");
	}
}
//===============���»�����ʾ��ʷ��Ϣend=============//

function loadhis(){
	var wechat = document.getElementById("wechat");
	var children = wechat.childNodes;
	wechat.removeChild(children[0]);
	$(".chat-thread").prepend('<li class="loadinghis"><img src="images/wxpublic/history.gif" /></li>');
	setTimeout("readHisMsg()",1000);//1.5���ִ��
}

function readHisMsg(){
	var wechat = document.getElementById("wechat");
	var children = wechat.childNodes;
	wechat.removeChild(children[0]);
	
	var count = 0;
	if(msghistory != null){
		for(var i=msghistory.length-1; i>=0; i--){
			count++;
			if(count >= 6){//ÿ�μ���5����ʷ��Ϣ
				break;
			}
			var msgobj = msghistory[i];
			var flag = msgobj.flag;
			if(parseInt(flag) > 0){//������ʷ��Ϣ
				var msg = msgobj.msg;
				var msgtime = msgobj.time;
				if(lasttime != null){//����1������ʾʱ��
					if(Math.abs(lasttime - msgtime) > 60){
						showtime = true;
						lasttime = msgtime;
					}else{
						showtime = false;
					}
				}else{
					showtime = true;
					lasttime = msgtime;
				}
				if(count == 5 || msghistory.length == 1){
					showtime = true;
					lasttime = msgtime;
				}
				readbeforeMsg(msg,getLoacalTimeString(parseInt(msgtime)*1000),msgobj);
				msghistory.pop();//�Ƴ��Ѷ���ʷ��Ϣ
			}
			
		}
		if(msghistory.length > 0){//���ж������ʷ��Ϣ
			$(".chat-thread").prepend('<li class="loadmore" onclick="loadhis();">������ʷ��Ϣ</li>');
		}
	}
}

function setfuncHeight(){
	var msgfuncid = document.getElementById("msgfuncid");
	if(hasClass(msgfuncid,"hide")){
		var h = window.localStorage.getItem("typewriting");
		if(h != null){
			$(".msgfunc")[0].style.height = h + "px";
			var height = $(".chat-thread")[0].style.height;
			height = parseInt(height.split("px")[0]);
			$(".chat-thread")[0].style.height = (height - h) + "px";
		}
		$(".msgfunc").removeClass("hide");
	}
}

function showfunc(){
	setTimeout("setfuncHeight()",500);//0.5���ִ��
}

function hidefunc(){
	$(".msgfunc").addClass("hide");
}

//ÿ���Ƴ�һ��class
function removeClass(currNode, curClass){
	var oldClass,newClass1 = "";
    oldClass = currNode.getAttribute("class") || currNode.getAttribute("className");
    if(oldClass !== null) {
	   oldClass = oldClass.split(" ");
	   for(var i=0;i<oldClass.length;i++){
		   if(oldClass[i] != curClass){
			   if(newClass1 == ""){
				   newClass1 += oldClass[i]
			   }else{
				   newClass1 += " " + oldClass[i];
			   }
		   }
	   }
	}
	currNode.className = newClass1; //IE ��FF��֧��
}

//ÿ�����һ��class
function addClass(currNode, newClass){
    var oldClass;
    oldClass = currNode.getAttribute("class") || currNode.getAttribute("className");
    if(oldClass !== null) {
	   newClass = oldClass+" "+newClass; 
	}
	currNode.className = newClass; //IE ��FF��֧��
}
//����Ƿ������ǰclass
function hasClass(currNode, curClass){
	var oldClass;
	oldClass = currNode.getAttribute("class") || currNode.getAttribute("className");
	if(oldClass !== null){
		oldClass = oldClass.split(" ");
		for(var i=0;i<oldClass.length;i++){
		   if(oldClass[i] == curClass){
			   return true;
		   }
	   }
	}
	return false;
}
