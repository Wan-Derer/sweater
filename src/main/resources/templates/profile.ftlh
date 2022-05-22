<#import "parts/common.ftlh" as common>

<@common.page>
    <h3>Учётная запись ${username}</h3>
    ${message!}

    <form method="post">
        <div class="form-group row mb-3">
            <label class="col-sm-1 col-form-label">Пароль: </label>
            <div class="col-sm-6"><input type="password" name="password" class="form-control" placeholder="Пароль"/>
            </div>
        </div>

        <div class="form-group row mb-3">
            <label class="col-sm-1 col-form-label">Почта: </label>
            <div class="col-sm-6"><input type="email" name="email" class="form-control"
                                         placeholder="fsb@fsb.ru" value="${email!''}"/>
            </div>
        </div>

        <input type="hidden" name="_csrf" value="${_csrf.token}"/>

        <button class="btn btn-primary mb-3" type="submit">СОХРАНИТЬ</button>

    </form>

</@common.page>
