
function loaddata(){
	url = "cityparkanly.do?action=parkcolumn";
	$.post(url, function(result) {
		hiddlecontent(result);
	});
}

// ·������
require.config({
    paths: {
        echarts: 'js/echarts',
    }
});
function hiddlecontent(result){
	var data1 = new Array();
	var data2 = new Array();
	var data3 = new Array();
	var yAxisTitle = "����";
	var titleText = "����������ͳ�Ƶ�·�����ͣ�����Ͳ�λ����";
	var subtitleText = "";
	xAxisTitle = "";
	var xAxisCategories = new Array();
	$.each(eval(result), function(i, paydate) {
		if (xAxisCategories[i] == "") {

		} else {
			xAxisCategories[i] = paydate.local;
			data1[i] = parseInt(paydate.road);
			data2[i] = parseInt(paydate.indoor);
			data3[i] = parseInt(paydate.psum);
		}
	});
	// ʹ��
	require(
	    [
	        'echarts',
	        'echarts/chart/line',
		    'echarts/chart/bar',
		    'echarts/chart/scatter',
		    'echarts/chart/k',
		    'echarts/chart/pie',
		    'echarts/chart/radar',
		    'echarts/chart/force',
		    'echarts/chart/chord',
		    'echarts/chart/gauge',
		    'echarts/chart/funnel',
		    'echarts/chart/eventRiver',
		    'echarts/chart/venn',
		    'echarts/chart/treemap',
		    'echarts/chart/tree',
		    'echarts/chart/wordCloud',
		    'echarts/chart/heatmap'
	    ],
	    function (ec) {
	        // ����׼���õ�dom����ʼ��echartsͼ��
	        var myChart1 = ec.init(document.getElementById('chart_container1')); 
	        var myChart2 = ec.init(document.getElementById('chart_container2')); 
	        
	        var option1 = {
	        	    title : {
	        	        text: titleText,
	        	        subtext: ''
	        	    },
	        	    tooltip : {
	        	        trigger: 'axis',
	        	        formatter: function (params) {
	        	            var res = params[0].name;
	        	            res += '<br/>' + params[0].seriesName + params[0].value;
	        	            res += '<br/>' + params[1].seriesName + params[1].value;
	        	            return res;
	        	        }
	        	    },
	        	    legend: {
	        	        data:['��·ͣ��������','���ͣ��������','��λ����']
	        	    },
	        	    toolbox: {
	        	        show : false,
	        	        feature : {
	        	            mark : {show: true},
	        	            dataView : {show: true, readOnly: false},
	        	            magicType : {show: true, type: ['line', 'bar']},
	        	            restore : {show: true},
	        	            saveAsImage : {show: true}
	        	        }
	        	    },
	        	    calculable : false,
	        	    grid: {
	        	        y:80,
	        	        y2:60
	        	    },
	        	    xAxis : [
	        	        {
	        	            type : 'category',
	        	            data : xAxisCategories,
	        	            position:'top',
	        	            axisLabel : {
	        	                show:true,
	        	                interval: 'auto',    // {number}
	        	                rotate: 45
	        	            },
	        	            splitLine : {
	        	                show:true,
	        	                lineStyle: {
	        	                    color: '#483d8b',
	        	                    type: 'dashed',
	        	                    width: 1
	        	                }
	        	            },
	        	            boundaryGap : true
	        	        }
	        	    ],
	        	    yAxis : [
	        	        {
	        	            type : 'value',
	        	            name : yAxisTitle,
	        	            splitNumber: 4,
	        	            splitLine : {
	        	                show:true,
	        	                lineStyle: {
	        	                    color: '#483d8b',
	        	                    type: 'solid',
	        	                    width: 1
	        	                }
	        	            },
	        	        }
	        	    ],
	        	    series : [
	        	        {
	        	            name:'��·ͣ��������',
	        	            type:'bar',
	        	            data:data1,
	        	            markPoint : {
	        	                data : [
	        	                    {type : 'max', name: '���ֵ'},
	        	                    {type : 'min', name: '��Сֵ'}
	        	                ]
	        	            }/*,
	        	            markLine : {
	        	                data : [
	        	                    {type : 'average', name: 'ƽ��ֵ'}
	        	                ]
	        	            }*/
	        	        },
	        	        {
	        	            name:'���ͣ��������',
	        	            type:'bar',
	        	            data:data2,
	        	            markPoint : {
	        	                data : [
	        	                    {type : 'max', name: '���ֵ'},
	        	                    {type : 'min', name: '��Сֵ'}
	        	                ]
	        	            }
	        	        },
	        	        {
	        	            name:'��λ����',
	        	            type:'bar',
	        	            itemStyle: {
	        	                normal: {
	        	                    color: function(params) {
	        	                        return '#9BCA63';
	        	                    }
	        	                }
	        	            },
	        	            data:[]
	        	        }
	        	    ]
	        	};
	        	
	            // Ϊecharts����������� 
	            myChart1.setOption(option1); 
	            var option2 = {
		        	    tooltip : {
		        	        trigger: 'axis'
		        	    },
		        	    legend: {
		        	    	 y : -30,
		        	        data:['��·ͣ��������','���ͣ��������','��λ����']
		        	    },
		        	    calculable : false,
		        	    toolbox: {
		        	        show : false,
		        	        feature : {
		        	            mark : {show: true},
		        	            dataView : {show: true, readOnly: false},
		        	            magicType : {show: true, type: ['line', 'bar']},
		        	            restore : {show: true},
		        	            saveAsImage : {show: true}
		        	        }
		        	    },
		        	    grid: {
		        	        y:80,
		        	        y2:60
		        	    },
		        	    xAxis : [
		        	        {
		        	            type : 'category',
		        	            position:'bottom',
		        	            data : xAxisCategories,
		        	            axisLabel : {
		        	                show:true,
		        	                interval: 'auto',    // {number}
		        	                rotate: 45
		        	            },
		        	            splitLine : {
		        	                show:true,
		        	                lineStyle: {
		        	                    color: '#483d8b',
		        	                    type: 'dashed',
		        	                    width: 1
		        	                }
		        	            }
		        	        }
		        	    ],
		        	    yAxis : [
		        	        {
		        	            type : 'value',
		        	            name : '',
		        	            splitNumber: 4,
		        	            splitLine : {
		        	                show:true,
		        	                lineStyle: {
		        	                    color: '#483d8b',
		        	                    type: 'solid',
		        	                    width: 1
		        	                }
		        	            },
		        	        }
		        	    ],
		        	    series : [
		        	        {
		        	            name:'��λ����',
		        	            type:'bar',
		        	            data:data3,
		        	            markPoint : {
		        	                data : [
		        	                    {type : 'max', name: '���ֵ'},
		        	                    {type : 'min', name: '��Сֵ'}
		        	                ]
		        	            },
		        	            itemStyle: {
		        	                normal: {
		        	                    color: function(params) {
		        	                        return '#9BCA63';
		        	                    }
		        	                }
		        	            }/*,
		        	            markLine : {
		        	                data : [
		        	                    {type : 'average', name: 'ƽ��ֵ'}
		        	                ]
		        	            }*/
		        	        }
		        	    ]
		        	};
		        	
		            // Ϊecharts����������� 
		            myChart2.setOption(option2); 
		            
		            myChart1.connect([myChart2]);
		            myChart2.connect([myChart1]);
	        }
	);
}
