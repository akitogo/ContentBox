<cfparam name="args.sidebar" default="true">
<cfoutput>
	<!DOCTYPE html>
<html lang="en">
<head>#cb.quickView( "_pageIncludes" )##cb.event( "cbui_beforeHeadEnd" )#</head>
<body>#cb.event( "cbui_afterBodyStart" )##cb.quickView( view = "_header" )##cb.event( "cbui_beforeContent" )##cb.mainView( args = args )##cb.event( "cbui_afterContent" )##cb.quickView( view = "_footer" )##cb.event( "cbui_beforeBodyEnd" )#	
</body>
</html>
</cfoutput>