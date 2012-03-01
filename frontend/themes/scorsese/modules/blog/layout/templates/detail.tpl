{*
	variables that are available:
	- {$item}: contains data about the post
	- {$comments}: contains an array with the comments for the post, each element contains data about the comment.
	- {$commentsCount}: contains a variable with the number of comments for this blog post.
	- {$navigation}: contains an array with data for previous and next post
*}
<div id="blogIndex">
	<article class="article" itemscope itemtype="http://schema.org/Blog">
			<meta itemprop="interactionCount" content="UserComments:{$commentsCount}">
			<meta itemprop="author" content="{$item.user_id|usersetting:'nickname'}">
			<h1 itemprop="name">{$item.title}</h1>
			<p><span class="topInfo">{$item.publish_on|date:{$dateFormatLong}:{$LANGUAGE}} - 
					{option:!item.comments}<a href="{$item.full_url}#{$actComment}">{$msgBlogNoComments|ucfirst}</a>{/option:!item.comments}
					{option:item.comments}
						{option:item.comments_multiple}<a href="{$item.full_url}#{$actComments}">{$msgBlogNumberOfComments|sprintf:{$item.comments_count}}</a>{/option:item.comments_multiple}
						{option:!item.comments_multiple}<a href="{$item.full_url}#{$actComments}">{$msgBlogOneComment}</a>{/option:!item.comments_multiple}
					{/option:item.comments}
				</span></p>
			<div class="bd content" itemprop="articleBody">
				{option:item.image}<img src="{$FRONTEND_FILES_URL}/blog/images/source/{$item.image}" alt="{$item.title}" itemprop="image" />{/option:item.image}
				{$item.text}
			</div>
			<p><span class="bottomInfo">{$msgWrittenBy|ucfirst|sprintf:{$item.user_id|usersetting:'nickname'}}
				{$lblIn} {$lblThe} {$lblCategory} <a href="{$item.category_full_url}" title="{$item.category_title}">{$item.category_title}</a>{option:!item.tags}.{/option:!item.tags}
				{option:item.tags}
					{$lblTags}: 
					{iteration:item.tags}
						<a href="{$item.tags.full_url}" rel="tag" title="{$item.tags.name}">{$item.tags.name}</a>{option:!item.tags.last}, {/option:!item.tags.last}{option:item.tags.last}.{/option:item.tags.last}
					{/iteration:item.tags}
				{/option:item.tags}
			</span></p>
	</article>

	{option:comments}
		<section id="blogComments" itemscope itemtype="http://schema.org/Article">
			<h3 id="{$actComments}">{$lblComments|ucfirst}</h3>
			<div class="bd content">
				{iteration:comments}
					{* Do not alter the id! It is used as an anchor *}
					<div id="comment-{$comments.id}" class="comment" itemprop="comment" itemscope itemtype="http://schema.org/UserComments">
						<meta itemprop="discusses" content="{$item.title}" />
						<div class="imageHolder">
							{option:comments.website}<a href="{$comments.website}">{/option:comments.website}
								<img src="{$FRONTEND_CORE_URL}/layout/images/default_author_avatar.gif" width="48" height="48" alt="{$comments.author}" class="replaceWithGravatar" data-gravatar-id="{$comments.gravatar_id}" />
							{option:comments.website}</a>{/option:comments.website}
						</div>
						<div class="commentContent">
							<p class="commentAuthor" itemscope itemtype="http://schema.org/Person">
								<span class="topInfo">
									{option:comments.website}<a href="{$comments.website}" itemprop="url">{/option:comments.website}
										<span itemprop="creator name">{$comments.author}</span>
									{option:comments.website}</a>{/option:comments.website}
									{$lblWrote}
									<time itemprop="commentTime" datetime="{$comments.created_on|date:'Y-m-d\TH:i:s'}">{$comments.created_on|timeago}</time>
								</span>
							</p>
							<div class="commentText content" itemprop="commentText">
								{$comments.text|cleanupplaintext}
							</div>
						</div>
					</div>
				{/iteration:comments}
			</div>
		</section>
	{/option:comments}
	{option:item.allow_comments}
		<section id="blogCommentForm">
			<h3 id="{$actComment}">{$msgComment|ucfirst}</h3>
			<div class="bd">
				{option:commentIsInModeration}<div class="message warning"><p>{$msgBlogCommentInModeration}</p></div>{/option:commentIsInModeration}
				{option:commentIsSpam}<div class="message error"><p>{$msgBlogCommentIsSpam}</p></div>{/option:commentIsSpam}
				{option:commentIsAdded}<div class="message success"><p>{$msgBlogCommentIsAdded}</p></div>{/option:commentIsAdded}
				{form:commentsForm}
					<div class="alignBlocks">
						<p {option:txtAuthorError}class="errorArea"{/option:txtAuthorError}>
							<label for="author">{$lblName|ucfirst}<abbr title="{$lblRequiredField}">*</abbr></label>
							{$txtAuthor} {$txtAuthorError}
						</p>
						<p {option:txtEmailError}class="errorArea"{/option:txtEmailError}>
							<label for="email">{$lblEmail|ucfirst}<abbr title="{$lblRequiredField}">*</abbr></label>
							{$txtEmail} {$txtEmailError}
						</p>
					</div>
					<p class="bigInput{option:txtWebsiteError} errorArea{/option:txtWebsiteError}">
						<label for="website">{$lblWebsite|ucfirst}</label>
						{$txtWebsite} {$txtWebsiteError}
					</p>
					<p class="bigInput{option:txtMessageError} errorArea{/option:txtMessageError}">
						<label for="message">{$lblMessage|ucfirst}<abbr title="{$lblRequiredField}">*</abbr></label>
						{$txtMessage} {$txtMessageError}
					</p>
					<p>
						<input class="inputSubmit" type="submit" name="comment" value="{$msgComment|ucfirst}" />
					</p>
				{/form:commentsForm}
			</div>
		</section>
	{/option:item.allow_comments}
</div>