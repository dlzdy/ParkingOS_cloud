//*****isScroll����*****//
var OFFSET = 5;
var page = 1;
var PAGESIZE = 9999;

var myScroll,
	pullDownEl, pullDownOffset,
	pullUpEl, pullUpOffset,
	generatedCount = 0;
var maxScrollY = 0;
var hasMoreData = false;
//********************//
var timeout;
var t1 = null;
var choosedEle;
var username,password;
username = document.getElementById("username").value;
password = document.getElementById("password").value;

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
if(username != "" && password != ""){//��Ϣ�����ͼ�鵱ǰ��¼�û��ʹ洢���û��ǲ���һ��������һ�������֮ǰ���û�������Ϣ
	checkhxuser();
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

function getImages(roster){
	if(roster.length > 0){
		var rosters;
		for(var i=0;i<roster.length;i++){
			if(i == 0){
				rosters = roster[i].name;
			}else{
				rosters += "," + roster[i].name;
			}
		}
		jQuery.ajax({
			type : "post",
			url : "wxpchat.do",
			data : {
				'action' : 'getimages',
				'rosters' : rosters,
				'r' : Math.random()
			},
			async : false,
			success : function(result) {
				var jsonData = eval("(" + result + ")");
				for(var i=0;i<jsonData.length;i++){
					var contacts = jsonData[i];
					var hxname = contacts.hx_name;
					var wxname = contacts.wx_name;
					var wximg = contacts.wx_imgurl;
					for(var j=0;j<roster.length;j++){
						var r = roster[j].name;
						if(r == hxname){
							roster[j].wxname = wxname;
							roster[j].wximg = wximg;
							break;
						}
					}
				}
			}
		});
	}
}

function loaded(roster) {
	pullDownEl = document.getElementById('pullDown');
	pullDownOffset = pullDownEl.offsetHeight;
	pullUpEl = document.getElementById('pullUp');
	pullUpOffset = pullUpEl.offsetHeight;
	hasMoreData = false;
	page = 1;
	$("#thelist").show();
	$("#pullDown").hide();
	myScroll = new iScroll('wrapper', {
		useTransition: true,
		topOffset: pullDownOffset,
		onRefresh: function() {
			
		},
		onScrollMove: function() {
			
		},
		onScrollEnd: function() {
			
		}
	});
	$("#thelist").empty();
	
	// ��ȡ��ǰ��¼�˵ĺ����б�
	for (var i=0;i< roster.length;i++) {
		var ros = roster[i]; // ���ѵĶ���
		$("#thelist").append('<li id="roster_'+ros.name+'"><span class="subscription hide">'+ros.subscription+'</span><img src="'+ros.wximg+'" /><div class="username">'+ros.wxname+'<span class="circle hide"></span></div></li>');
		//==============�������̰�����begin====================//
		$("#roster_"+ros.name).bind("click", function(){
			choosedEle = window.event.currentTarget.id;
			window.location.href = "wxpchat.do?action=tochat&username="+username+"&contacts="+choosedEle.split("_")[1];
		});
		
		/*$("#roster_"+ros.name).bind("touchstart", function(){
			t1 = new Date().getTime();
			choosedEle = window.event.currentTarget.id;
		    timeout = setTimeout(function() {
		    	delroster();
			   clearTimeout(timeout); 
		    }, 1500); 
		});
		
		$("#roster_"+ros.name).bind("touchend", function(){
			choosedEle = window.event.currentTarget.id;
			var t2 = new Date().getTime();
			if(t2 - t1 > 1000){// �㳤��
//				 alert("1����");
			}else{// �̰�
//				 alert("����1s");
				//window.location.href = "wxpchat.do?action=tochat&username="+username+"&password="+password+"&contacts="+choosedEle.split("_")[1];
			}
			clearTimeout(timeout);
		});*/
		//==============�������̰�����end====================//
		var hxmsg = window.localStorage.getItem("hxmsg");
		var allInfo = null;
		if(hxmsg != null){
			allInfo = eval("(" + hxmsg + ")");
		}
		setUnread(allInfo,ros.name);
	 }
	myScroll.refresh();
}

//�����û��������¼ϵͳ
conn.init({
      onOpened : function() {
      	conn.setPresence();// ״̬��Ϊ����
		// ��������
        if (conn.isOpened()) {
            conn.heartBeat(conn);
        }
        conn.getRoster({//��ȡ�����б�
		       success : function(roster) {
		    	   if($("#thelist")[0].children.length == 0){
		    		   getImages(roster);
		    		   loaded(roster);
		    	   }
				}
        });
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
if(username != "" && password != ""){//��Ϣ�����͵�½
	login();//��¼
}else{//��Ϣ��ȫ�Ͳ���½
	$("#pullDown").hide();
}

var handleError = function(e){
	conn.stopHeartBeat(conn);//�ϵ�����,��������
    setTimeout("login()",1500);//�����ִ��
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
        	var hxmsg = window.localStorage.getItem("hxmsg");
        	var allInfo;
        	var hascur = false;
        	if(hxmsg == null){
        		allInfo = new Array();
        	}else{
        		allInfo = eval("(" + hxmsg + ")");
        		for(var i=0; i<allInfo.length;i++){
        			var rosterobj = allInfo[i];
        			var rwho = rosterobj.who;
        			var rcontent = rosterobj.content;
        			if(rwho == who){
        				var newmsg = new Object();
        				newmsg.flag = 0;
        				newmsg.msg = data;
        				newmsg.time = getLongTime();
        				newmsg.from = 0;
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
        		msgObject.flag = 0;
        		msgObject.msg = data;
        		msgObject.time = getLongTime();
        		msgObject.from = 0;
        		msgInfo.push(msgObject);
        		curObject.content = msgInfo;
        		allInfo.push(curObject);
    		}
    		window.localStorage.removeItem("hxmsg");//Iphone�п��ܱ������Լ���һ��
    		window.localStorage.setItem("hxmsg",JSON.stringify(allInfo));
        	setUnread(allInfo,who);
        }
    }
}

function setUnread(allInfo,who){//������ϵ��δ����Ϣ����
	if(allInfo != null){
		var count = 0;
		for(var i=0; i<allInfo.length;i++){
			var rosterobj = allInfo[i];
			var rwho = rosterobj.who;
			var rcontent = rosterobj.content;
			if(rwho == who){
				for(var j=0;j<rcontent.length;j++){
					var curobject = rcontent[j];
					var flag = curobject.flag;
					var from = curobject.from;//0:������ϵ�� 1���Լ�����Ϣ
					if(parseInt(flag) == 0 && parseInt(from) == 0){//��ȡδ����Ϣ����
						count++;
					}
				}
				break;
			}
		}
		if(count > 0){
			for(var i=0; i<$("#thelist")[0].children.length;i++){
				var id = $("#thelist")[0].children[i].id;
				var roster = id.split("_")[1];
				if(roster == who){
					removeClass($(".circle")[i],"hide");
					if(count > 99){
						count = "99+";
					}
					$(".circle")[i].innerHTML = count;
				}
			}
		}
	}
}

function delroster(){
	alert(choosedEle);
}

function tochat(){
	
}

// ÿ���Ƴ�һ��class
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
	currNode.className = newClass1; // IE ��FF��֧��
}

// ÿ�����һ��class
function addClass(currNode, newClass){
    var oldClass;
    oldClass = currNode.getAttribute("class") || currNode.getAttribute("className");
    if(oldClass !== null) {
	   newClass = oldClass+" "+newClass; 
	}
	currNode.className = newClass; // IE ��FF��֧��
}
// ����Ƿ������ǰclass
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

// ��չDate��format����
Date.prototype.format = function (format) {  
  var o = {  
      "M+": this.getMonth() + 1,  
      "d+": this.getDate(),  
      "h+": this.getHours(),  
      "m+": this.getMinutes(),  
      "s+": this.getSeconds(),  
      "q+": Math.floor((this.getMonth() + 3) / 3),  
      "S": this.getMilliseconds()  
  }  
  if (/(y+)/.test(format)) {  
      format = format.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));  
  }  
  for (var k in o) {  
      if (new RegExp("(" + k + ")").test(format)) {  
          format = format.replace(RegExp.$1, RegExp.$1.length == 1 ? o[k] : ("00" + o[k]).substr(("" + o[k]).length));  
      }  
  }  
  return format;  
}

/**
 * ת��longֵΪ�����ַ���
 * 
 * @param l
 *            longֵ
 * @param isFull
 *            �Ƿ�Ϊ��������������, Ϊtrueʱ, ��ʽ��"2000-03-05 01:05:04" Ϊfalseʱ, ��ʽ��
 *            "2000-03-05"
 * @return ����Ҫ��������ַ���
 */    

function getSmpFormatDateByLong(l, isFull) {  
   return getSmpFormatDate(new Date(l), isFull);  
}  

/**
 * ת�����ڶ���Ϊ�����ַ���
 * 
 * @param date
 *            ���ڶ���
 * @param isFull
 *            �Ƿ�Ϊ��������������, Ϊtrueʱ, ��ʽ��"2000-03-05 01:05:04" Ϊfalseʱ, ��ʽ��
 *            "2000-03-05"
 * @return ����Ҫ��������ַ���
 */    
function getSmpFormatDate(date, isFull) {  
    var pattern = "";  
    if (isFull == true || isFull == undefined) {  
        pattern = "yyyy-MM-dd hh:mm:ss";  
    } else {  
        pattern = "yyyy-MM-dd";  
    }  
    return getFormatDate(date, pattern);  
} 

/**
 * ת�����ڶ���Ϊ�����ַ���
 * 
 * @param l
 *            longֵ
 * @param pattern
 *            ��ʽ�ַ���,���磺yyyy-MM-dd hh:mm:ss
 * @return ����Ҫ��������ַ���
 */    
 function getFormatDate(date, pattern) {  
     if (date == undefined) {  
         date = new Date();  
     }  
     if (pattern == undefined) {  
         pattern = "yyyy-MM-dd hh:mm:ss";  
     }  
     return date.format(pattern);  
 }

 var getLoacalTimeString = function() {
	    var date = new Date();
	    var time =date.getMonth() + "-" + date.getDay() + " " + date.getHours() + ":" + date.getMinutes() + ":"
	            + date.getSeconds();
	    return time;
	};
	
var getLongTime = function(){
	return parseInt(new Date().getTime()/1000);
};