
var ZLD ={};
ZLD.getObj=function(id){return document.getElementById(id)};
ZLD.getH=function(){
	return  ZLD.getObj('body').offsetHeight;
};
ZLD.getW=function(){
	return  ZLD.getObj('body').offsetWidth;
}
ZLD.setobjCss = function(obj,css){
	for(var c in css){
		obj.style[c]=css[c];
	}
}
ZLD.getClientType=function (){//bnums ʣ���ӵ�����
	var sourcetag = navigator.userAgent;
	if(navigator.userAgent.indexOf("MicroMessenger")==-1){
		if(sourcetag.indexOf("Android")!=-1){//����android
			return "and";
		}else if(sourcetag.indexOf("iPhone")!=-1){//����iphone
			return "ios";
		}
	}else{
		return "wx";
	}
}

var zldWin={
		h : ZLD.getH(),
		showH:function(){return ZLD.getH();}
};

