<cfoutput>
	<cfparam name="args.print" default="false">
	<cfparam name="args.sidebar" default="true">
	<!DOCTYPE html>
<html lang="en">
<head>#cb.quickView( "_blogIncludes" )##cb.event( "cbui_beforeHeadEnd" )#</head>
<body>#cb.event( "cbui_afterBodyStart" )##cb.quickView( "_header" )##cb.event( "cbui_beforeContent" )##cb.mainView( args = args )##cb.event( "cbui_afterContent" )##cb.quickView( view = "_footer" )##cb.event( "cbui_beforeBodyEnd" )#</body>
</html>
</cfoutput>