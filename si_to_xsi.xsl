<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns="http://schemas.radiodns.org/epg/11"
    xmlns:epg="http://www.worlddab.org/schemas/epgDataTypes/14"
    xmlns:spi="http://www.worlddab.org/schemas/spi/31"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    exclude-result-prefixes="spi">

    <xsl:output encoding="UTF-8" />

    <!-- moves elements formerly of the DAB EPG namespace back out to that namespace -->
    <xsl:template match="spi:definition |
                         spi:genre |
                         spi:shortDescription |
                         spi:shortName |
                         spi:longDescription |
                         spi:longName |
                         spi:mediumName |
                         spi:multimedia |
                         spi:name">
        <xsl:element name="epg:{local-name()}">
            <xsl:apply-templates select="@*|node()"/>
        </xsl:element>
    </xsl:template>

    <!-- maps elements that remain identical from SI namespace to current namespace -->
    <xsl:template match="/spi:serviceInformation |
                         /spi:serviceInformation/spi:services |
                         /spi:serviceInformation/spi:services/spi:service |
                         /spi:serviceInformation/spi:services/spi:service/spi:bearer/spi:geolocation/spi:*[local-name() = 'point' or local-name() = 'polygon' or local-name() = 'country'] |
                         /spi:serviceInformation/spi:services/spi:service/spi:geolocation/spi:*[local-name() = 'point' or local-name() = 'polygon' or local-name() = 'country'] |
                         /spi:serviceInformation/spi:services/spi:service/spi:keywords |
                         /spi:serviceInformation/spi:services/spi:service/spi:link |
                         /spi:serviceInformation/spi:services/spi:service/spi:mediaDescription |
                         /spi:serviceInformation/spi:services/spi:service/spi:radiodns |
                         /spi:serviceInformation/spi:services/spi:serviceProvider |
                         /spi:serviceInformation/spi:services/spi:serviceProvider/spi:geolocation/spi:*[local-name() = 'point' or local-name() = 'polygon' or local-name() = 'country'] |
                         /spi:serviceInformation/spi:services/spi:serviceProvider/spi:link |
                         /spi:serviceInformation/spi:services/spi:serviceProvider/spi:mediaDescription |
                         /spi:serviceInformation/spi:serviceGroups/spi:serviceGroup/spi:keywords |
                         /spi:serviceInformation/spi:serviceGroups/spi:serviceGroup/spi:link |
                         /spi:serviceInformation/spi:serviceGroups/spi:serviceGroup/spi:mediaDescription">
        <xsl:element name="{local-name()}">
            <xsl:apply-templates select="@*|node()" />
        </xsl:element>
    </xsl:template>

    <!-- changes the XSI schema to that used in the current namespace -->
    <xsl:template match="/spi:serviceInformation/@xsi:schemaLocation">
        <xsl:attribute name="xsi:schemaLocation">http://schemas.radiodns.org/epg/11 http://schemas.radiodns.org/epg/11/radioepg_xsi_11.xsd</xsl:attribute>
    </xsl:template>

    <!-- maps SI serviceGroups element to XSI groups element -->
    <xsl:template match="/spi:serviceInformation/spi:serviceGroups">
        <groups>
            <xsl:apply-templates select="@*|node()"/>
        </groups>
    </xsl:template>

    <!-- maps SI serviceGroup element to XSI group element -->
    <xsl:template match="/spi:serviceInformation/spi:serviceGroups/spi:serviceGroup">
        <group>
            <xsl:apply-templates select="@*|node()"/>
        </group>
    </xsl:template>

    <!-- maps SI geolocation element to XSI location element -->
    <xsl:template match="/spi:serviceInformation/spi:services/spi:*[local-name() = 'service' or local-name() = 'serviceProvider']/spi:geolocation |
                         /spi:serviceInformation/spi:services/spi:service/spi:bearer/spi:geolocation |
                         /spi:serviceInformation/spi:serviceGroups/spi:group/spi:geolocation">
        <location>
            <xsl:apply-templates select="@*|node()"/>
        </location>
    </xsl:template>

    <!-- maps SI bearer element to XSI serviceID element -->
    <xsl:template match="/spi:serviceInformation/spi:services/spi:service/spi:bearer">
        <serviceID>
            <xsl:apply-templates select="@*|node()"/>
        </serviceID>
    </xsl:template>

    <!-- maps SI serviceGroupMember element to XSI memberOf element -->
    <xsl:template match="/spi:serviceInformation/spi:services/spi:service/spi:serviceGroupMember">
        <memberOf>
            <xsl:apply-templates select="@*|node()"/>
        </memberOf>
    </xsl:template>

    <!-- changes SI genre structure to legacy XSI/EPG format -->
    <xsl:template match="/spi:serviceInformation/spi:services/spi:service/spi:genre |
                         /spi:serviceInformation/spi:serviceGroups/spi:serviceGroup/spi:genre">
        <epg:genre>
            <xsl:apply-templates select="@*"/>
            <epg:name>
                <xsl:value-of select="."/>
            </epg:name>
        </epg:genre>
    </xsl:template>

    <!-- maps SI link element uri attribute to XSI link element url attribute -->
    <xsl:template match="/spi:serviceInformation/spi:services/spi:*[local-name() = 'service' or local-name() = 'serviceProvider']/spi:link/@uri |
                         /spi:serviceInformation/spi:serviceGroups/spi:serviceGroup/spi:link/@uri">
        <xsl:attribute name="url">
            <xsl:value-of select="."/>
        </xsl:attribute>
    </xsl:template>

    <!-- maps SI bearer element mimeValue attribute to XSI serviceID element mime attribute -->
    <xsl:template match="/spi:serviceInformation/spi:services/spi:service/spi:bearer/@mimeValue">
        <xsl:attribute name="mime">
            <xsl:value-of select="."/>
        </xsl:attribute>
    </xsl:template>

    <!-- copies all child elements and attributes recursively -->
    <xsl:template match="@*|node()">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()" />
        </xsl:copy>
    </xsl:template>

</xsl:stylesheet>
