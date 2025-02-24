<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:include page="/common/header.jsp" />
<form id="frm-insert" action="servletInsert">
    <table class="table-horizontal">
        <colgroup>
            <col style="width: 15%;" />
            <col style="width: 35%;" />
            <col style="width: 15%;" />
            <col style="width: 35%;" />
        </colgroup>
        <tbody>
        <tr>
            <th><label class="ess">Title</label></th>
            <td><input type="text" name="title" value="title1" required="required" /></td>
            <th><label class="ess">Writer</label></th>
            <td><input type="text" name="writer" value="writer1" required="required" /></td>
        </tr>
        <tr>
            <th><label class="ess">Content</label></th>
            <td colspan="3"><textarea name="text" class="textarea" required="required" >content1</textarea></td>
        </tr>
        </tbody>
    </table>
    <div class="btns-foot">
        <div class="left"></div>
        <div class="center">
            <button type="submit" class="btn btn-default primary">수정</button>
            <button class="btn btn-default">취소</button>
        </div>
        <div class="right"></div>
    </div>
</form>

<jsp:include page="/common/footer.jsp" />