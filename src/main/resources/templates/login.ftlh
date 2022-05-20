<#import "parts/common.ftlh" as common>
<#import "parts/login.ftlh" as login>

<@common.page>
<h3>Вход в систему</h3>
<@login.login "/login" false/>
</@common.page>
