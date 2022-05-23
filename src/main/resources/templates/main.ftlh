<#import "parts/common.ftlh" as common>

<@common.page>
    <div class="form-row mb-3">
        <div class="form-group col-md-6">
            <form method="get" action="/main" class="form-inline">
                <label>Фильтр:
                    <input type="text" name="filter" class="form-control" placeholder="фильтр по тэгу"
                           value="${filter!}">
                </label>
                <button type="submit" class="btn btn-primary ms-2">НАЙТИ</button>
            </form>
        </div>
    </div>

    <a class="btn btn-primary mb-3" data-bs-toggle="collapse" href="#collapseExample" role="button"
       aria-expanded="false" aria-controls="collapseExample">
        Новое сообщение
    </a>
    <div class="collapse <#if message??>show</#if> mb-3" id="collapseExample">
        <div class="form-group mb-3">
            <form method="post" enctype="multipart/form-data">
                <div class="form-group mb-3">
                    <input type="text" class="form-control ${(textError??)?string('is-invalid', '')}"
                           value="<#if message??>${message.text}</#if>" name="text" placeholder="Введи сообщение"/>
                    <#if textError??>
                        <div class="invalid-feedback">
                            ${textError}
                        </div>
                    </#if>
                </div>
                <div class="form-group mb-3">
                    <input type="text" class="form-control"
                           value="<#if message??>${message.tag}</#if>" name="tag" placeholder="Тэг"/>
                </div>
                <#if tagError??>
                    <div class="invalid-feedback">
                        ${tagError}
                    </div>
                </#if>
                <div class="form-group mb-3">
                    <div class="custom-file">
                        <input type="file" name="file" id="customFile">
                        <#--                    <label class="custom-file-label" for="customFile">Выберите файл</label>-->
                    </div>
                </div>
                <input type="hidden" name="_csrf" value="${_csrf.token}"/>
                <button class="btn btn-primary" type="submit">ДОБАВИТЬ</button>
            </form>
        </div>
    </div>

    <div><h3>Сообщения</h3></div>

    <div class="row row-cols-1 row-cols-md-3 g-4">
        <#list messages as message>
            <div class="col">
                <div class="card">
                    <#if message.filename??>
                        <img class="card-img-top" src="/img/${message.filename}">
                    </#if>
                    <div class="m-2">
                        <span>${message.text}</span>
                        <i>${message.tag}</i>
                    </div>
                    <div class="card-footer text-muted">
                        ${message.authorName}
                    </div>
                </div>
            </div>
        <#else>Сообщений нет
        </#list>
    </div>

</@common.page>