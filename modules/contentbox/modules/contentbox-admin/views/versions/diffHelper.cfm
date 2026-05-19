<cfscript>
	function getCodeCSS( right, left, index ) {
		var codeCSS = "";
		var leftHash = "";
		var rightHash = "";

		// if right is not defined, then it is removed content
		if ( !arrayIsDefined( left, index ) && arrayIsDefined( right, index ) ) {
			codeCSS = " ins";
		} else if ( arrayIsDefined( right, index ) && arrayIsDefined( left, index ) ) { // if both defined, then compare
			leftHash = hash(
				trim(
					reReplace(
						left[ index ],
						"\s",
						"",
						"all"
					)
				)
			);
			rightHash = hash(
				trim(
					reReplace(
						right[ index ],
						"\s",
						"",
						"all"
					)
				)
			);
			// do hashes match?
			if ( rightHash NEQ leftHash ) {
				codeCSS = " upd";
			}
		} else if ( !arrayIsDefined( right, index ) ) { // compare removals
			codeCSS = " del";
		}

		return codeCSS;
	}
</cfscript>