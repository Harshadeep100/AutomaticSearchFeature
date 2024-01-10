<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:loc="https://args.me/xml/locale"
  xpath-default-namespace="http://www.w3.org/2005/xpath-functions">
<xsl:output method="html" version="5" indent="yes" encoding="utf-8"/>

<!-- layout parameters: overwrite in the "page-*.xml" file to change the layout -->
<xsl:param name="title" select="$localization//loc:text[@element='title' and @page='index']"/> <!-- title in the browser address bar -->
<xsl:param name="showHeader" select="'yes'"/>          <!-- whether to show the header (including the search bar -->
<xsl:param name="mainFillsVertically" select="'no'"/>  <!-- whether to display the main element so that it fills the space vertically -->
<xsl:template name="content"></xsl:template>           <!-- main content of the page (inside the common page layout) -->

<!-- include all variable files -->
<xsl:include href="html/variable-localization.xsl"/>
<xsl:include href="html/variable-query.xsl"/>

<!-- include all template files -->
<xsl:include href="html/component-argument-author.xsl"/>
<xsl:include href="html/component-argument-excerpt.xsl"/>
<xsl:include href="html/component-argument-image.xsl"/>
<xsl:include href="html/component-argument-meta.xsl"/>
<xsl:include href="html/component-argument-score.xsl"/>
<xsl:include href="html/component-argument.xsl"/>
<xsl:include href="html/component-aspect-space.xsl"/>
<xsl:include href="html/component-columns.xsl"/>
<xsl:include href="html/component-logo.xsl"/>
<xsl:include href="html/component-menubar.xsl"/>
<xsl:include href="html/component-pagination.xsl"/>
<xsl:include href="html/component-search.xsl"/>

<!-- root template = layout; calling template "content" at the appropriate position -->
<xsl:template match="/">
<html>
<xsl:attribute name="lang"><xsl:value-of select="$locale"/></xsl:attribute>

<head>
<meta charset="UTF-8"/>
<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
<title><xsl:value-of select="$title"/></title>
<link rel="stylesheet" href="/css/args.css"/>
<link rel="icon" href="/img/args-logo.png"/>
<script src="/js/details-element-polyfill.js"></script>
<script src="/js/css-vars-ponyfill.js"></script>
<script src="/js/component-excerpt.js"></script>

<!-- includes for the vis -->
<script src="https://code.jquery.com/jquery-1.10.2.js"></script>
<script src="https://d3js.org/d3.v5.min.js"></script>
<script src="https://d3js.org/d3-array.v2.min.js"></script>
<script src="/js/component-aspect-space.js"></script>
<script src="/js/lasso.js"></script>
</head>

<body>

<xsl:if test="$showHeader = 'yes'">
<header class="site-head">
<xsl:call-template name="component-search"/>
</header>
</xsl:if>

<main>
<xsl:if test="$mainFillsVertically = 'yes'">
  <xsl:attribute name="class">vertical-fill</xsl:attribute>
</xsl:if>
<xsl:call-template name="content"/>
</main>

<footer class="site-foot">
<div class="site-foot-content">
<div>
<a href="/api-en.html">API</a>
<xsl:text> </xsl:text><span class="separator">•</span><xsl:text> </xsl:text>
<a href="/about-en.html">About</a>
</div>
<div>
Copyright&#160;©&#160;<xsl:value-of select="year-from-date(current-date())"/>&#160;<a href="https://webis.de">Webis&#160;Group</a>
<xsl:text> </xsl:text><span class="separator">•</span><xsl:text> </xsl:text>
<a href="https://github.com/webis-de"><i class="fab fa-github"></i></a>
<a href="https://twitter.com/webis_de" class="separator"><i class="fab fa-twitter"></i></a>
<a href="https://www.youtube.com/webis"><i class="fab fa-youtube"></i></a>
<xsl:text> </xsl:text><span class="separator">•</span><xsl:text> </xsl:text>
<a href="https://cs.uni-paderborn.de/css/group/group/#wachsmuth">Contact</a>
<xsl:text> </xsl:text><span class="separator">•</span><xsl:text> </xsl:text>
<a href="https://webis.de/legal.html">Impressum&#160;/&#160;Terms&#160;/&#160;Privacy</a>
</div>
</div>
</footer>

<script src="/js/queryLogData.js"></script>
<script src="/js/searchAutocomplete.js"></script>

</body>

</html>
</xsl:template>

</xsl:stylesheet>
