<cfoutput>
	#cb.event( "cbui_prePageDisplay" )#<section id="body-main"><!--- search Results --->  <div class="container">
<h2>Search Results</h2>#cb.getSearchResultsContent()##cb.quickSearchPaging()#</div>

</section>#cb.event( "cbui_postPageDisplay" )#
</cfoutput>