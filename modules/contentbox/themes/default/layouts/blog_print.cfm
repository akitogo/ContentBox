<cfoutput>
	<!DOCTYPE html>
<html lang="en">
<head>#cb.quickView( "_blogIncludes" )##cb.event( "cbui_beforeHeadEnd" )#</head>
<body>#cb.event( "cbui_afterBodyStart" )#<!--- Main Body --->    <section id="body-main">
<div class="container">#cb.event( "cbui_beforeContent" )##cb.mainView( args = {
				sidebar : false,
				print : true
			} )##cb.event( "cbui_afterContent" )#</div>
</section>#cb.quickView( view = "_footer" )##cb.event( "cbui_beforeBodyEnd" )#</body>
</html>
</cfoutput>