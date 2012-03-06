{*
	variables that are available:
	- {$widgetBlogCategories}:
*}

{option:widgetBlogCategories}
	<section id="blogCategoriesWidget" class="mod">
		<header class="hd">
			<h3>{$lblCategories|ucfirst}</h3>
		</header>
		<div class="content">
			<ul>
				{iteration:widgetBlogCategories}
					<li>
						<a href="{$widgetBlogCategories.url}">
							{$widgetBlogCategories.label}&nbsp;({$widgetBlogCategories.total})
						</a>
					</li>
				{/iteration:widgetBlogCategories}
			</ul>
		</div>
	</section>
{/option:widgetBlogCategories}