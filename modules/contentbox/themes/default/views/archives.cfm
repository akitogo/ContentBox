<cfoutput>
	<cfset bodyHeaderStyle = "">
	<cfset bodyHeaderH1Style = "">
	<cfif cb.themeSetting( "overrideHeaderColors" )>
		<cfif len( cb.themeSetting( "overrideHeaderBGColor" ) )>
			<cfset bodyHeaderStyle = bodyHeaderStyle & "background-color: " & cb.themeSetting( "overrideHeaderBGColor" ) & ";">
		</cfif>
		<cfif len( cb.themeSetting( "overrideHeaderTextColor" ) )>
			<cfset bodyHeaderH1Style = bodyHeaderH1Style & "color: " & cb.themeSetting( "overrideHeaderTextColor" ) & ";">
		</cfif>
	</cfif>
	
			
<div id="body-header" style="#bodyHeaderStyle#">
	<div class="container">
		<!--- Title --->  
		<div class="underlined-title">
			<h1 style="#bodyHeaderH1Style#">Blog</h1>
		</div>
	</div>
</div>

<!--- Body Main --->  
<section id="body-main">
	<div class="container">	
		<div class="row">
			<!--- Content --->  
			<div class="col-sm-9">

				#cb.event( "cbui_preArchivesDisplay" )#<!--- Title --->  
				<h1>Blog Archives - #prc.entriesCount# Record(s)</h1>



	<cfif rc.year NEQ 0>
		<div class="alert alert-info">
<a class="pull-right btn btn-primary btn-sm" href="#cb.linkBlog()#" title="Remove filter and view all entries">Remove Filter</a>
						
Year: '#rc.year#'
		<cfif rc.month NEQ 0>
			- Month: '#rc.month#'
		</cfif>
		<cfif rc.day NEQ 0>
			- Day: '#rc.day#'
		</cfif>
		
		
					</div>
					<br/>


	</cfif>
	#cb.quickEntries()#
	<cfif prc.entriesCount>
		<div class="contentBar">#cb.quickPaging()#</div>
	</cfif>
	#cb.event( "cbui_postArchivesDisplay" )#
			</div>



	<cfif args.sidebar>
		<div class="col-sm-3" id="blog-sidenav">#cb.quickView( view = "_blogsidebar", args = args )#</div>
	</cfif>
	
	

</div>
	</div>
</section>		


</cfoutput>
