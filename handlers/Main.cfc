component {
	// Default Action function index( event, rc, prc ) {
	prc.welcomeMessage = "Welcome to ContentBox Modular CMS!";
	event.setView( "main/index" );

}
/************************************** IMPLICIT ACTIONS *********************************************/
// Grab Exception From request collection, placed by ColdBox var exceptionBean = event.getValue( "ExceptionBean" );
// Place exception handler below:
// Grab missingTemplate From request collection, placed by ColdBox var missingTemplate = event.getValue( "missingTemplate" );