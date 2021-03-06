<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>添加公告</title>
    
	<link rel="stylesheet" type="text/css" href="<%=path%>/css/main.css" />
	<link href="<%=path %>/css/tablecloth.css" rel="stylesheet" />
	<link href="<%=path %>/css/user.css" rel="stylesheet" />
    <link href="<%=path %>/css/types.css" rel="stylesheet" />
    <script type="text/javascript" src="<%=path%>/js/jquery-1.5.1.min.js"></script>	
    <script src="<%=request.getContextPath()%>/js/calendar/WdatePicker.js"></script>
    <script type="text/javascript" src="<%=path%>/js/jquery-ui-1.8.11.custom.min.js"></script>
    
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  </head>
  
  <body>
    <div id="main">
            <div class="toolbar">
            	<p class="toolbar-shadow">&nbsp;</p>
                <div id="toolbar-content">
                    <p class="crumb">
                        <b>您的位置：</b>
                        <a href="/zqoa/index.php/toIndex.htm">首页</a> > 
                        <a href="/zqoa/index.php/User/listUserInfo/assetsList.htm">资产管理</a> >
                        <a href="javascript:void(0);">修改资产 </a>
                    </p>
                </div>
                <a id="toolbar-opt" class="option eject-blue" href="javascript:void(0);return false;">&nbsp;</a>
            </div><!-- toolbar end-->
            <div class="wrap">
            	<fieldset class="forms-area">
                	<h4>资产信息</h4>
                    <form action="" method="post" id="addId" class="add-form">
                    <input type="hidden" name="zqAssetModel.id" value="<s:property value="zqAssetModel.id"/>"/>
                    	<table>
                   			<colgroup span="1"></colgroup>
                        	<tr>
                            	<th>资产编号：</th>
                                <td><input type="text" value="<s:property value="zqAssetModel.sn"/>" name="zqAssetModel.sn" id="sn"/></td>
                            </tr>
                            <tr>
                            	<th>资产名称：</th>
                                <td><input type="text" value="<s:property value="zqAssetModel.assetName"/>" name="zqAssetModel.assetName" id="name"/></td>
                            </tr>
                            <tr>
                            	<th>资产类型：</th>
                                <td><select name="zqAssetModel.type">
                                	<s:iterator value="assetsType">
                                	<option <s:if test="zqAssetModel.type==typeId">selected="selected"</s:if> value="<s:property value="typeId"/>"><s:property value="typeName"/></option>
                                	</s:iterator>
                                		
                                	</select></td>
                             
                            </tr>
                            <tr>
                            	<th>资产价值：</th>
                                <td><input type="text" value="<s:property value="zqAssetModel.value"/>" name="zqAssetModel.value" id="value"/></td>
                            </tr>
                            <tr>
                            	<th>入库时间：</th>
                                <td><input type="text" value="<s:date name="zqAssetModel.inTime" format="yyyy-MM-dd" />" readonly name="zqAssetModel.inTime" id="inTime" onclick="WdatePicker({el:'inTime'})" class="validity"/></td>
                            </tr>
                            <tr>
                            	<th>出库时间：</th>
                                <td><input type="text" value="<s:date name="zqAssetModel.outTime" format="yyyy-MM-dd"/>" readonly name="zqAssetModel.outTime" id="outTime" onclick="WdatePicker({el:'outTime'})" class="validity"/></td>
                            </tr>
                            <tr>
							<tr>
                            	<th>&nbsp;</th>
                                <td><input id="btn-submit" type="button" name="tj" value="提交" /></td>
                            </tr>
                        </table>
                        </form>
                </fieldset>

  </body>
</html>
<script>
$(document).ready(function(){
	$("#btn-submit").click(function(){
		if($.trim($("#name").val())==''){
			alert("请填写名称！");
			return false;
		}
		if($.trim($("#sn").val())==''){
			alert("请填写编号!");
			return false;
		}
		var reg = /^[+]?\d+(.\d+)?$/;
		if(!reg.test($("#value").val())){
			alert("价值只能是非负的整数或小数！");
			return false;
		}
		if(confirm("是否确认修改?")){
			$.ajax({
				type : "post",
				url : "modifyAssets.htm",
				dataType : "json",
				data : $("#addId").serialize(),
				success : function(data) { //成功后返回的页面
					if (data.result == '1'){
						alert("操作成功!");
						window.location.href="assetsList.htm";
					}else{
						alert("服务器异常，请稍后重试!");
					}
				},
				error:function(error){
					alert("网络异常，请重新登录!");
				}
			});
		}
		return false;
	});
});
</script>
