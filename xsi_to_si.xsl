<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:epg="http://www.worlddab.org/schemas/epgDataTypes/14"
	xmlns:repg="http://schemas.radiodns.org/epg/11"
	xmlns="http://www.worlddab.org/schemas/spi/31"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
	
	<xsl:template match="/">
		<xsl:apply-templates select="repg:serviceInformation"/>
	</xsl:template>
	
	<xsl:template match="repg:serviceInformation">
		<serviceInformation>
			<xsl:attribute name="xsi:schemaLocation">http://www.worlddab.org/schemas/spi/31 spi_31.xsd</xsl:attribute>
			<xsl:attribute name="creationTime">
				<xsl:value-of select="@creationTime"/>
			</xsl:attribute>
			<xsl:attribute name="xml:lang">
				<xsl:value-of select="@xml:lang"/>
			</xsl:attribute>
			<xsl:apply-templates/>
		</serviceInformation>
	</xsl:template>
	
	<xsl:template match="repg:services">
		<services>
			<xsl:apply-templates select="repg:serviceProvider"/>
			<xsl:apply-templates select="repg:service"/>
		</services>
	</xsl:template>

	<xsl:template match="repg:serviceProvider">
		<serviceProvider>
		 	<xsl:apply-templates />
		</serviceProvider>
	</xsl:template>
	
	<xsl:template match="repg:service">
		<service>
			<xsl:apply-templates />
		</service>
	</xsl:template>
	
	<xsl:template match="epg:shortName">
		<shortName>
			<xsl:value-of select="."/>
		</shortName>
	</xsl:template>
	
	<xsl:template match="epg:mediumName">
		<mediumName>
			<xsl:value-of select="."/>
		</mediumName>
	</xsl:template>
	
	<xsl:template match="epg:longName">
		<longName>
			<xsl:value-of select="."/>
		</longName>
	</xsl:template>
	
	<xsl:template match="repg:mediaDescription">
		<mediaDescription>
			<xsl:apply-templates />
		</mediaDescription>
	</xsl:template>
	
	<xsl:template match="epg:shortDescription">
		<shortDescription>
			<xsl:value-of select="."/>
		</shortDescription>
	</xsl:template>
	
	<xsl:template match="epg:longDescription">
		<shortDescription>
			<xsl:value-of select="."/>
		</shortDescription>
	</xsl:template>
	
	<xsl:template match="epg:multimedia">
		<multimedia>
			<xsl:attribute name="width">
				<xsl:choose>
	          		<xsl:when test="@width">
	            		<xsl:value-of select="@width"/>
	          		</xsl:when>
	          		<xsl:otherwise>
	            		<xsl:choose>
	            			<xsl:when test="@type='logo_colour_square'">32</xsl:when>
	            			<xsl:when test="@type='logo_colour_rectangle'">112</xsl:when> 
	            		</xsl:choose>
	          		</xsl:otherwise>
	          	</xsl:choose>
			</xsl:attribute>
			<xsl:attribute name="height">
				<xsl:choose>
				    <xsl:when test="@width">
	            		<xsl:value-of select="@width"/>
	          		</xsl:when>
	          		<xsl:otherwise>32</xsl:otherwise>
	          	</xsl:choose>
			</xsl:attribute>
			<xsl:attribute name="url">
				<xsl:value-of select="@url"/>
			</xsl:attribute>
		</multimedia>
	</xsl:template>
	
	<xsl:template match="repg:link">
		<link>
			<xsl:attribute name="mimeValue">
				<xsl:value-of select="@mimeValue"/>
			</xsl:attribute>
			<xsl:attribute name="uri">
				<xsl:value-of select="@url"/>
			</xsl:attribute>
		</link>
	</xsl:template>
	
	<xsl:template match="epg:genre">
		<genre>
			<xsl:attribute name="href">
				<xsl:value-of select="@href"/>
			</xsl:attribute>
			<xsl:if test="epg:name">
				<xsl:value-of select="epg:name"/>
			</xsl:if>
		</genre>
	</xsl:template>
	
	<xsl:template match="repg:serviceID">
		<bearer>
			<xsl:attribute name="id">
				<xsl:value-of select="@id"/>
			</xsl:attribute>
			<xsl:if test="@bitrate">
				<xsl:attribute name="bitrate">
					<xsl:value-of select="@bitrate"/>
				</xsl:attribute>
			</xsl:if>
			<xsl:if test="@cost">
				<xsl:attribute name="cost">
					<xsl:value-of select="@cost"/>
				</xsl:attribute>
			</xsl:if>
			<xsl:if test="@offset">
				<xsl:attribute name="offset">
					<xsl:value-of select="@offset"/>
				</xsl:attribute>
			</xsl:if>
			<xsl:if test="@mime">
				<xsl:attribute name="mimeValue">
					<xsl:value-of select="@mime"/>
				</xsl:attribute>
			</xsl:if>			
		</bearer>
	</xsl:template>
	
	<xsl:template match="repg:radiodns">
		<radiodns>
			<xsl:attribute name="fqdn">
				<xsl:value-of select="@fqdn"/>
			</xsl:attribute>
			<xsl:attribute name="serviceIdentifier">
				<xsl:value-of select="@serviceIdentifier"/>
			</xsl:attribute>			
		</radiodns>
	</xsl:template>
	
	<xsl:template match="repg:memberOf">
		<serviceGroupMember>
			<xsl:attribute name="id">
				<xsl:value-of select="@id"/>
			</xsl:attribute>
		</serviceGroupMember>	
	</xsl:template>

	<xsl:template match="repg:location">
		<geolocation>
			<xsl:apply-templates />
		</geolocation>
	</xsl:template>

	<xsl:template match="repg:country">
		<country>
			<xsl:apply-templates />
		</country>
	</xsl:template>
	<xsl:template match="repg:point">
		<point>
			<xsl:apply-templates />
		</point>
	</xsl:template>
	<xsl:template match="repg:polygon">
		<polygon>
			<xsl:apply-templates />
		</polygon>
	</xsl:template>
	
	<xsl:template match="repg:groups">
		<serviceGroups>
			<xsl:apply-templates />
		</serviceGroups>
	</xsl:template>
	
	<xsl:template match="repg:group">
		<serviceGroup>
			<xsl:attribute name="id">
				<xsl:value-of select="@id"/>
			</xsl:attribute>
			<xsl:apply-templates />
		</serviceGroup>
	</xsl:template>

</xsl:stylesheet>
