<cfoutput>
	<div
	id="content-editor"
	x-data="{
		focusMode : false,

		get isFocusMode(){
			return this.focusMode == true;
		},

		toggleFocusMode(){
			this.focusMode = !this.focusMode;
		}

	}"
>#cbAdminComponent( "editor/QuickActionsBar" )##html.startForm(
			action     = prc.xehContentSave,
			name       = "contentForm",
			novalidate = "novalidate",
			class      = "form-vertical mt5",
			role       = "form"
		)#<div class="row" x-data="window">  <div
	id="main-content-slot"
	x-data="{
	}"
	:class="{ 'col-md-12' : isFocusMode, 'col-md-8' : !isFocusMode }"
><!--- MessageBox Alerts --->   <div class="messages" x-data="alertsModel()" @add-alert.window="addAlert">#cbMessageBox().renderit()#<template x-for="alert in alerts">
		<div :class="`alert alert-${alert.class} text=center`" x-text="alert.message"></div>
	</template>
</div>#html.hiddenField( name = "siteID", bind = prc.oContent )##html.hiddenField( name = "contentID",
			bind = prc.oContent )##html.hiddenField( name = "contentType",
			bind = prc.oContent )##html.hiddenField( name = "isPublished",
			bind = prc.oContent )##html.hiddenField( name = "saveAsTemplate",
			value = "false" )##html.hiddenField( name = "sluggerURL", value = event.buildLink( prc.xehSlugify ) )#<div
class="panel p10"
:class="{ 'border-solid border-2' : isFocusMode }"
>

<div class="tabs">
	<!-- Nav Tabs -->
	<ul
		class="nav nav-tabs"
		role="tablist"
		id="tablist"
		x-show="!isFocusMode"
	><!--- Main Editor --->   <li role="presentation" class="nav-item active">
<a href="##editor" aria-controls="editor" role="tab" data-toggle="tab" class="nav-link">
	<i class="fas fa-pen"></i> #prc.oContent.getContentType()#</a>
</li>

	<cfif prc.oCurrentAuthor.hasPermission( "EDITORS_CUSTOM_FIELDS" )>
		<li role="presentation" class="nav-item">
	<a href="##custom_fields" aria-controls="custom_fields" role="tab" data-toggle="tab" class="nav-link">
		<i class="fa fa-microchip"></i> Custom Fields
	</a>
</li>
	</cfif>
	<cfif !prc.oContent.isContentStore() && prc.oCurrentAuthor.hasPermission( "EDITORS_HTML_ATTRIBUTES" )>
		<li role="presentation" class="nav-item">
	<a href="##seo" aria-controls="seo" role="tab" data-toggle="tab" class="nav-link">
		<i class="fa fa-cloud"></i> SEO
	</a>
</li>
	</cfif>
	<cfif prc.oContent.isLoaded()>
		<li role="presentation" class="nav-item">
	<a href="##history" aria-controls="history" role="tab" data-toggle="tab" class="nav-link">
		<i class="fa fa-history"></i> History
	</a>
</li>
		<cfif prc.oContent.commentsAllowed()>
			<li role="presentation" class="nav-item">
	<a href="##comments" aria-controls="comments" role="tab" data-toggle="tab" class="nav-link">
		<i class="fa fa-comments"></i> Comments
	</a>
</li>
		</cfif>
	</cfif>
	#announce( "cbadmin_ContentEditorNav" )#
						</ul>

						<!--- Nav Content --->   
						<div
							class="tab-content"
							id="tab-content"
						>

							<!--- Editor Tab --->   
							<div
								role="tabpanel"
								class="tab-pane active"
								id="editor"
							>
								<div
									id="editorMeta"
									x-show="!isFocusMode"
								>
									<!--- title --->   
									<div class="form-group">
										<label class="control-label" for="title">Title:</label>
										<div class="controls">
											#html.textfield(
			name      = "title",
			bind      = prc.oContent,
			maxlength = "500",
			required  = "required",
			title     = "The title for this content",
			class     = "form-control"
		)#
										</div>
									</div>

									<!--- slug --->   
									<div class="form-group">

										<label for="slug" class="control-label">
											Slug:
											<i class="fa fa-cloud" title="Convert title to slug" onclick="createPermalink()"></i>



	<cfif !prc.oContent.isContentStore()>
		<small> #prc.CBHelper.siteRoot()#/</small>
	</cfif>
	<cfif prc.oContent.hasParent()>
		<small>#prc
			.oContent
			.getParent()
			.getSlug()#/</small>
	</cfif>
	
	
	
										</label>

										<div class="controls">
											<div id='slugCheckErrors'></div>
											<div class="input-group">
												#html.textfield(
			name      = "slug",
			bind      = prc.oContent,
			maxlength = "1000",
			class     = "form-control",
			title     = "The unique slug for this content",
			disabled  = "#prc.oContent.isLoaded() && prc.oContent.getIsPublished() ? "true" : "false"#"
		)#
												<a title=""
													class="input-group-addon"
													href="javascript:void(0)"
													onclick="togglePermalink(); return false;"
													data-original-title="Lock/Unlock Slug"
													data-container="body"
												>
													<i
														id="togglePermalink"
														class="fa fa-#prc.oContent.isLoaded() && prc.oContent.getIsPublished() ? "lock" : "unlock"#"
													></i>
												</a>
											</div>
										</div>
									</div>




	<cfif structKeyExists( prc.oContent, "getDescription" )>
		<div class="form-group">
