<#import "parts/common.ftlh" as common>
<#import "parts/login.ftlh" as login>

<@common.page>
    <h3>Добавление нового пользователя</h3>
    ${message}
    <@login.login("/registration")/>
</@common.page>


