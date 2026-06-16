/**
 * ContentBox - A Modular Content Platform
 * Copyright since 2012 by Ortus Solutions, Corp
 * www.ortussolutions.com/products/contentbox
 * ---
 */
component extends="tests.resources.BaseTest" {

	/*********************************** LIFE CYCLE Methods ***********************************/

	// executes before all suites+specs in the run() method
	function beforeAll() {
		super.beforeAll();
	}

	// executes after all suites+specs in the run() method
	function afterAll() {
		super.afterAll();
	}

	/*********************************** BDD SUITES ***********************************/

	function run( testResults, testBox ) {
		describe(
			"Base Content",
			() => {
				beforeEach(
					( currentSpec ) => {
						model = getInstance( "BaseContent@contentbox" );
					}
				);

				it(
					"can add expired data time combinations",
					() => {
						// Test 1: empty
						model.setExpireDate( "" );
						model.addExpiredTime( "11", "00" );
						expect( model.getExpireDate() ).toBe( "" );

						// Test 2: Valid
						var cDate = dateFormat( now(), "mm/dd/yyyy" );
						model.setExpireDate( cDate );
						model.addExpiredTime( "11", "00" );
						expect( model.getExpireDate() ).toBe( cDate & " " & timeFormat( "11:00", "hh:MM tt" ) );
					}
				);

				it(
					"can add published date time combinations",
					() => {
						// Test 1: empty
						model.setPublishedDate( "" );
						model.addPublishedTime( "11", "00" );
						expect( model.getPublishedDate() ).toBe( "" );

						// Test 2: Valid
						var cDate = dateFormat( now(), "mm/dd/yyyy" );
						model.setPublishedDate( cDate );
						model.addPublishedTime( "11", "00" );
						expect( model.getPublishedDate() ).toBe( cDate & " " & timeFormat( "11:00", "hh:MM tt" ) );
					}
				);

				describe(
					"contentVersions defensive initialization and normalization",
					() => {
						var mockVersion = "";
						var mockAuthor  = "";

						beforeEach(
							( currentSpec ) => {
								// Stub content version: accepts setter calls without return-value checks
								mockVersion = createStub()
									.$( "setIsActive" )
									.$( "setVersion" );
								mockAuthor = createStub();

								// Prepare the model so we can inject mock dependencies
								model = prepareMock( getInstance( "BaseContent@contentbox" ) );
								model.$property(
										"contentVersionService",
										"variables",
										createStub().$( "new", mockVersion )
									);
								// Stub the ORM-generated helper to prevent any database access
								model.$( "addContentVersion" );
								model.setSlug( "test-defensive-guard" );
							}
						);

						it(
							"initializes contentVersions to an empty array when it has not been set before calling addNewContentVersion",
							() => {
								// variables.contentVersions is intentionally absent; the `param` inside
								// addNewContentVersion() should initialize it to [] without error
								model.addNewContentVersion( content = "Hello World", author = mockAuthor );
								expect( model.getActiveContent() ).toBe( mockVersion );
							}
						);

						it(
							"resets contentVersions to an empty array when it contains a simple value before calling addNewContentVersion",
							() => {
								// Simulate a BoxLang ORM edge case where the relationship is populated
								// with a simple value instead of an array
								model.$property( "contentVersions", "variables", "unexpected-simple-value" );
								model.addNewContentVersion( content = "Hello World", author = mockAuthor );
								expect( model.getActiveContent() ).toBe( mockVersion );
							}
						);

						it(
							"filters out simple values from a mixed array when setting content versions",
							() => {
								var realVersion = createStub();
								// Prevent ORM lazy-load; the collection is empty for a new entity
								model.$( "hasContentVersion", false );
								// Pass a mix of a real object and simple values (BoxLang ORM edge case)
								model.setContentVersions( [ realVersion, "simple-string-value", 42 ] );
								var versions = model.getContentVersions();
								expect( versions ).toHaveLength( 1 );
								expect( versions[ 1 ] ).toBe( realVersion );
							}
						);
					}
				);
			}
		);
	}

}