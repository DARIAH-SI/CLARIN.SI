<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.tei-c.org/ns/1.0"
    xmlns:xi="http://www.w3.org/2001/XInclude"
    xmlns:functx="http://www.functx.com"
    exclude-result-prefixes="xs xi tei functx"
    version="2.0">
    
    <!-- izhodiščni dokument je listDoc.xml -->
    
    <xsl:param name="generic-title">Zapisnik sej Skupščine Republike Slovenije</xsl:param>
    <xsl:param name="assembly">Skupščina Republike Slovenije</xsl:param>
    <xsl:param name="term">Mandat 11</xsl:param>
    <xsl:param name="term-with-date">Mandat 11: 5.5.1990 - 23.12.1992</xsl:param>

    <xsl:output method="xml" indent="yes"/>
    
    <xsl:function name="functx:substring-before-last-match" as="xs:string?"
        xmlns:functx="http://www.functx.com">
        <xsl:param name="arg" as="xs:string?"/>
        <xsl:param name="regex" as="xs:string"/>
        <xsl:sequence select="
            replace($arg,concat('^(.*)',$regex,'.*'),'$1')
            "/>
    </xsl:function>
    
    <xsl:variable name="documents">
        <xsl:for-each select="documentsList/ref">
            <xsl:variable name="filename" select="substring-before(substring-after(.,'../Sk-11/'),'.xml')"/>
            <document
                date="{concat(tokenize($filename,'-')[1],'-',tokenize($filename,'-')[2],'-',tokenize($filename,'-')[3])}"
                chamber="{tokenize($filename,'-')[4]}"
                sessionNum="{tokenize($filename,'-')[5]}"
                sortNum="{tokenize($filename,'-')[6]}">
                <xsl:value-of select="substring-after(.,'../Sk-11/')"/>
            </document>
        </xsl:for-each>
    </xsl:variable>
    
    <xsl:template match="documentsList">
        <xsl:for-each select="ref">
            <xsl:variable name="document" select="concat('/Users/administrator/Documents/moje/clarin/SlovParl/Sk-11-teiPublisher/',substring-after(.,'../Sk-11/'))"/>
            <xsl:result-document href="{$document}">
                <xsl:apply-templates select="document(.)"/>
            </xsl:result-document>
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template match="@* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:variable name="persons">
        <xsl:for-each select="document('../../SlovParl.xml')/tei:teiCorpus/tei:teiHeader/tei:profileDesc/tei:particDesc/tei:listPerson">
            <xsl:for-each select="tei:person | tei:personGrp">
                <xsl:copy-of select="."/>
            </xsl:for-each>
        </xsl:for-each>
    </xsl:variable>
    
    <xsl:template match="tei:titleStmt">
        <titleStmt>
            <title>
                <xsl:value-of select="concat($generic-title,', ',$term,', ',tei:title[@xml:lang='sl'][3],', ',tei:title[@xml:lang='sl'][4])"/>
                <xsl:text> (</xsl:text>
                <xsl:value-of select="format-date(
                    ancestor::tei:teiHeader/tei:profileDesc/tei:settingDesc/tei:setting/tei:date/@when,
                    '[D]. [M]. [Y]',
                    'en',(),())">
                </xsl:value-of>
                <xsl:text>)</xsl:text>
            </title>
            <xsl:copy-of select="tei:respStmt"/>
            <xsl:copy-of select="tei:funder"/>
        </titleStmt>
    </xsl:template>
    
    <xsl:template match="tei:front">
        <xsl:variable name="fileid" select="ancestor::tei:TEI/@xml:id"/>
        <xsl:variable name="date" select="tokenize($fileid,'\.')[2]"/>
        <xsl:variable name="chamber" select="tokenize($fileid,'\.')[1]"/>
        <xsl:variable name="sessionNum" select="tokenize(tokenize($fileid,'\.')[3],'-')[1]"/>
        <xsl:variable name="sortNum" select="tokenize(tokenize($fileid,'\.')[3],'-')[2]"/>
        <xsl:variable name="filename" select="concat($date,'-',$chamber,'-',$sessionNum,'-',$sortNum,'.xml')"/>
        <xsl:variable name="document-ana" select="concat('../../Sk-11-ana/',$filename)"/>
        <xsl:variable name="tagsDecl-ana">
            <xsl:for-each select="document($document-ana)/tei:TEI/tei:teiHeader/tei:encodingDesc/tei:tagsDecl/tei:namespace">
                <xsl:copy-of select="."/>
            </xsl:for-each>
        </xsl:variable>
        <!-- <xsl:variable name="documents">
        <xsl:for-each select="documentsList/ref">
            <xsl:variable name="filename" select="substring-before(substring-after(.,'../Sk-11/'),'.xml')"/>
            <document
                date="{concat(tokenize($filename,'-')[1],'-',tokenize($filename,'-')[2],'-',tokenize($filename,'-')[3])}"
                chamber="tokenize($filename,'-')[4]"
                sessionNum="{tokenize($filename,'-')[5]}"
                sortNum="{tokenize($filename,'-')[6]}">
                <xsl:value-of select="substring-after(.,'../Sk-11/')"/>
            </document>
        </xsl:for-each>
    </xsl:variable> -->
        <front>
            <div type="about">
                <head>O zapisniku seje</head>
                <list>
                    <item>
                        <xsl:value-of select="$assembly"/>
                    </item>
                    <item>
                        <xsl:value-of select="$term-with-date"/>
                    </item>
                    <item>
                        <xsl:value-of select="ancestor::tei:TEI/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title[@xml:lang='sl'][3]"/>
                    </item>
                    <item>
                        <xsl:value-of select="ancestor::tei:TEI/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title[@xml:lang='sl'][4]"/>
                        <xsl:text> (</xsl:text>
                        <xsl:value-of select="format-date(xs:date($date),'[D]. [M]. [Y]','en',(),())"/>
                        <xsl:text>)</xsl:text>
                    </item>
                </list>
                <xsl:if test="$documents/tei:document[@chamber=$chamber][@sessionNum=$sessionNum][number(@sortNum) = (number($sortNum) - 1)] or 
                              $documents/tei:document[@chamber=$chamber][@sessionNum=$sessionNum][number(@sortNum) = (number($sortNum) + 1)]">
                    <list>
                        <xsl:if test="$documents/tei:document[@chamber=$chamber][@sessionNum=$sessionNum][number(@sortNum) = (number($sortNum) - 1)]">
                            <item>
                                <xsl:text>Predhodni dnevi seje/zasedanja: </xsl:text>
                                <ref target="/exist/apps/parla/{$documents/tei:document[@chamber=$chamber][@sessionNum=$sessionNum][number(@sortNum) = (number($sortNum) - 1)]}">
                                    <xsl:value-of select="format-date(xs:date($documents/tei:document[@chamber=$chamber][@sessionNum=$sessionNum][number(@sortNum) = (number($sortNum) - 1)]/@date),'[D]. [M]. [Y]','en',(),())"/>
                                </ref>
                            </item>
                        </xsl:if>
                        <xsl:if test="$documents/tei:document[@chamber=$chamber][@sessionNum=$sessionNum][number(@sortNum) = (number($sortNum) + 1)]">
                            <item>
                                <xsl:text>Nadaljevanja seje/zasedanja: </xsl:text>
                                <ref target="/exist/apps/parla/{$documents/tei:document[@chamber=$chamber][@sessionNum=$sessionNum][number(@sortNum) = (number($sortNum) + 1)]}">
                                    <xsl:value-of select="format-date(xs:date($documents/tei:document[@chamber=$chamber][@sessionNum=$sessionNum][number(@sortNum) = (number($sortNum) + 1)]/@date),'[D]. [M]. [Y]','en',(),())"/>
                                </ref>
                            </item>
                        </xsl:if>
                    </list>
                </xsl:if>
                <table>
                    <row>
                        <cell>Govori</cell>
                        <cell>
                            <xsl:value-of select="count(//tei:div[@type='sp' or @type='inter'])"/>
                        </cell>
                    </row>
                    <row>
                        <cell>Stavki</cell>
                        <cell>
                            <xsl:value-of select="$tagsDecl-ana/tei:namespace/tei:tagUsage[@gi='s']/@occurs"/>
                        </cell>
                    </row>
                    <row>
                        <cell>Besede</cell>
                        <cell>
                            <xsl:value-of select="$tagsDecl-ana/tei:namespace/tei:tagUsage[@gi='w']/@occurs"/>
                        </cell>
                    </row>
                    <row>
                        <cell>Ločila</cell>
                        <cell>
                            <xsl:value-of select="$tagsDecl-ana/tei:namespace/tei:tagUsage[@gi='pc']/@occurs"/>
                        </cell>
                    </row>
                    <row>
                        <cell>Oznake časa</cell>
                        <cell>
                            <xsl:value-of select="$tagsDecl-ana/tei:namespace/tei:tagUsage[@gi='timeline']/@occurs"/>
                        </cell>
                    </row>
                    <xsl:if test="//tei:note[@type='vote']">
                        <row>
                            <cell>Glasovanja</cell>
                            <cell>
                                <xsl:value-of select="count(//tei:note[@type='vote'])"/>
                            </cell>
                        </row>
                    </xsl:if>
                    <xsl:if test="//tei:note[@type='quorum']">
                        <row>
                            <cell>Kvorumi</cell>
                            <cell>
                                <xsl:value-of select="count(//tei:note[@type='quorum'])"/>
                            </cell>
                        </row>
                    </xsl:if>
                    <xsl:if test="//tei:note[@type='comment']">
                        <row>
                            <cell>Komentarji</cell>
                            <cell>
                                <xsl:value-of select="count(//tei:note[@type='comment'])"/>
                            </cell>
                        </row>
                    </xsl:if>
                    <xsl:if test="//tei:note[@type='debate']">
                        <row>
                            <cell>Debate</cell>
                            <cell>
                                <xsl:value-of select="count(//tei:note[@type='debate'])"/>
                            </cell>
                        </row>
                    </xsl:if>
                    <xsl:if test="$tagsDecl-ana/tei:namespace/tei:tagUsage[@gi='gap']">
                        <row>
                            <cell>Vrzeli v govorih</cell>
                            <cell>
                                <xsl:value-of select="$tagsDecl-ana/tei:namespace/tei:tagUsage[@gi='gap']/@occurs"/>
                            </cell>
                        </row>
                    </xsl:if>
                    <xsl:if test="$tagsDecl-ana/tei:namespace/tei:tagUsage[@gi='vocal']">
                        <row>
                            <cell>Slišna sporočila</cell>
                            <cell>
                                <xsl:value-of select="$tagsDecl-ana/tei:namespace/tei:tagUsage[@gi='vocal']/@occurs"/>
                            </cell>
                        </row>
                    </xsl:if>
                    <xsl:if test="$tagsDecl-ana/tei:namespace/tei:tagUsage[@gi='kinesic']">
                        <row>
                            <cell>Gibalna sporočila</cell>
                            <cell>
                                <xsl:value-of select="$tagsDecl-ana/tei:namespace/tei:tagUsage[@gi='kinesic']/@occurs"/>
                            </cell>
                        </row>
                    </xsl:if>
                    <xsl:if test="$tagsDecl-ana/tei:namespace/tei:tagUsage[@gi='incident']">
                        <row>
                            <cell>Pripetljaji</cell>
                            <cell>
                                <xsl:value-of select="$tagsDecl-ana/tei:namespace/tei:tagUsage[@gi='incident']/@occurs"/>
                            </cell>
                        </row>
                    </xsl:if>
                    <xsl:if test="$tagsDecl-ana/tei:namespace/tei:tagUsage[@gi='writing']">
                        <row>
                            <cell>Pisno v govoru</cell>
                            <cell>
                                <xsl:value-of select="$tagsDecl-ana/tei:namespace/tei:tagUsage[@gi='writing']/@occurs"/>
                            </cell>
                        </row>
                    </xsl:if>
                </table>
            </div>
            <div type="timeline">
                <head>Časovni potek</head>
                <table>
                    <row role="label">
                        <cell>od</cell>
                        <cell>do</cell>
                        <cell>interval (minute)</cell>
                    </row>
                    <xsl:for-each select="parent::tei:text/tei:body/tei:timeline/tei:when[@xml:id]">
                        <xsl:variable name="whenID" select="@xml:id"/>
                        <row>
                            <cell>
                                <ref target="{@synch}">
                                    <xsl:for-each select="@absolute">
                                        <xsl:call-template name="absolute-time"/>
                                    </xsl:for-each>
                                </ref>
                            </cell>
                            <cell>
                                <xsl:for-each select="following-sibling::tei:when[@since = concat('#',$whenID)]">
                                    <ref target="{@synch}">
                                        <xsl:for-each select="@absolute">
                                            <xsl:call-template name="absolute-time"/>
                                        </xsl:for-each>
                                    </ref>
                                </xsl:for-each>
                            </cell>
                            <cell>
                                <xsl:for-each select="following-sibling::tei:when[@since = concat('#',$whenID)]">
                                    <xsl:value-of select="@interval"/>
                                </xsl:for-each>
                            </cell>
                        </row>
                    </xsl:for-each>
                </table>
            </div>
            <div type="contents">
                <head>Dnevni red</head>
                <list>
                    <xsl:for-each select="tei:div[@type='contents']/tei:list/tei:item">
                        <xsl:variable name="corresp">
                            <xsl:for-each select="tokenize(@corresp,' ')">
                                <item>
                                    <xsl:value-of select="substring-after(.,'#')"/>
                                </item>
                            </xsl:for-each>
                        </xsl:variable>
                        <item xml:id="{@xml:id}" corresp="{@corresp}">
                            <ref target="{tokenize(@corresp,' ')[1]}">
                                <xsl:value-of select="tei:title"/>
                            </ref>
                            <!-- vse povezave na govore -->
                            <list>
                                <xsl:for-each select="ancestor::tei:text/tei:body/tei:div[tei:u/@xml:id=$corresp/tei:item]">
                                    <xsl:variable name="who" select="substring-after(tei:u[@xml:id=$corresp/tei:item][1]/@who,'#')"/>
                                    <item>
                                        <ref target="{tei:u[@xml:id=$corresp/tei:item][1]/@xml:id}">
                                            <xsl:for-each select="$persons/tei:personGrp[@xml:id=$who]">
                                                <xsl:value-of select="tei:state/tei:desc[@xml:lang='sl']"/>
                                                <xsl:value-of select="tei:state/tei:label[@xml:lang='sl']"/>
                                            </xsl:for-each>
                                            <xsl:for-each select="$persons/tei:person[@xml:id=$who]">
                                                <xsl:for-each select="tei:persName[1]">
                                                    <xsl:value-of select="concat(tei:forename[1],' ')"/>
                                                    <xsl:value-of select="tei:surname[1]"/>
                                                    <xsl:for-each select="tei:surname[2][not(@type='alt')]">
                                                        <xsl:value-of select="concat(' ',.)"/>
                                                    </xsl:for-each>
                                                </xsl:for-each>
                                            </xsl:for-each>
                                        </ref>
                                    </item>
                                </xsl:for-each>
                            </list>
                        </item>
                    </xsl:for-each>
                </list>
            </div>
        </front>
    </xsl:template>
    
    <xsl:template match="tei:body">
        <body>
            <xsl:apply-templates/>
        </body>
        <!-- dodam back -->
        <back>
            <div type="speakers">
                <head>Seznam govornikov</head>
                <list>
                    <xsl:for-each-group select="tei:div[@type='sp' or @type='inter']" group-by="tei:u[1]/@who">
                        <xsl:sort select="substring-after(current-grouping-key(),'#')"/>
                        <xsl:variable name="who" select="substring-after(current-grouping-key(),'#')"/>
                        <item>
                            <xsl:for-each select="$persons/tei:personGrp[@xml:id=$who]">
                                <xsl:value-of select="tei:state/tei:desc[@xml:lang='sl']"/>
                                <xsl:value-of select="tei:state/tei:label[@xml:lang='sl']"/>
                            </xsl:for-each>
                            <!-- TODO: tukaj dodaj zunanjo povezavo na HTML aplikacijo, kjer so na Saxon-JS spletni strani podatki o tem govorniku -->
                            <!--<ref target="">-->
                                <xsl:for-each select="$persons/tei:person[@xml:id=$who]">
                                    <xsl:for-each select="tei:persName[1]">
                                        <xsl:value-of select="tei:surname[1]"/>
                                        <xsl:for-each select="tei:surname[2][not(@type='alt')]">
                                            <xsl:value-of select="concat(' ',.)"/>
                                        </xsl:for-each>
                                        <xsl:if test="tei:forename">
                                            <xsl:text>, </xsl:text>
                                        </xsl:if>
                                        <xsl:value-of select="tei:forename[1]"/>
                                        <xsl:if test="../tei:birth/@when">
                                            <xsl:value-of select="concat(' (',tokenize(../tei:birth/@when,'-')[1],')')"/>
                                        </xsl:if>
                                    </xsl:for-each>
                                </xsl:for-each>
                            <!--</ref>-->
                            <xsl:text>: </xsl:text>
                            <xsl:for-each select="current-group()">
                                <ref target="{tei:u[1]/@xml:id}">govor</ref>
                                <xsl:if test="position() != last()">, </xsl:if>
                            </xsl:for-each>
                        </item>
                    </xsl:for-each-group>
                </list>
            </div>
        </back>
    </xsl:template>
    
    <xsl:template name="absolute-time">
        <xsl:choose>
            <xsl:when test="contains(.,'T')">
                <!-- sekund ne prikažem -->
                <xsl:value-of select="functx:substring-before-last-match(substring-after(.,'T'),':')"/>
            </xsl:when>
            <xsl:otherwise>Brez časa</xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    
</xsl:stylesheet>
