/**
* A setup representation object
*/
component accessors="true" {

	// Properties
	property name="firstName";
	property name="fullrewrite";
	
	// Constructor
	function init(){
		setSiteKeywords('');
		setSiteDescription('');
		setFullRewrite(true);
		return this;
	}
	
	function getUserData(){
		var results = {
			firstname = firstname,
			lastName = lastName,
			email = email,
			username = username,
			password = password
		};
		return results;
	}
	
}