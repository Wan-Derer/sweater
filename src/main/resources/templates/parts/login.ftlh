<#macro login path isRegisterForm>
    <form action="${path}" method="post">
        <div class="form-group row mb-3">
            <label class="col-sm-2 col-form-label">Имя: </label>
            <div class="col-sm-6"><input type="text" name="username" class="form-control" placeholder="Имя участника"/>
            </div>
        </div>
        <div class="form-group row mb-3">
            <label class="col-sm-2 col-form-label">Пароль: </label>
            <div class="col-sm-6"><input type="password" name="password" class="form-control" placeholder="Пароль"/>
            </div>
        </div>

        <#if isRegisterForm>
        <div class="form-group row mb-3">
            <label class="col-sm-2 col-form-label">Почта: </label>
            <div class="col-sm-6"><input type="email" name="email" class="form-control" placeholder="fsb@fsb.ru"/>
            </div>
        </div>
        </#if>

        <input type="hidden" name="_csrf" value="${_csrf.token}"/>
        <#if !isRegisterForm><a href="/registration">Регистрация нового пользователя</a></#if>
        <button class="btn btn-primary" type="submit">
            <#if isRegisterForm>ДОБАВИТЬ
            <#else>ВОЙТИ
            </#if>
        </button>
    </form>
</#macro>

<#macro logout>
    <form action="/logout" method="post">
        <input type="hidden" name="_csrf" value="${_csrf.token}"/>
        <button class="btn btn-primary" type="submit">ВЫЙТИ</button>
    </form>
</#macro>