<#macro login path isRegisterForm>
    <form action="${path}" method="post">
        <div class="form-group row mb-3">
            <label class="col-sm-2 col-form-label">Имя: </label>
            <div class="col-sm-6">
                <input type="text" name="username" value="<#if user??>${user.username}</#if>"
                       class="form-control ${(usernameError??)?string('is-invalid', '')}"
                       placeholder="Имя участника"/>
                <#if usernameError??><div class="invalid-feedback">${usernameError}</div> </#if>
            </div>
        </div>
        <div class="form-group row mb-3">
            <label class="col-sm-2 col-form-label">Пароль: </label>
            <div class="col-sm-6">
                <input type="password" name="password"
                       class="form-control ${(passwordError??)?string('is-invalid', '')}"
                       placeholder="Пароль"/>
                <#if passwordError??><div class="invalid-feedback">${passwordError}</div> </#if>
            </div>
        </div>

        <#if isRegisterForm>
            <div class="form-group row mb-3">
                <label class="col-sm-2 col-form-label">Пароль ещё раз: </label>
                <div class="col-sm-6">
                    <input type="password" name="password2"
                           class="form-control ${(password2Error??)?string('is-invalid', '')}"
                           placeholder="Пароль ещё раз"/>
                    <#if password2Error??><div class="invalid-feedback">${password2Error}</div> </#if>
                </div>
            </div>

            <div class="form-group row mb-3">
                <label class="col-sm-2 col-form-label">Почта: </label>
                <div class="col-sm-6">
                    <input type="email" name="email" value="<#if user??>${user.email}</#if>"
                           class="form-control ${(emailError??)?string('is-invalid', '')}"
                           placeholder="fsb@fsb.ru"/>
                    <#if emailError??><div class="invalid-feedback">${emailError}</div> </#if>
                </div>
            </div>
        </#if>

        <input type="hidden" name="_csrf" value="${_csrf.token}"/>

        <button class="btn btn-primary mb-3" type="submit">
            <#if isRegisterForm>ДОБАВИТЬ
            <#else>ВОЙТИ
            </#if>
        </button>

        <#if !isRegisterForm>
            <div><a href="/registration">Регистрация нового пользователя</a></div></#if>

    </form>
</#macro>

<#macro logout>
    <form action="/logout" method="post">
        <input type="hidden" name="_csrf" value="${_csrf.token}"/>
        <button class="btn btn-primary" type="submit">ВЫЙТИ</button>
    </form>
</#macro>