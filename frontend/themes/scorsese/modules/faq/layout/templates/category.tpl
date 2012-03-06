{*
	variables that are available:
	- {$questions}: contains all questions inside this category
*}

<section id="faqCategory" class="mod">
	<h1>{$category.title}</h1>
	{option:questions}
		<section>
			<ul>
				{iteration:questions}
					<li><a href="{$questions.full_url}">{$questions.question}</a></li>
				{/iteration:questions}
			</ul>
		</section>
	{/option:questions}

	{option:!questions}
		<p>{$msgNoQuestionsInCategory|ucfirst}</p>
	{/option:!questions}

	<p><span class="bottomInfo mod">
		<a href="{$var|geturlforblock:'faq'}" title="{$lblToFaqOverview|ucfirst}">{$lblToFaqOverview|ucfirst}</a></p>
	</span></p>
</section>