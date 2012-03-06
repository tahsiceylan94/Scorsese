{include:core/layout/templates/head.tpl}

<body class="{$LANGUAGE}" itemscope itemtype="http://schema.org/WebPage">
	<div id="container">
		<header id="header">
			<div class="logoNavWrapper">
				<div class="wrapper nav">

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
			<div class="wrapper headOption">
				<div id="headerOptions">

					{* Top position *}
					{iteration:positionTop}
						{$positionTop.blockContent}
					{/iteration:positionTop}

					{* Language *}
					<nav id="language">
						{include:core/layout/templates/languages.tpl}
					</nav>
				</div>
			</div>

		</header>

		<div id="mainWrapper" class="clearfix">
			{option:positionEyeCatch}
				<div id="eyeCatcher" class="clearfix">
					<div class="wrapper">
						{iteration:positionEyeCatch}
							{$positionEyeCatch.blockContent}
						{/iteration:positionEyeCatch}
					</div>
				</div>
			{/option:positionEyeCatch}

			<div class="wrapper">
				{option:positionLeft}
				<div class="side left clearfix">
					{* Left position *}
					{iteration:positionLeft}
						{option:positionLeft.blockIsHTML}
							<section class="mod">
								<div class="content">
									{$positionLeft.blockContent}
								</div>
							</section>
						{/option:positionLeft.blockIsHTML}
						{option:!positionLeft.blockIsHTML}
							{$positionLeft.blockContent}
						{/option:!positionLeft.blockIsHTML}
					{/iteration:positionLeft}
				</div>
				{/option:positionLeft}
				{option:!positionLeft}
					<div class="side push"></div>
				{/option:!positionLeft}

				{option:positionMain}
					<div id="main">
						{* Main position *}
						<div id="innerMain">
							{iteration:positionMain}
								{option:positionMain.blockIsHTML}
									<section class="mod">
										<div class="content">
											{$positionMain.blockContent}
										</div>
									</section>
								{/option:positionMain.blockIsHTML}
								{option:!positionMain.blockIsHTML}
									{$positionMain.blockContent}
								{/option:!positionMain.blockIsHTML}
							{/iteration:positionMain}
						</div>
					</div>
				{/option:positionMain}
				{option:!positionMain}
					<div class="push" id="main"></div>
				{/option:!positionMain}

				{option:positionRight}
				<div class="side right">
					{* Right position *}
					{iteration:positionRight}
						{option:positionRight.blockIsHTML}
							<section class="mod">
								<div class="content">
									{$positionRight.blockContent}
								</div>
							</section>
						{/option:positionRight.blockIsHTML}
						{option:!positionRight.blockIsHTML}
							{$positionRight.blockContent}
						{/option:!positionRight.blockIsHTML}
					{/iteration:positionRight}
				</div>
				{/option:positionRight}
				{option:!positionRight}
					<div class="side push"></div>
				{/option:!positionRight}

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