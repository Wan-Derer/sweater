<#import "parts/common.ftlh" as common>
<#import "parts/login.ftlh" as login>

<@common.page>
<h3>Вход в систему</h3>
<@login.login "/login" />
<a href="/registration">Регистрация нового пользователя</a>
</@common.page>
