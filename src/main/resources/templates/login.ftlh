<#import "parts/common.ftlh" as common>
<#import "parts/login.ftlh" as login>

<@common.page>
    <h3>Вход в систему</h3>
    ${message!}
    <@login.login "/login" false/>
</@common.page>
