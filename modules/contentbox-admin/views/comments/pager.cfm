﻿<cfoutput>
<div id="pagerComments">
<!--- Loader --->
<div class="loaders floatRight" id="commentsPagerLoader">
	<i class="icon-spinner icon-spin icon-large icon-2x"></i>
</div>
<!--- Paging --->
<cfif prc.commentPager_pagination>
	#prc.commentPager_pagingPlugin.renderit(prc.commentPager_commentsCount,prc.commentPager_pagingLink)#
</cfif>
#html.startForm(name="commentPagerForm")#
<!--- comments --->
<table name="comments_pager" id="comments_pager" class="tablesorter table table-hover table-condensed table-striped" width="100%">
	<thead>
		<tr>
			<th width="200">Author</th>
			<th>Comment</th>
			<th width="135" class="center">Date</th>			
			<th width="90" class="center">Actions</th>
		</tr>
	</thead>
	
	<tbody>
		<cfloop array="#prc.commentPager_comments#" index="comment">
		<tr <cfif !comment.getIsApproved()>class="error"</cfif> data-commentID="#comment.getCommentID()#">
			<td>
				#getMyPlugin(plugin="Avatar",module="contentbox").renderAvatar(email=comment.getAuthorEmail(),size="30")#
				&nbsp;<a href="mailto:#comment.getAUthorEmail()#" title="#comment.getAUthorEmail()#">#comment.getAuthor()#</a>
				<br/>
				<cfif len(comment.getAuthorURL())>
					<i class="icon-cloud"></i> 
					<a href="<cfif NOT findnocase("http",comment.getAuthorURL())>http://</cfif>#comment.getAuthorURL()#" target="_blank">
						#left(comment.getAuthorURL(),25)#<cfif len(comment.getAuthorURL()) gt 25>...</cfif>
					</a>
					<br />
				</cfif>
				<i class="icon-laptop"></i> 
				<a href="#prc.cbSettings.cb_comments_whoisURL#=#comment.getAuthorIP()#" title="Get IP Information" target="_blank">#comment.getauthorIP()#</a>
			</td>
			<td>
				<strong>#comment.getParentTitle()#</strong> 
				<br/>
				#left(comment.getContent(),prc.cbSettings.cb_comments_maxDisplayChars)#
				<cfif len(comment.getContent()) gt prc.cbSettings.cb_comments_maxDisplayChars>....<strong>more</strong></cfif>
			</td>
			<td class="center">
				#comment.getDisplayCreatedDate()#
			</td>
			<td class="center">
				<cfif prc.oAuthor.checkPermission("COMMENTS_ADMIN")>
					<!--- Approve/Unapprove --->
					<cfif !comment.getIsApproved()>
						<a href="javascript:commentPagerChangeStatus('approve','#comment.getCommentID()#')" title="Approve Comment"><i id="status_#comment.getCommentID()#" class="icon-thumbs-up icon-large" ></i></a>
					<cfelse>
						<a href="javascript:commentPagerChangeStatus('moderate','#comment.getCommentID()#')" title="Unapprove Comment"><i id="status_#comment.getCommentID()#" class="icon-thumbs-down icon-large"></i></a>
					</cfif>
					&nbsp;	
					<!--- Delete Command --->
					<a title="Delete Comment Permanently" href="javascript:commentPagerRemove('#comment.getCommentID()#')"><i id="delete_#comment.getCommentID()#" class="icon-trash icon-large" ></i></a>
					&nbsp;
				</cfif>
				<!--- View in Site --->
				<a href="#prc.CBHelper.linkComment(comment)#" title="View Comment In Site" target="_blank"><i class="icon-eye-open icon-large"></i></a>
			</td>
		</tr>
		</cfloop>
	</tbody>
</table>
#html.endForm()#
</div>
</cfoutput>