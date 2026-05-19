<cfscript>
	function getCodeCSS( right, left, index ) {
		var codeCSS = "";
		var leftHash = "";
		var rightHash = "";

		// if right is not defined, then it is removed content
		if ( !arrayIsDefined( left, index ) && arrayIsDefined( right, index ) ) {
			codeCSS = " ins";
		} else // if both defined, then compare
		if ( arrayIsDefined( right, index ) && arrayIsDefined( left, index ) ) {
			leftHash = hash( trim( reReplace(
						left[ index ],
						"\s",
						"",
						"all"
					) ) );
			rightHash = hash( trim( reReplace(
						right[ index ],
						"\s",
						"",
						"all"
					) ) );
			// do hashes match?
			if ( rightHash NEQ leftHash ) {
				codeCSS = " upd";
			}
		} else // compare removals
		if ( !arrayIsDefined( right, index ) ) {
			codeCSS = " del";
		}

		return codeCSS;
	}
</cfscript>