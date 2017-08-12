<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns="http://www.worlddab.org/schemas/spi/31"
    xmlns:epg="http://www.worlddab.org/schemas/epgDataTypes/14"
    xmlns:repg="http://schemas.radiodns.org/epg/11"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    exclude-result-prefixes="epg repg">

    <xsl:output encoding="UTF-8" />

    <!-- moves elements from the DAB EPG namespace in to the current namespace -->
    <xsl:template match="epg:definition |
                         epg:genre |
                         epg:shortDescription |
                         epg:shortName |
                         epg:longDescription |
                         epg:longName |
                         epg:mediumName |
                         epg:multimedia |
                         epg:name">
        <xsl:element name="{local-name()}">
            <xsl:apply-templates select="@*|node()"/>
        </xsl:element>
    </xsl:template>

    <!-- maps elements that remain identical from XSI namespace to current namespace -->
    <xsl:template match="/repg:serviceInformation |
                         /repg:serviceInformation/repg:services |
                         /repg:serviceInformation/repg:services/repg:*[local-name() = 'service' or local-name() = 'serviceProvider'] |
                         /repg:serviceInformation/repg:services/repg:service/repg:*[local-name() = 'keywords' or local-name() = 'mediaDescription' or local-name() = 'radiodns'] |
                         /repg:serviceInformation/repg:services/repg:service/repg:serviceID/repg:location/repg:*[local-name() = 'point' or local-name() = 'polygon' or local-name() = 'country'] |
                         /repg:serviceInformation/repg:services/repg:*[local-name() = 'service' or local-name() = 'serviceProvider']/repg:*[local-name() = 'link' or local-name() = 'mediaDescription'] |
                         /repg:serviceInformation/repg:services/repg:*[local-name() = 'service' or local-name() = 'serviceProvider']/repg:location/repg:*[local-name() = 'point' or local-name() = 'polygon' or local-name() = 'country'] |
                         /repg:serviceInformation/repg:groups/repg:group/repg:*[local-name() = 'keywords' or local-name() = 'link' or local-name() = 'mediaDescription'] |
                         /repg:serviceInformation/repg:groups/repg:group/repg:location/repg:*[local-name() = 'point' or local-name() = 'polygon' or local-name() = 'country']">
        <xsl:element name="{local-name()}">
            <xsl:apply-templates select="@*|node()" />
        </xsl:element>
    </xsl:template>

    <!-- changes the XSI schema to that used in the current namespace -->
    <xsl:template match="/repg:serviceInformation/@xsi:schemaLocation">
        <xsl:attribute name="xsi:schemaLocation">http://www.worlddab.org/schemas/spi/31 spi_31.xsd</xsl:attribute>
    </xsl:template>

    <!-- maps XSI groups element to SI serviceGroups element -->
    <xsl:template match="/repg:serviceInformation/repg:groups">
        <serviceGroups>
            <xsl:apply-templates select="@*|node()" />
        </serviceGroups>
    </xsl:template>

    <!-- maps XSI group element to SI serviceGroup element -->
    <xsl:template match="/repg:serviceInformation/repg:groups/repg:group">
        <serviceGroup>
            <xsl:apply-templates select="@*|node()" />
        </serviceGroup>
    </xsl:template>

    <!-- maps XSI location element to SI geolocation element -->
    <xsl:template match="/repg:serviceInformation/repg:groups/repg:group/repg:location |
                         /repg:serviceInformation/repg:services/repg:*[local-name() = 'service' or local-name() = 'serviceProvider']/repg:location |
                         /repg:serviceInformation/repg:services/repg:service/repg:serviceID/repg:location">
        <geolocation>
            <xsl:apply-templates select="@*|node()"/>
        </geolocation>
    </xsl:template>

    <!-- maps XSI serviceID element to SI bearer element -->
    <xsl:template match="/repg:serviceInformation/repg:services/repg:service/repg:serviceID">
        <bearer>
            <xsl:apply-templates select="@*|node()"/>
        </bearer>
    </xsl:template>

    <!-- maps XSI memberOf element to SI serviceGroupMember element -->
    <xsl:template match="/repg:serviceInformation/repg:services/repg:service/repg:memberOf">
        <serviceGroupMember>
            <xsl:apply-templates select="@*|node()"/>
        </serviceGroupMember>
    </xsl:template>

    <!-- changes legacy structure of genre tags to newer SI format -->
    <xsl:template match="/repg:serviceInformation/repg:groups/repg:group/epg:genre |
                         /repg:serviceInformation/repg:services/repg:service/epg:genre">
        <genre>
            <xsl:apply-templates select="@*"/>
            <xsl:value-of select="epg:name"/>
        </genre>
    </xsl:template>

    <!-- maps XSI link element url attribute to SI link element uri attribute -->
    <xsl:template match="/repg:serviceInformation/repg:groups/repg:group/repg:link/@url |
                         /repg:serviceInformation/repg:services/repg:*[local-name() = 'serviceProvider' or local-name() = 'service']/repg:link/@url">
        <xsl:attribute name="uri">
            <xsl:value-of select="."/>
        </xsl:attribute>
    </xsl:template>

    <!-- maps XSI serviceID element mime attribute to SI bearer element mimeValue attribute -->
    <xsl:template match="/repg:serviceInformation/repg:services/repg:service/repg:serviceID/@mime">
        <xsl:attribute name="mimeValue">
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
