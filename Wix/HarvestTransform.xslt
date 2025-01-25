<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:wxs="http://wixtoolset.org/schemas/v4/wxs">
  <xsl:output omit-xml-declaration="no" indent="yes" encoding="UTF-8"/>
  <xsl:strip-space elements="*"/>

  <!-- Identity transform -->
  <xsl:template match="@* | node()">
    <xsl:copy>
      <xsl:apply-templates select="@* | node()"/>
    </xsl:copy>
  </xsl:template>

  <!-- Make Component perUser Installable -->
  <xsl:template match="wxs:File/@KeyPath" />
  <xsl:template match="wxs:Component">
    <xsl:copy>
      <xsl:apply-templates select="@* | node()" />

      <xsl:element name="RegistryValue" namespace="http://wixtoolset.org/schemas/v4/wxs">
        <xsl:attribute name="Id"><xsl:value-of select="concat(@Id,'_dir_reg')" /></xsl:attribute>
        <xsl:attribute name="Root">HKCU</xsl:attribute>
        <xsl:attribute name="Key"><xsl:value-of select="concat(@Id,'_Directory')" /></xsl:attribute>
        <xsl:attribute name="Value"><xsl:value-of select="concat('[',@Id,']')" /></xsl:attribute>
        <xsl:attribute name="KeyPath">true</xsl:attribute>
      </xsl:element>
    </xsl:copy>
  </xsl:template>

  <!-- Insert RemoveFolder Component for Directory -->
  <xsl:template match="wxs:Directory">
    <xsl:copy>
      <xsl:apply-templates select="@* | node()" />

      <xsl:element name="Component" namespace="http://wixtoolset.org/schemas/v4/wxs">
        <xsl:attribute name="Id"><xsl:value-of select="concat(@Id,'_dir')" /></xsl:attribute>
        <xsl:element name="RegistryValue" namespace="http://wixtoolset.org/schemas/v4/wxs">
          <xsl:attribute name="Id"><xsl:value-of select="concat(@Id,'_dir_reg')" /></xsl:attribute>
          <xsl:attribute name="Root">HKCU</xsl:attribute>
          <xsl:attribute name="Key"><xsl:value-of select="concat(@Id,'_Directory')" /></xsl:attribute>
          <xsl:attribute name="Value"><xsl:value-of select="concat('[',@Id,']')" /></xsl:attribute>
          <xsl:attribute name="KeyPath">true</xsl:attribute>
        </xsl:element>
        <xsl:element name="RemoveFolder" namespace="http://wixtoolset.org/schemas/v4/wxs">
          <xsl:attribute name="Id"><xsl:value-of select="concat(@Id,'_dir_remove')" /></xsl:attribute>
          <xsl:attribute name="Property"><xsl:value-of select="@Id" /></xsl:attribute>
          <xsl:attribute name="On">uninstall</xsl:attribute>
        </xsl:element>
      </xsl:element>
    </xsl:copy>
  </xsl:template>

</xsl:stylesheet>