{*
	variables that are available:
	- {$faqCategories}: contains all categories, along with all questions inside a category
*}

{option:!faqCategories}
	<div class="mod">
		<div class="content">
			<p>{$msgFaqNoItems}</p>
		</div>
	</div>
{/option:!faqCategories}

{option:faqCategories}
	<section id="faq" class="mod">
		<div class="content">
			<ul>
				{iteration:faqCategories}
					<li><a href="#{$faqCategories.url}" title="{$faqCategories.title}">{$faqCategories.title}</a></li>
				{/iteration:faqCategories}
			</ul>
		</div>
		{iteration:faqCategories}
			<section>
				<h3 id="{$faqCategories.url}"><a href="{$faqCategories.full_url}" title="{$faqCategories.title}">{$faqCategories.title}</a></h3>
				<div class="content">
					<ul>
						{iteration:faqCategories.questions}
							<li><a href="{$faqCategories.questions.full_url}">{$faqCategories.questions.question}</a></li>
						{/iteration:faqCategories.questions}
					</ul>
				</div>
			</section>
		{/iteration:faqCategories}
	</section>
{/option:faqCategories}