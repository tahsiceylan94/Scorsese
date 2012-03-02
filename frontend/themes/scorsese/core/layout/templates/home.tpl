{include:core/layout/templates/head.tpl}

<body class="{$LANGUAGE}" itemscope itemtype="http://schema.org/WebPage">
	<div id="container">
		<header id="header">
			<div class="logoNavWrapper">
				<div class="innerdiv nav">

					{* Logo *}
					<div id="logo">
						<h1><a href="/">{$siteTitle}</a></h1>
					</div>

					{* Navigation *}
					<nav id="navigation" class="clearfix">
						{$var|getnavigation:'page':0:1}
					</nav>

				</div>
			</div>
			<div class="innerdiv headOption">
				<div id="headerOptions" class="clearfix">

					{* Search position *}
					{iteration:positionSearch}
						{$positionSearch.blockContent}
					{/iteration:positionSearch}

					{* Language *}
					<nav id="language">
						{include:core/layout/templates/languages.tpl}
					</nav>
				</div>
			</div>

		</header>

		<div id="mainWrapper" class="clearfix">
			<div id="eyeCatcher" class="clearfix">
				<div class="innerdiv">

					{* TopLeft Position *}
					<div id="eyeImg" class="clearfix">
						{iteration:positionTopleft}
							{$positionTopleft.blockContent}
						{/iteration:positionTopleft}
					</div>
					{* TopRight Position *}
					<div id="eyeContent" >
						{iteration:positionTopright}
							{$positionTopright.blockContent}
						{/iteration:positionTopright}
					</div>
				</div>
			</div>

			<div class="innerdiv clearfix">
				<div id="main">
					{* Main position *}
					{iteration:positionMain}
						{option:positionMain.blockIsHTML}
							<div id="blogIndex">
								<div class="bd content">
									{$positionMain.blockContent}
								</div>
							</div>
						{/option:positionMain.blockIsHTML}
						{option:!positionMain.blockIsHTML}
							{$positionMain.blockContent}
						{/option:!positionMain.blockIsHTML}
					{/iteration:positionMain}
				</div>

				<div class="side right">
					{* Right position *}
					{iteration:positionRight}
						{option:positionRight.blockIsHTML}
							<section class="mod">
								<div class="bd content">
									{$positionRight.blockContent}
								</div>
							</section>
						{/option:positionRight.blockIsHTML}
						{option:!positionRight.blockIsHTML}
							{$positionRight.blockContent}
						{/option:!positionRight.blockIsHTML}
					{/iteration:positionRight}
				</div>

				<div class="side left">
					{* Left position *}
					{iteration:positionLeft}
						{option:positionLeft.blockIsHTML}
							<section class="mod">
								<div class="bd content">
									{$positionLeft.blockContent}
								</div>
							</section>
						{/option:positionLeft.blockIsHTML}
						{option:!positionLeft.blockIsHTML}
							{$positionLeft.blockContent}
						{/option:!positionLeft.blockIsHTML}
					{/iteration:positionLeft}
				</div>

			</div>
		</div>

		<noscript>
			<div class="message notice">
				<h4>{$lblEnableJavascript|ucfirst}</h4>
				<p>{$msgEnableJavascript}</p>
			</div>
		</noscript>

		<div class="push"></div>

	</div>

	{include:core/layout/templates/footer.tpl}

	{* General Javascript *}
	{iteration:jsFiles}
		<script src="{$jsFiles.file}"></script>
	{/iteration:jsFiles}

	{* Site wide HTML *}
	{$siteHTMLFooter}
</body>
</html>