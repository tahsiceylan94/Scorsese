{*
	variables that are available:
	- {$widgetBlogRecentArticlesFull}: contains an array with all posts, each element contains data about the post
*}

{option:widgetBlogRecentArticlesFull}
	<section id="blogRecentArticlesFullWidget" class="mod">
		<h3>{$lblRecentArticles|ucfirst}</h3>
		<div class="bd">
			{iteration:widgetBlogRecentArticlesFull}
				<article class="article">
					<header class="hd">
						<h4><a href="{$widgetBlogRecentArticlesFull.full_url}" title="{$widgetBlogRecentArticlesFull.title}">{$widgetBlogRecentArticlesFull.title}</a></h4>
						<p>
							<span class="topInfo">
								{$msgWrittenBy|ucfirst|sprintf:{$widgetBlogRecentArticlesFull.user_id|usersetting:'nickname'}} {$lblOn} {$widgetBlogRecentArticlesFull.publish_on|date:{$dateFormatLong}:{$LANGUAGE}}</li>
							</span>
						</p>
					</header>
					<div class="bd content">
						{option:!widgetBlogRecentArticlesFull.introduction}{$widgetBlogRecentArticlesFull.text|truncate:250}{/option:!widgetBlogRecentArticlesFull.introduction}
						{option:widgetBlogRecentArticlesFull.introduction}{$widgetBlogRecentArticlesFull.introduction|truncate:250}{/option:widgetBlogRecentArticlesFull.introduction}
					</div>
				</article>
			{/iteration:widgetBlogRecentArticlesFull}
		</div>
		<footer class="ft">
			<p>
				<a href="{$var|geturlforblock:'blog'}">{$lblBlogArchive|ucfirst}</a>
			</p>
		</footer>
	</section>
{/option:widgetBlogRecentArticlesFull}