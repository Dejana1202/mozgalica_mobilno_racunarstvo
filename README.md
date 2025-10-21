# Mozgalica – flutter aplikacija

**Mozgalica** je Android aplikacija, koja predstavlja zbirku logičkih igara. Trenutno aplikacija sadrži tri različite igre: 
**Memory Match**, **Tic-Tac-Toe** i **MathQuiz**. 
Svaka igra ima jasno definisana pravila, interfejs i sistem bodovanja, a rezultati se čuvaju u lokalnoj **SQLite** bazi podataka.

## Funkcionalnosti

- Korisnici učestvuju u igrama koristeći jedinstveno korisničko ime.
- Pregled istorije rezultata sa mogućnošću filtriranja po:
  - korisničkom imenu
  - nazivu igre
- Detaljan prikaz pravila, bodovanja i dodatnih informacija za svaku igru.
- Podešavanja jezika aplikacije (**srpski** ili **engleski**).

## Tehničke karakteristike

- Sve operacije, koje mogu blokirati glavnu nit realizovane su asinhrono radi boljih performansi.
- GUI je dizajniran prema **Material Design** principima, minimalistički i responzivan za različite dimenzije i gustine ekrana.
