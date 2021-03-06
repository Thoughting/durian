<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@include file="/WEB-INF/commons/taglibs.jsp"%>
<%@include file="/WEB-INF/commons/common-header.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<script type="text/javascript">
	$(function() {
		$("#del")
				.click(
						function() {
							var items = mimo.select();
							if (items && items.length <= 0) {
								alert("请先选择要删除的内容");
								return false;
							}

							if (confirm("你确定要删除这些内容吗?")) {

								$('input[name="_method"]').remove();
								$("#myForm")
										.attr("action",
												"${ctx}/guestbook/delete/")
										.attr("method", "post")
										.append(
												'<input type="hidden" name="_method" value="DELETE" />')
										.submit();

								return false;
							}
						});
	});
</script>
</head>
<body>
	<div class="nrgt">
		<form id="myForm" action="${ctx }/guestbook/list/" method="get">
			<div class="chsm">
				<span>站点留言管理</span>
			</div>
			<div class="czsrt">
				<span>你可以：</span>
				<shiro:hasPermission name="guestbook:delete">
					<input class="tjbtn" id="del" type="button" value="删除" />
				</shiro:hasPermission>
				<span class="dist">名称：</span><input name="params[author]"
					value="${page.params.author}" type="text" /><input class="tjbtn"
					type="submit" value="提交" />
			</div>
			<p>${message.text }</p>
			<div class="rcd_td">
				<table cellpadding="0" cellspacing="0" border="0" class="table">
					<tr>
						<th style="border-left: 0;" width="5%"><jsp:include
								page="/WEB-INF/commons/checkall.jsp"></jsp:include>&nbsp;</th>
						<th>留言者</th>
						<th>Email</th>
						<th>状态</th>
						<th>内容</th>
						<th>留言时间</th>
						<th>操作</th>
					</tr>
					<c:choose>
						<c:when test="${not empty page.result }">
							<c:forEach items="${page.result }" var="guestbook">
								<tr>
									<td style="border-left: 0;"><input type="checkbox"
										name="items" id="checkbox" value="${guestbook.id}" /></td>
									<td>${guestbook.author}${guestbook.admin == 'true' ?
										'[管理员]' : '[匿名用户]'}&nbsp;</td>
									<td>${guestbook.email}&nbsp;</td>
									<td>${guestbook.status == 1 ? '[正常]&nbsp;' :
										'[审核中]&nbsp;'}&nbsp;</td>
									<td>${fn:substring(guestbook.content,0,15)}&nbsp;</td>
									<td class="date">${guestbook.createTime}&nbsp;</td>
									<td><shiro:hasPermission name="guestbook:edit">
											<a href="${ctx }/guestbook/${guestbook.id}/edit/">编辑</a>&nbsp;
		</shiro:hasPermission></td>
								</tr>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<tr>
								<td colspan="7" align="center"><b>暂无内容</b></td>
							</tr>
						</c:otherwise>
					</c:choose>
				</table>
				<!--page-->
				<div class="page"><jsp:include
						page="/WEB-INF/commons/page.jsp" /></div>
			</div>
		</form>
	</div>
</body>
</html>
