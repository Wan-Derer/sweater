<#include "security.ftlh">
<#import "login.ftlh" as login>


<nav class="navbar navbar-expand-lg bg-light">
    <div class="container-fluid">
        <a class="navbar-brand" href="/">Sweater</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent"
                aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                <li class="nav-item">
                    <a class="nav-link active" aria-current="page" href="/">В начало</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link active" aria-current="page" href="/main">Сообщения</a>
                </li>
                <#if isAdmin>
                    <li class="nav-item">
                        <a class="nav-link active" aria-current="page" href="/user">Участники</a>
                    </li>
                </#if>
                <#if user??>
                    <li class="nav-item">
                        <a class="nav-link active" aria-current="page" href="/user/profile">Учётная запись</a>
                    </li>
                </#if>
            </ul>

            <div class="navbar-text me-3">${name}</div>
            <#if name != ""><@login.logout/></#if>
        </div>
    </div>

</nav>


