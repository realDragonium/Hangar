<#import "/spring.ftl" as spring />
<#import "*/utils/hangar.ftlh" as hangar />
<#import "*/layout/base.ftlh" as base />
<#import "*/utils/csrf.ftlh" as csrf>


<#-- @ftlvariable name="isTargetChannelNonReviewed" type="java.lang.Boolean" -->
<#assign message><@spring.message "version.download.confirm.title" /> <@spring.messageArgs code="version.download.confirm.header" args=[project.ownerName, project.name, target.versionString] /></#assign>
<@base.base title=message>
    <div class="row">
        <div class="col-md-6 col-md-offset-3">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <div class="col-xs-12 col-sm-4 no-padding">
                        <h4 class="panel-title"><i class="fas fa-exclamation-triangle"></i>&ensp;<@spring.message "general.warning" /></h4>
                    </div>
                    <div class="col-xs-12 col-sm-8 no-padding">
                        <span class="pull-right"><@spring.messageArgs code="version.download.confirm.header" args=[project.ownerName, project.name, target.versionString] /></span>
                    </div>
                </div>
                <div class="panel-body">
                    <div class="alert alert-danger" style="margin-bottom: 10px">
                        <#assign ReviewState=@helper["io.papermc.hangar.model.generated.ReviewState"] />
                        <#-- @ftlvariable name="ReviewState" type="io.papermc.hangar.model.generated.ReviewState" -->
                    <#if isTargetChannelNonReviewed || target.reviewState == ReviewState.BACKLOG>
                        <@spring.message "version.download.confirm.nonReviewedChannel" />
                    <#elseif target.reviewState != ReviewState.PARTIALLY_REVIEWED>
                        <@spring.message "version.download.confirm.reviewedChannel" />
                    <#else>
                        <@spring.message "version.download.confirmPartial.reviewedChannel" />
                    </#if>
                    </div>
                    <p>
                        <@spring.message "general.disclaimer" />:
                        <span class="text-italic"><@spring.message "version.download.confirm.disclaimer" /></span>
                    </p>

                    <div class="row">
                        <div class="col-xs-12 col-sm-6 mb-3-sm">
                            <button class="btn btn-success link-go-back">
                            <@spring.message "project.back" />
                            </button>
                        </div>

                        <div class="col-xs-12 col-sm-6">
                            <form action="${Routes.VERSIONS_CONFIRM_DOWNLOAD.getRouteUrl(project.ownerName, project.slug, target.versionString, downloadType.ordinal() + "", "", "dummy")}" method="post" id="form-download">
                                <@csrf.formField />

                                <button type="submit" form="form-download" class="btn btn-danger pull-right-sm">
                                <@spring.message "version.download.confirm.download" />
                                </button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</@base.base>
