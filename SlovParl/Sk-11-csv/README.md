#Slovenian parliamentar corpus SlovParl 2.0: CSV datoteke za statistično analizo

**Zadeva:** Opis CSV datotek, ki so bile generirane iz TEI dokumentov, dostopnih
v CLARIN.SI repozitoriju.

**Citiraj kot:** Pančur, Andrej; Šorn, Mojca and Erjavec, Tomaž:
Slovenian parliamentary corpus SlovParl 2.0. Slovenian language resource repository
CLARIN.SI. [http://hdl.handle.net/11356/1167](http://hdl.handle.net/11356/1167).

Zapisi v CSV datotekah so med seboj povezani z različnimi identifikatorji,
kar omogoča poljubno združevanje datotek glede na skupne spremenljivke. 
Imena teh spremenljivk, ki vsebujejo identifikatorje, so zapisana na sledeči način:
nazivId. Kadar je ime spremenljivke zapisano kot nazivIds, lahko polje vsebuje
enega ali več identifikatorjev, med seboj ločenih s presledkom.

Datoteke so razdeljene v dve večji skupini:

* Metapodatkovne datoteke, ki vsebujejo podatke o:
  * govornikih: person.csv,
  * članstvu teh oseb v različnih organizacijah: affiliation.csv,
  * organizacijah: organization.csv,
  * o različnih časovnih obdobjih (za analizo) pomembnejših organizacij: event.csv,
  * o časovno omejenem združevanju nekaterih od teh organizacij (političnih strank): coallition.csv,
  * o naslovih točk dnevnih redov: title.scv,
  * o klasifikaciji in taksonomiji točk dnevnih redov.
* Datoteke z vsebino govorov: Ista vsebina govorov je dostopna v treh različicah. V skladu s poimenovanjem XML datotek, ki vsebujejo te govore, so v treh direktorih temu ustrezno poimenovane CSV datoteke:
  * string/: Vso besedilo zapisnikov sej, tako govori kot komentarji, imena govornikov ipd.
  * lemmata/:  Vsebuje samo govorjeno besedilo (utterance). Od govorjenega besedila vsebuje samo leme besed.
  * lemma/: Vsaka lema govora je nov zapis v tabeli. Dodane so oblikoskladenjske oznake.

V naslednjih podpoglavjih so vse na kratko razložene spremenljivke vseh teh datotek
in direktorijev z datotekami. 
Podatki za organizacije in osebe pred letom 1990 in po letu 1992 večinoma manjkajo.

## person.csv

* persId: identifikator osebe
* name: ime in priimek osebe
* sex: spol (moški M, ženska F)
* birthYear: leto rojstva

## affiliation.csv

* persId: identifikator osebe
* orgId: identifikator organizacije
* eventId: identifikator dogodka
* role: vloga osebe v organizaciji:
  * head: vodja organizacije (npr. minister, predsednik predsedstva, predsedujoči parlametarnega zbora)
  * deputy: namestnik (npr. namestnik predsedujočega parlamentarnega zbora)
  * member: član (npr. poslanec kot član parlamentarnega zzbora)
* from: članstvo osebe v organizaciji od tega datuma. Zapisano samo v primeru, če ta oseba ni bila član te organizacije ves čas njenega obstoja (v določenem obdobju - event). Če npr. ni bil minister/poslanec ves čas mandata, v katerega je bil izvoljen/imenovan. Drugače se predvideva, da je bila ta oseba član te organizacije ves čas njenega obstoja v tem mandatu.
* to: članstvo osebe v organizaciji do tega datuma (glej predhodno obrazložitev).
* previous persId: identifikator prejšnje osebe na tem položaju v organizaciji (če je prišlo do zamenjave na sredi mandata).
* next persId: identifikator naslednje osebe na tem položaju v organizaciji (če je prišlo do zamenjave na sredi mandata).

## organization.csv

* orgId: identifikator organizacije
* name: ime organizacije
* initial: kratica organizacije – predvsem pri strankah
* type: vrsta organizacije: 
  * heade of state (predsedniška)
  * legislative (parlamentarna)
  * executive (vladna)
  * political party (politična stranka)
  * national community (italijanska ali madžarska narodnostna skupnost)
  * independet (neodvisni poslanci)
  * sociopolitical organization (družbeno-politične organizacije)
* from: obstoj organizacije od tega datuma
* to: obstoj organizacije do tega datuma
* part of orgId: identifikator organizacije katerega del je bila ta organizacija (npr. Skupščina Republike Slovenije je bila sestavljena iz treh zborov: Družbeno-politično zbor, Zbor občin in Zbor združenega dela)
* previous orgId: identifikator predhodnice te organizacije (velja predvsem za politične stranke)
* next orgId: identifikator organizacije, ki je nasledila to organizacijo

## event.csv

* eventId: identifkator dogodka v delovanju organizacije. Dogodek je npr. mandat delovanja parlamenta, vlade, predsednika.
* label: oznaka dogodka
* orgId: identifikator organizacije, na katero se dogodek navezuje
* from: začetek dogodka / mandata
* to: konec dogodka / mandata

## coalition.csv

* orgId: identifikator organizacije (v tem primeru stranka, ki je bila del vladne koalicije)
* eventId: identifikator dogodka (v tem primeru mandat vlade)

## taxonomy.csv

Vsaka tematika je bila klasificirana v skladu s taksonomijo.
Hierarhična razvrstitev taksonomije 
(primerjaj 
[http://www.pisrs.si/Pis.web/pravniRedRSDrzavniNivoKazalaTematskoKazalo](http://www.pisrs.si/Pis.web/pravniRedRSDrzavniNivoKazalaTematskoKazalo) )
na način:

* level (stopnja) 1
  * level 2
        * level 3
              * level 4
                    * level 5

Spremenjljivke:

* topicId: identifikator tematike
* topic: ime tematike, ki je klasificirana v skladu s taksonomijo
* taxonomyID level 1: identifikator 1 stopnje taksonomije v hiearhiji
* taxonomy level 1: poimenovanje prve stopnje taksonomije v hierarhiji
* taxonomyID level 2
* taxonomy level 2
* taxonomyID level 3
* taxonomy level 3
* taxonomyID level 4
* taxonomy level 4
* taxonomyID level 5
* taxonomy level 5

## title.csv

Naslovi točk dnevnega reda so bili uvrščeni v tematike.

* titleId: identifikator naslova
* title: naslov točke dnevnega reda (iz kazala vsebine)

## string/

* orgId: identifikator organizacije
* type of session: vrsta seje (seja, delovna seja, slavnostna seja, zasedanje)
* number: številka seje
* date: datum seje
* notBefore: besede niso bile spregovorjene pred tem časom. Oznaka časa notBefore in notAfter izhaja iz originalne označitve časa v virih: Označeni so bili samo začetki in konci določene debate. Zato lahko sklepamo, da so bile določene besede spregovorjene v določenem trenutko med obema skrajnima datuma.
* notAfter: besede niso bile spregovorjene po tem času
* persId: identifikator osebe
* chaiman: oseba je bila (1) ali ni bila (0) predsedujoči
* spId: identifikator govora
* nodeId: dentifikator sklopa zapisanega besedila (del spregovorjene besede, neverbalnega zapisa ipd.)
* titleId: identifikator naslova
* taxonomyIds: eden ali več identifikatorjev taksonomije (v okviru ene točke dnevnega reda so lahko obravnavali več tematik)
* topicIds: eden ali več identifikatorjev tematike
* type: tip besedila:
  * utterance: govor
  * speaker:ime in morebitni opis govornika
  * location: lokacija govornika, če le-ta ni bil za govorniškim pultom
  * date: dan poteka seje
  * time: datum in čas začetka in konca seje, skupaj z označbami prekinitev sej
  * president: predsedujoči
  * comment: komentar zapisnika oz. prepisovalca seje
  * quorum:prisotnost
  * vote: podatki o glasovanju poslancev
  * debate: komentar o vodenju debate
  * kinesic: neverbalne kretnje s spročilom
  * gap: nerazumljivi govori iz klopi (pogosteje) ali nerazumljivi deli govora glavnega govorca
  * vocal: aplavz, smeh, kričanje ipd.
  * incident: nekomunikacijski dogodki
  * kinesic: neverbalne kretnje s sporočilom
* text string: zapis znakov besedila

## lemmata/

* orgId: identifikator organizacije
* type of session: vrsta seje (seja, delovna seja, slavnostna seja, zasedanje)
* number: številka seje
* date: datum seje
* notBefore: besede niso bile spregovorjene pred tem časom. Oznaka časa notBefore in notAfter izhaja iz originalne označitve časa v virih: Označeni so bili samo začetki in konci določene debate. Zato lahko sklepamo, da so bile določene besede spregovorjene v določenem trenutko med obema skrajnima datuma.
* notAfter: besede niso bile spregovorjene po tem času
* persId: identifikator osebe
* chaiman: oseba je bila (1) ali ni bila (0) predsedujoči
* spId: identifikator govora
* uId: identifikator dela govora
* titleId: identifikator naslova
* taxonomyIds: eden ali več identifikatorjev taksonomije (v okviru ene točke dnevnega reda so lahko obravnavali več tematik)
* topicIds: eden ali več identifikatorjev tematike
* lemmata: leme vseh spregovorjenih besed dela govora z uId, med seboj ločenih s presledkom

## lemma/

* orgId: identifikator organizacije
* type of session: vrsta seje (seja, delovna seja, slavnostna seja, zasedanje)
* number: številka seje
* date: datum seje
* notBefore: besede niso bile spregovorjene pred tem časom. Oznaka časa notBefore in notAfter izhaja iz originalne označitve časa v virih: Označeni so bili samo začetki in konci določene debate. Zato lahko sklepamo, da so bile določene besede spregovorjene v določenem trenutko med obema skrajnima datuma.
* notAfter: besede niso bile spregovorjene po tem času
* persId: identifikator osebe
* chaiman: oseba je bila (1) ali ni bila (0) predsedujoči
* spId: identifikator govora
* uId: identifikator dela govora
* titleId: identifikator naslova
* taxonomyIds: eden ali več identifikatorjev taksonomije (v okviru ene točke dnevnega reda so lahko obravnavali več tematik)
* topicIds: eden ali več identifikatorjev tematike
* lemma: lema govora
* ana: oblikoskladenjska označba (glej 
[http://nl.ijs.si/ME/V5/msd/html/msd-sl.html](http://nl.ijs.si/ME/V5/msd/html/msd-sl.html) )


