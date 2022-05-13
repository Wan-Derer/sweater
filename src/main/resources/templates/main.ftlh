<#import "parts/common.ftlh" as common>
<#import "parts/login.ftlh" as login>

<@common.page>
    <div>
        <@login.logout/>
    </div>

    <div>
        <form method="post">
            <label>Новое сообщение:
                <input type="text" name="text" placeholder="Введите сообщение"/>
                <input type="text" name="tag" placeholder="Тэг"/>
                <input type="hidden" name="_csrf" value="${_csrf.token}"/>
                <button type="submit">ДОБАВИТЬ</button>
            </label>
        </form>
    </div>

    <div><h3>Список сообщений</h3></div>
    <form method="get" action="/main">
        <label>Фильтр:
            <input type="text" name="filter" placeholder="фильтр по тэгу" value="${filter}">
            <button type="submit">Найти</button>
        </label>
    </form>

    <#list messages as message>
        <div>
            <b>${message.id}</b>
            <span>${message.text}</span>
            <i>${message.tag}</i>
            <strong>${message.authorName}</strong>
        </div>
    <#else>Сообщений нет
    </#list>

</@common.page>