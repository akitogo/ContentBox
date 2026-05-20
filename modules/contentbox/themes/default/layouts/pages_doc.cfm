<cfoutput>
	<!DOCTYPE html>
<html lang="en">
<head>#cb.quickView( "_pageIncludes" )##cb.event( "cbui_beforeHeadEnd" )#</head>
<body>#cb.event( "cbui_afterBodyStart" )##cb.event( "cbui_beforeContent" )##cb.mainView( args = {
			sidebar: true,
			print: true
		} )##cb.event( "cbui_afterContent" )##cb.quickView( view = "_footer" )##cb.event( "cbui_beforeBodyEnd" )#	
</body>
</html>
</cfoutput>