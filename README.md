
## 🗺️ Master Project Roadmap: Traject Rekenmachine & Competitie Data Systeem

## 🔄 Deel 1: De Rekenmachine als Architectuur Blauwdruk (Fase 1 t/m 5)
We doorlopen eerst het volledige proces met de rekenmachine om de complete infrastructuur, distributie en beveiliging foutloos op te zetten.

## 🟢 Fase 1: De Basis (Proof of Concept)

* Stap 1: Calculator Front-end Bouwen 
* Wat: De gebruikersinterface (UI) ontwerpen in RAD Studio (knoppen, scherm en lay-out).
* Stap 2: Calculator Backend Bouwen 
* Wat: De rekenlogica, variabelen en foutafhandeling lokaal in Delphi programmeren.

## 🔵 Fase 2: Cloud & Integratie 

* Stap 3: Calculator Webservice (API) & Database Bouwen — [IN UITVOERING]
* Wat: De rekenlogica verplaatsen naar een externe server. De Delphi-app stuurt de getallen naar de API; de API berekent de uitkomst en slaat de transactie op in een centrale database.

## 🟡 Fase 3: Hardware & Beveiliging

* Stap 4: Calculator installeren op een iPad en een Android Tablet
* Wat: De interface compileren via FireMonkey (FMX) en fysiek testen op mobiele hardware.
* Stap 5: Calculator Authenticatie & Autorisatie Bouwen
* Wat: Gebruikersbeheer en rollen inbouwen zodat alleen geautoriseerde gebruikers verbinding kunnen maken met de reken-API.

## 🟠 Fase 4: Stabiliteit & Productie

* Stap 6: Calculator Connection Redundantie Inbouwen
* Wat: Een offline modus inbouwen; als internet wegvalt, moet de app lokaal blijven rekenen of invoer cachen.
* Stap 7: Calculator Log Systeem Inbouwen
* Wat: Het tracken van alle API-verzoeken, errors en database-transacties voor monitoring.

## 🔴 Fase 5: Lancering & Oplevering

* Stap 8: Calculator Fire Sale
* Wat: Een live stresstest uitvoeren waarbij honderden berekeningen tegelijkertijd naar de API worden afgevuurd om de stabiliteit te testen.
* Stap 9: Calculator Documentatie
* Wat: Het opleveren van de volledige code- en API-documentatie van de rekenmachine.

------------------------------
## 🚀 Deel 2: De Switch naar het Competitie Data Systeem
Zodra de infrastructuur van de rekenmachine perfect werkt en is gedocumenteerd (Stap 1 t/m 9), kopiëren we deze bewezen architectuur. We vervangen de rekenknopjes door sportdata.

* De Switch-fase:
* Front-end: De cijferknoppen van de rekenmachine worden vervangen door invoervelden voor teams en setstanden.
   * API & Database: In plaats van Getal1 + Getal2 = Resultaat stuurt de app nu Team A + Setstanden = Competitiestand. De API berekent de ranglijst en de database slaat de sportresultaten op.
   * Direct klaar voor Enterprise: Omdat de mobiele uitrol (Stap 4), security (Stap 5), offline modus (Stap 6) en logs (Stap 7) al zijn ontwikkeld en getest voor de rekenmachine, kan het Competitie Data Systeem hier direct gebruik van maken.

------------------------------

