<%@ page language="java" contentType="text/html; charset=gb2312"
         pageEncoding="gb2312"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312">
    <title>NFC��¼</title>
    <link href="css/tq.css" rel="stylesheet" type="text/css">
    <link href="css/iconbuttons.css" rel="stylesheet" type="text/css">

    <script src="js/tq.js?0817" type="text/javascript">//���</script>
    <script src="js/tq.public.js?0817" type="text/javascript">//���</script>
    <script src="js/tq.datatable.js?0817" type="text/javascript">//���</script>
    <script src="js/tq.hash.js?0817" type="text/javascript">//��ϣ</script>
    <script src="js/tq.stab.js?0817" type="text/javascript">//�л�</script>
    <script src="js/My97DatePicker/WdatePicker.js" type="text/javascript">//����</script>
    <script src="js/tq.window.js?0817" type="text/javascript">//����</script>

</head>
<body>
<div id="nfcdetailobj" style="width:100%;height:100%;margin:0px;"></div>
<script >
    var role=${role};
    if(parseInt(role)==15||parseInt(role)==3){
        window.onload = jslimit()
    }
    var btime="${btime}";
    var etime="${etime}";
    var otype='${otype}';
    var total = '${total}';
    var pmoney = '${pmoney}';
    var pmobile = '${pmobile}';
    var pay_type = "${pay_type}";
    var comid = "${comid}";
    var uid=${uid};
    var count=${count};
    var amount;
    var sum;
    //0:�ʻ�֧��,1:�ֽ�֧��,2:����֧��,3:�¿�,4����Ԥ֧���ֽ�,5����Ԥ֧��������,5����Ԥ֧���̼ҿ�
    //var payType=[{'value_no':0,value_name:'�ʻ�֧��'},{'value_no':1,value_name:'�ֽ�'},{'value_no':2,value_name:'����֧��'},{'value_no':3,value_name:'�¿�'},{'value_no':4,value_name:'����Ԥ֧���ֽ�'},{'value_no':5,value_name:'����Ԥ֧��������'},{'value_no':6,value_name:'����Ԥ֧���̼ҿ�'},{'value_no':8,value_name:'���'},{'value_no':9,value_name:'ˢ��'}];
    //1:�ֽ�֧��,2:����֧��,3:�¿�,8����֧��
    var payType=[{'value_no':1,value_name:'�ֽ�'},{'value_no':2,value_name:'����֧��'},{'value_no':3,value_name:'�¿�'},{'value_no':8,value_name:'���'}];
    var tip = "��������";
    var _mediaField = [
        {fieldcnname:"���",fieldname:"id",fieldvalue:'',inputtype:"number", twidth:"100" ,height:"",hide:true},
        {fieldcnname:"ͣ������",fieldname:"create_time",inputtype:"text", twidth:"200" ,issort:false},
        {fieldcnname:"��������",fieldname:"end_time",inputtype:"text", twidth:"200" ,issort:false},
        {fieldcnname:"�������",fieldname:"amount_receivable",inputtype:"text", twidth:"100",issort:false,
            process:function(value,cid,id){
                sum = value
                return value;
            }},
//        {fieldcnname:"�ֽ�֧��",fieldname:"cashMoney",inputtype:"text", twidth:"100" ,issort:false},
        {fieldcnname:"�ֽ����",fieldname:"cash_pay",inputtype:"text", twidth:"100" ,issort:false},
        {fieldcnname:"�ֽ�Ԥ��",fieldname:"cash_prepay",inputtype:"text", twidth:"100" ,issort:false},
        {fieldcnname:"����֧��",fieldname:"elecMoney",inputtype:"text", twidth:"100" ,issort:false},
        {fieldcnname:"���֧��",fieldname:"freeMoney",inputtype:"text", twidth:"100" ,issort:false},
        {fieldcnname:"����ȯ֧��",fieldname:"reduceMoney",inputtype:"text", twidth:"100" ,issort:false},
        {fieldcnname:"ͣ��ʱ��",fieldname:"duration",inputtype:"text", twidth:"200" ,issort:false},
        {fieldcnname:"֧����ʽ",fieldname:"pay_type",inputtype:"select", noList:payType,twidth:"100",issort:false},

        //{fieldcnname:"NFC����",fieldname:"nfc_uuid",inputtype:"text", twidth:"200",issort:false},
        {fieldcnname:"���ƺ�",fieldname:"car_number",fieldvalue:'',inputtype:"text", twidth:"150" ,height:"",issort:false},
        {fieldcnname:"�鿴����ͼƬ",fieldname:"order_id_local",inputtype:"text", twidth:"100",issort:false,
            process:function(value,cid,id){
                return "<a href=# onclick=\"viewdetail('hn','"+value+"','"+cid+"')\" style='color:blue'>�鿴����ͼƬ</a>";
            }}
    ];
    var _nfcdetailT = new TQTable({
        tabletitle:tip,
        ischeck:false,
        tablename:"nfcdetail_tables",
        dataUrl:"orderanly.do",
        iscookcol:false,
        buttons:false,
        quikcsearch:coutomsearch(),
        param:"action=orderdetail&uid="+uid+"&btime="+btime+"&etime="+etime+"&otype="+otype+"&count="+count+"&pay_type="+pay_type+"&comid="+comid,
        tableObj:T("#nfcdetailobj"),
        fit:[true,true,true],
        tableitems:_mediaField,
        allowpage:false,
        isoperate:false
    });

    function coutomsearch(){
        var tip = "ʱ�䣺"+btime+" �� "+etime;
        if(otype=='today')
            tip="���ն���";
        else if(otype=='toweek')
            tip="���ܶ���";
        else if(otype=='lastweek')
            tip="���ܶ���";
        else if(otype=='tomonth')
            tip="���¶���";
        var html=   tip;
        /*if(pay_type==7){
            var html=   tip+" ���ϼ���ѣ�<font color='red'>"+total+"</font> Ԫ ";//"&nbsp;&nbsp;�ϼ���ѣ�900.00Ԫ";
        }else{
            var html=   tip+" ���ϼƣ�<font color='red'>"+total+"</font> Ԫ�������ֽ�֧�� ��<font color='red'>"+pmoney+"</font>Ԫ������֧�� ��<font color='red'>"+pmobile+"</font>Ԫ����<font color='red'> "+count+" </font>�� ";//"&nbsp;&nbsp;�ܼƣ�900.00Ԫ";
        }*/
        return html;
    }
    //�鿴ͳ�Ʒ����еĶ���ͼƬ���޸�Ϊ����չʾͼƬ�ķ�ʽ
    /*function viewdetail(type,value,id){
        var car_number =_nfcdetailT.GD(id,"car_number");
        var tip = "����ͼƬ";
        Twin({
            Id:"carpics_detail_"+id,
            Title:tip+"  --> ���ƣ�"+car_number,
            Width:T.gww()-100,
            Height:T.gwh()-50,
            sysfunI:id,
            Content:"<iframe name='carpics_detail_'"+id+" id='carpics_detail_'"+id+" src='order.do?action=carpics&orderid="+id+"' width='100%' height='"+(T.gwh()-100)+"' frameborder='0' style='overflow:auto;' ></iframe>"
        })
    }*/
    function viewdetail(type,value,id){
        var car_number =_nfcdetailT.GD(id,"car_number");
        var orderIdLocal =_nfcdetailT.GD(id,"order_id_local");
        var tip = "����ͼƬ";
        Twin({
            Id:"carpics_detail_"+id,
            Title:tip+"  --> ���ƣ�"+car_number,
            Width:T.gww()-100,
            Height:T.gwh()-50,
            sysfunI:id,
            /*�޸�ͼƬע��ԭ�������߼�*/
            /* Content:"<iframe name='carpics_detail_'"+id+" id='carpics_detail_'"+id+" src='order.do?action=carpics&orderid="+id+"&comid="+comid+"&r="+Math.random()+"' width='100%' height='"+(T.gwh()-100)+"' frameborder='0' style='overflow:auto;' ></iframe>" */
            Content:"<iframe name='carpics_detail_'"+id+" id='carpics_detail_'"+id+" src='order.do?action=carpicsnew&orderid="+orderIdLocal+"&comid="+comid+"&r="+Math.random()+"' width='100%' height='"+(T.gwh()-100)+"' frameborder='0' style='overflow:auto;' ></iframe>"
        })
    }
    _nfcdetailT.C();
</script>

</body>
</html>
