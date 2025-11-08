<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:map="http://www.w3.org/2005/xpath-functions/map"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="#all"
    version="3.0">
    
    <xsl:output method="xml" indent="yes"/>
    
    <!-- Load the neologism list -->
    <xsl:include href="neologisms-map.xsl"/>

    
    <xsl:template match="/">
        <!-- Copy the play XML but modify <w> elements as needed -->
        <xsl:apply-templates/>
    </xsl:template>
    
    <!-- Identity transform: copy everything by default -->
    <xsl:template match="node()|@*">
        <xsl:copy>
            <xsl:apply-templates select="node()|@*"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="w">
        <xsl:variable name="word" select="lower-case(normalize-space(.))"/>
        <xsl:choose>
            <xsl:when test="map:contains($neologisms, $word)">
                <xsl:copy>
                    <xsl:attribute name="ana" select="map:get($neologisms, $word)"/>
                    <xsl:value-of select="."/>
                </xsl:copy>
            </xsl:when>
            <xsl:otherwise>
                <xsl:copy>
                    <xsl:apply-templates select="@* | node()"/>
                </xsl:copy>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
   </xsl:stylesheet>