<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xpath-default-namespace="http://www.w3.org/2005/xpath-functions">

<xsl:template name="component-search">
<xsl:param name="responsive" select="'yes'"/>

<div>
<xsl:attribute name="class">
<xsl:text>search</xsl:text>
<xsl:if test="$responsive = 'yes'">
  <xsl:text> responsive</xsl:text>
</xsl:if>
</xsl:attribute>

<xsl:call-template name="component-logo"/>

<form role="search" class="search-bar">
<xsl:attribute name="action">/search.html</xsl:attribute>
<div>
<xsl:attribute name = "class">
<xsl:text>search-block</xsl:text>
</xsl:attribute>

<input type="text" name="query" class="query">
<xsl:attribute name="aria-label"><xsl:value-of select="$localization//*[@component='search' and @part='label']"/></xsl:attribute>
<xsl:attribute name="placeholder"><xsl:value-of select="$localization//*[@component='search' and @part='placeholder']"/></xsl:attribute>
<xsl:attribute name="value"><xsl:value-of select="$queryText"/></xsl:attribute>
<xsl:for-each select="//*[@key='query']/*">
  <xsl:attribute name="data-{@key}">
  <xsl:choose>
  <xsl:when test="name() = 'map' or name() = 'array'">
    <xsl:value-of select="xml-to-json(.)"/>
  </xsl:when>
  <xsl:otherwise>
    <xsl:value-of select="."/>
  </xsl:otherwise>
  </xsl:choose>
  </xsl:attribute>
</xsl:for-each>
</input>
<xsl:for-each select="//*[@key='query']/*[@key='properties']/*[@key='mode' or @key='pageLayout']">
  <input type="hidden">
  <xsl:attribute name="name"><xsl:value-of select="@key"/></xsl:attribute>
  <xsl:attribute name="value"><xsl:value-of select="."/></xsl:attribute>
  </input>
</xsl:for-each>
<button type="submit" class="search-bar__submit-button">
<xsl:attribute name="aria-label"><xsl:value-of select="$localization//*[@component='search' and @part='button']"/></xsl:attribute>
<svg role="presentation" xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" class="search-icon">
<path d="M17 10a7 7 0 0 1-7 7 7 7 0 0 1-7-7 7 7 0 0 1 7-7 7 7 0 0 1 7 7zM21 21l-6-6" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" />
</svg>
</button>
</div>
<div>
<xsl:attribute name = "class">
<xsl:text>suggestions</xsl:text>
</xsl:attribute>
<xsl:attribute name = "style">
<xsl:text>display:none</xsl:text>
</xsl:attribute>


</div>



</form>

</div>

</xsl:template>

</xsl:stylesheet>

