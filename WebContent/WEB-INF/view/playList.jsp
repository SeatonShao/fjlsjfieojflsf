<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/taglibs.jsp"%>
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>播放列表</title>
<link rel="stylesheet" type="text/css"
	href="${ctx}/easyui/themes/default/easyui.css">
<link rel="stylesheet" type="text/css"
	href="${ctx}/easyui/themes/icon.css">
<link rel="stylesheet" type="text/css"
	href="${ctx}/easyui/demo/demo.css">
<style type="text/css">
a:link {
	color: blue
} /* 未被访问的链接     蓝色 */
a:visited {
	color: blue
} /* 已被访问过的链接   蓝色 */
a:hover {
	color: blue
} /* 鼠标悬浮在上的链接 蓝色 */
a:active {
	color: blue
} /* 鼠标点中激活链接   蓝色 */
</style>
<script type="text/javascript" src="${ctx}/easyui/jquery.min.js"></script>
<script type="text/javascript" src="${ctx}/js/common.js"></script>
<script type="text/javascript" src="${ctx}/js/extJquery.js"></script>
<script type="text/javascript" src="${ctx}/easyui/jquery.easyui.min.js"></script>
<script type="text/javascript">
	//DataGrid字段设置
	var play_list_datagrid_columns = [ [
			{
				field : 'id',
				title : '编号',
				width : 150,
				checkbox : true,
				align : 'center'
			},
			{
				field : 'name',
				title : '视频名称',
				width : 100,
				align : 'center'

			},
			{
				field : 'contentType',
				title : '类型',
				width : 100,
				align : 'center'
			},
			{
				field : 'status',
				title : '状态',
				width : 100,
				align : 'center'
			},
			{
				field : 'createTime',
				title : '创建时间',
				width : 100,
				align : 'center',
				formatter : function(value, row, index) {
					var date = new Date(value);
					return date.getFullYear() + "-" + (date.getMonth() + 1)
							+ "-" + date.getDate();
				}
			}, {
				field : 'mediaLength',
				title : '文件大小',
				width : 100,
				align : 'center',
				formatter : function(value, row, index) {
					var str = parseInt(row.mediaLength);
					if (str / (1024 * 1024) > 1) {
						return (str / (1024 * 1024)).toFixed(2) + "M";
					} else if (str / (1024) > 1) {
						return (str / 1024).toFixed(2) + "k";
					} else {
						return str;
					}
				}
			}, {
				field : 'action',
				title : '操作',
				width : 160,
				align : 'center',
				formatter : play_list_Formatter
			} ] ];
	//定义相关的操作按钮
	function play_list_Formatter(value, row, index) {
		var str = '';
		str += formatString(
				'<a onclick="deleteOne(\'{0}\',\'{1}\',\'play_dg\');">删除</a>',
				row.id, '${ctx}/PlayList');
		str += '&nbsp;';
		return str;
	}

	$(document).ready(function() {
		/** 初始化DataGrid,加载数据 **/
		$('#play_dg').datagrid({
			url : '${ctx}/PlayList',
			queryParams : {
				method : 'list'
			},
			remoteSort : false,
			singleSelect : true,
			nowrap : false,
			fitColumns : true,
			rownumbers : true,
			idField : 'id',
			pagination : true,
			pageList : [ 10, 15, 20, 30, 40, 50 ],
			columns : play_list_datagrid_columns,
		}).datagrid("getPager").pagination({
			beforePageText : '第', //页数文本框前显示的汉字    
			afterPageText : '页/{pages}页',
			displayMsg : '共{total}条记录',
			onBeforeRefresh : function() {
				return true;
			}
		});
		$("#play_searchBtn").click(function() {
			$('#play_dg').datagrid("reload", {
				method:'list',
					mediaName : $("#mediaName").val(),
				
			});
		});
		$("#play_clearBtn").click(function() {
			 $("#mediaName").val("");
			$('#play_dg').datagrid("reload", {
				method:'list'
			});
		});
	});
</script>
</head>
<body>
	<div
		data-options="region:'north',border:false,title:'查询条件',iconCls:'icon-find'"
		style="height: 65px; overflow: hidden;">

		视频名称: <input class="easyui-validatebox" type="text" name="mediaName"
			id="mediaName"> <a href="#" class="easyui-linkbutton"
			id="play_searchBtn" iconCls="icon-search">查找</a> <a href="#"
			class="easyui-linkbutton" id="play_clearBtn" iconCls="icon-clear">清空</a>

	</div>
	<div data-options="region:'center',border:false">
		<table id="play_dg" style="display: none;"></table>
	</div>


</body>
</html>