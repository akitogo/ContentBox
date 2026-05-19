<cfoutput>
	<!DOCTYPE html>
<html lang="en">
<head>#cb.quickView( "_blogIncludes" )##cb.event( "cbui_beforeHeadEnd" )#</head>
<body>#cb.event( "cbui_afterBodyStart" )#<!--- Main Body --->  <section id="body-main">
<div class="container">
	<div class="row">
		<div class="col-sm-12">#cb.event( "cbui_beforeContent" )##cb.mainView( args = {
				sidebar : true,
				print : true
			} )##cb.event( "cbui_afterContent" )#</div>
		</div>
	</div>
</section>#cb.quickView( view = "_footer" )##cb.event( "cbui_beforeBodyEnd" )#</body>
</html>
</cfoutput>