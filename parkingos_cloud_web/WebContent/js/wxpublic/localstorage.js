
var hxmsg = window.localStorage.getItem("hxmsg");

function checkMsg(){
	var readsize = 0;
	var unreadsize = 0;
	if(hxmsg != null){
		var allinfo = eval("(" + hxmsg + ")");
		for(var i=0; i<allinfo.length;i++){
			var content = allinfo[i].content;
			for(var j=0; j<content.length; j++){
				var msgobj = content[j];
				var flag = msgobj.flag;
				var msgsize = msgobj.msg.length * 2;
				if(parseInt(flag) == 0){
					unreadsize += msgsize;
				}else{
					readsize += msgsize;
				}
			}
		}
	}
	
	if(readsize > 1 *1024 *1024){//�Ѷ���Ϣ����1M������Ѷ���Ϣ
		cleanMsg(1);
	}
	
	if(unreadsize > 2*1024*1024){//δ����Ϣ����2M�������Ϣ
		cleanMsg(1);
		cleanMsg(0);
	}
}

Array.prototype.remove=function(dx) 
{ 
    if(isNaN(dx) || dx > this.length){
    	return false;
    } 
    for(var i=0,n=0;i<this.length;i++) 
    { 
        if(this[i] != this[dx])
	        { 
	            this[n++]=this[i];
	        } 
    } 
    this.length-=1;
};

function cleanMsg(flag){
	if(hxmsg != null){
		var allinfo = eval("(" + hxmsg + ")");
		for(var i=0; i<allinfo.length;i++){
			var content = allinfo[i].content;
			for(var j=content.length -1; j>=0; j--){//��������ɾ���������±����
				var msgobj = content[j];
				var f = msgobj.flag;
				if(f == flag){
					content.remove(j);
				}
			}
		}
		
		window.localStorage.removeItem("hxmsg");//Iphone�п��ܱ������Լ���һ��
		window.localStorage.setItem("hxmsg",JSON.stringify(allinfo));
	}
}

checkMsg();