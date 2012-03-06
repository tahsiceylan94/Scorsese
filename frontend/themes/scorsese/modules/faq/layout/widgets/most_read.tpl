{*
	variables that are available:
	- {$widgetFaqMostRead}: contains an array with all posts, each element contains data about the post
*}

{option:widgetFaqMostRead}
	<section id="blogRecentArticlesListWidget" class="mod">
		<header class="hd">
			<h3>{$lblMostReadQuestions|ucfirst}</h3>
		</header>
		<div class="content">
			<ul>
				{iteration:widgetFaqMostRead}
					<li><a href="{$widgetFaqMostRead.full_url}" title="{$widgetFaqMostRead.question}">{$widgetFaqMostRead.question}</a></li>
				{/iteration:widgetFaqMostRead}
			</ul>
		</div>
	</section>
{/option:widgetFaqMostRead}