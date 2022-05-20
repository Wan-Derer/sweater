<#import "parts/common.ftlh" as common>
<#import "parts/login.ftlh" as login>

<@common.page>
    <div class="mb-5">
        <h3>Добавление нового пользователя</h3>
    </div>
    ${message!}
    <@login.login "/registration" true/>

</@common.page>