<label class="control-label" for="description">Short Description:</label>
<div class="controls">#html.textarea(
				name  = "description",
				bind  = prc.oContent,
				rows  = 1,
				class = "form-control",
				title = "A short description for metadata purposes"
			)#</div>
</div>
	</cfif>
	
	
	
								</div>

								#cbAdminComponent( "editor/ContentToolBar" )#<!--- CONTENT EDITOR --->   
								<div class="form-group">
									<div class="controls">
										#html.textarea(
			name  = "content",
			value = htmlEditFormat( prc.oContent.getContent() ),
			rows  = "25",
			class = "form-control"
		)#
									</div>
								</div>




	<cfif structKeyExists( prc.oContent, "getExcerpt" )>
		<div class="form-group">
<label class="control-label" for="description">Excerpt:</label>
<div class="controls">#html.textarea(
				name  = "excerpt",
				value = htmlEditFormat( prc.oContent.getExcerpt() ),
				rows  = "10",
				class = "form-control"
			)#</div>
</div>
	</cfif>
	
	
	
							</div>

							<!--- Custom Fields Tab --->   
							<div
								role="tabpanel"
								class="tab-pane"
								id="custom_fields"
							>
								#cbAdminComponent(
		"editor/CustomFields",
		{
			fieldType    : "content",
			customFields : prc.oContent.getCustomFields()
		}
	)#
							</div>

							<!--- SEO --->   
							<div
								role="tabpanel"
								class="tab-pane"
								id="seo"
							>
								#cbAdminComponent( "editor/SEOPanel" )#
							</div>




	<cfif prc.oContent.isLoaded()>
		<!--- Version History Tab --->   <div
	role="tabpanel"
	class="tab-pane"
	id="history"
>#prc.versionsViewlet#</div>
		<cfif prc.oContent.commentsAllowed()>
			<div
	role="tabpanel"
	class="tab-pane"
	id="comments"
>#prc.commentsViewlet#</div>
		</cfif>
	</cfif>
	#announce( "cbadmin_contentEditorNavContent" )#

						</div>
					</div>

					#announce( "cbadmin_contentEditorInBody" )#
				</div>

				#announce( "cbadmin_contentEditorFooter" )#
			</div>

			<!--- Content SideBar --->   
			<div
				id="main-content-sidebar"
				x-show="!isFocusMode"
				x-data="{

				}"
				class="col-md-4"
			>
				<div class="panel panel-primary">
					<div class="panel-heading">
						<h3 class="panel-title"><i class="fa fa-info-circle"></i> #prc.oContent.getContentType()# Details</h3>
					</div>
					<div class="panel-body">
						#cbAdminComponent( "editor/sidebar/PublishingPanel" )#<!--- Accordion --->   
						<div id="accordion" class="panel-group accordion" data-stateful="content-sidebar">




	<cfif prc.oContent.isLoaded()>
		#cbAdminComponent( "editor/sidebar/InfoTable" )#
	</cfif>
	<cfif prc.oContent.getContentType() EQ "page">
		#cbAdminComponent( "editor/sidebar/DisplayOptions" )#
	</cfif>
	#cbAdminComponent( "editor/sidebar/RelatedContent" )##cbAdminComponent( "editor/sidebar/LinkedContent" )##cbAdminComponent( "editor/sidebar/Modifiers" )##cbAdminComponent( "editor/sidebar/CacheSettings" )##cbAdminComponent( "editor/sidebar/Categories" )#
	<cfif !prc.oContent.isContentStore()>
		#cbAdminComponent( "editor/sidebar/FeaturedImage" )#
	</cfif>
	#announce( "cbadmin_contentEditorSidebarAccordion" )#
						</div>
						#announce( "cbadmin_contentEditorSidebar" )#
					</div>
				</div>
				#announce( "cbadmin_contentEditorSidebarFooter" )#
			</div>
		</div>

	#html.endForm()#
</div>



</cfoutput>
