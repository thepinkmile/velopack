<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:wxs="http://wixtoolset.org/schemas/v4/wxs">
  <xsl:output omit-xml-declaration="no" indent="yes" encoding="UTF-8"/>
  <xsl:strip-space elements="*"/>

  <!-- Identity transform -->
  <xsl:template match="@* | node()">
    <xsl:copy>
      <xsl:apply-templates select="@* | node()"/>
    </xsl:copy>
  </xsl:template>

  <!-- Update ComponentGroup with any/all Component Id values -->
  <xsl:template match="wxs:ComponentGroup">
    <xsl:copy>
      <xsl:copy-of select="@*" />

      <xsl:for-each select="//wxs:Component">
        <xsl:element name="ComponentRef" namespace="http://wixtoolset.org/schemas/v4/wxs">
          <xsl:attribute name="Id">
            <xsl:value-of select="@Id" />
          </xsl:attribute>
        </xsl:element>
      </xsl:for-each>
    </xsl:copy>
  </xsl:template>

</xsl:stylesheet>