<cfoutput>
	#html.anchor( name = "recentComments" )#
	<cfif !prc.cbSiteSettings.cb_comments_enabled>
		<div class="alert alert-danger">
<i class="fa fa-exclamation-triangle fa-2x pull-left"></i>#$r( "dashboard.latestComments.alert@admin" )#</div>
	</cfif>
	#prc.commentsViewlet#
</cfoutput>