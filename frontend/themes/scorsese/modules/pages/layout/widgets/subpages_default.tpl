{option:widgetSubpages}
	<div id="subpagesBlocks" class="mod">
		{iteration:widgetSubpages}
			<div class="subpagesBlock">
				<h3><a href="{$widgetSubpages.full_url}" title="{$widgetSubpages.title}">{$widgetSubpages.title}</a></h3>
				{$widgetSubpages.description}
			</div>
		{/iteration:widgetSubpages}
	</div>
{/option:widgetSubpages}