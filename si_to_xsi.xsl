<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns="http://schemas.radiodns.org/epg/11"
	xmlns:spi="http://www.worlddab.org/schemas/spi/31"
	xmlns:epg="http://www.worlddab.org/schemas/epgDataTypes/14"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	exclude-result-prefixes="spi">
	
	<xsl:template match="/">
		<xsl:apply-templates select="spi:serviceInformation"/>
	</xsl:template>

	<xsl:template match="spi:serviceInformation">
		<serviceInformation>
			<xsl:attribute name="creationTime">
				<xsl:value-of select="@creationTime"/>
			</xsl:attribute>
			<xsl:attribute name="originator">
				<xsl:value-of select="@originator"/>
			</xsl:attribute>
			<xsl:attribute name="xml:lang">
				<xsl:value-of select="@xml:lang"/>
			</xsl:attribute>
			<xsl:attribute name="xsi:schemaLocation">
				<xsl:text>http://schemas.radiodns.org/epg/11 http://schemas.radiodns.org/epg/11/radioepg_xsi_11.xsd</xsl:text>
			</xsl:attribute>
		</serviceInformation>
		<xsl:apply-templates/>
	</xsl:template>

	<xsl:template match="spi:services">
		<services>
			<xsl:apply-templates select="spi:service"/>
		</services>
	</xsl:template>
	
	<xsl:template match="spi:service">
		<service>
			<xsl:apply-templates />
		</service>
	</xsl:template>

	<xsl:template match="spi:shortName">
		<epg:shortName>
			<xsl:value-of select="."/>
		</epg:shortName>
	</xsl:template>
	
	<xsl:template match="spi:mediumName">
		<epg:mediumName>
			<xsl:value-of select="."/>
		</epg:mediumName>
	</xsl:template>
	
	<xsl:template match="spi:longName">
		<epg:longName>
			<xsl:value-of select="."/>
		</epg:longName>
	</xsl:template>

	<xsl:template match="spi:mediaDescription">
		<mediaDescription>
			<xsl:apply-templates/>
		</mediaDescription>
	</xsl:template>

	<xsl:template match="spi:shortDescription">
		<epg:shortDescription>
			<xsl:value-of select="."/>
		</epg:shortDescription>
	</xsl:template>

	<xsl:template match="spi:longDescription">
		<epg:longDescription>
			<xsl:value-of select="."/>
		</epg:longDescription>
	</xsl:template>

	<xsl:template match="spi:multimedia">
		<epg:multimedia>
			<xsl:attribute name="url">
				<xsl:value-of select="@url"/>
			</xsl:attribute>
			<xsl:attribute name="type">
				<xsl:value-of select="@type"/>
			</xsl:attribute>
			<xsl:if test="@type='logo_unrestricted'">
				<xsl:attribute name="width">
					<xsl:value-of select="@width"/>
				</xsl:attribute>
				<xsl:attribute name="height">
					<xsl:value-of select="@height"/>
				</xsl:attribute>
				<xsl:if test="@mimeValue">
					<xsl:attribute name="mimeValue">
						<xsl:value-of select="@mimeValue"/>
					</xsl:attribute>
				</xsl:if>
			</xsl:if>
		</epg:multimedia>
	</xsl:template>

	<xsl:template match="spi:genre">
		<epg:genre>
			<xsl:attribute name="href">
				<xsl:value-of select="@href"/>
			</xsl:attribute>
			<xsl:apply-templates/>
		</epg:genre>
	</xsl:template>

	<xsl:template match="spi:keywords">
		<epg:keywords>
			<xsl:value-of select="."/>
		</epg:keywords>
	</xsl:template>

	<xsl:template match="spi:geolocation">
		<location>
			<xsl:apply-templates/>
		</location>
	</xsl:template>

	<xsl:template match="spi:country">
		<country>
			<xsl:value-of select="."/>
		</country>
	</xsl:template>

	<xsl:template match="spi:polygon">
		<polygon>
			<xsl:value-of select="."/>
		</polygon>
	</xsl:template>

	<xsl:template match="spi:point">
		<point>
			<xsl:value-of select="."/>
		</point>
	</xsl:template>

	<xsl:template match="spi:bearer">
		<serviceID>
			<xsl:attribute name="id">
				<xsl:value-of select="@id"/>
			</xsl:attribute>
			<xsl:attribute name="cost">
				<xsl:value-of select="@cost"/>
			</xsl:attribute>
			<xsl:if test="starts-with(@id, 'dab:')">
				<xsl:attribute name="mime">
					<xsl:value-of select="@mimeValue"/>
				</xsl:attribute>
			</xsl:if>
		</serviceID>
	</xsl:template>
	
</xsl:stylesheet>