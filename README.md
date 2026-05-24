# Translator kodu źródłowego z języka C do skryptu powłoki (sh)

## Opis projektu
Projekt realizuje zadanie transpilacji (tłumaczenia źródło-do-źródła) prostych programów napisanych w języku C do skryptów powłoki zgodnych ze standardem POSIX sh. Program został w całości napisany w języku powłoki sh i opiera się na przetwarzaniu potokowym oraz operacjach na plikach tekstowych. Narzędzie automatycznie analizuje strukturę wejściową, mapuje konstrukcje składniowe C na ich odpowiedniki systemowe oraz prowadzi pełną diagnostykę błędów dla sekwencji nieobsługiwanych.

## Funkcjonalności projektu
* Preprocesor tekstu: Automatyczne oczyszczanie kodu źródłowego z komentarzy jednoliniowych (//) oraz usuwanie nadmiarowych pustych linii.
* Translacja deklaracji zmiennych: Konwersja statycznych deklaracji języka C (np. int x = 5;) na dynamiczne przypisania powłoki (x=5) z zachowaniem restrykcyjnych reguł dotyczących spacji wokół operatora przypisania.
* Zaawansowana konwersja funkcji printf: Wyciąganie nazw zmiennych oraz tekstu formatującego za pomocą grup przechwytujących w narzędziu sed, a następnie mapowanie maski %d na natywne odczytywanie wartości zmiennej ($nazwa) w poleceniu echo.
* Autonomiczny moduł diagnostyczny: Wykrywanie konstrukcji wykraczających poza zdefiniowany zakres projektu (np. pętli, instrukcji warunkowych) i zapisywanie ich do zewnętrznego rejestru błędów wraz z pominięciem w pliku wynikowym.
* Generowanie wykonywalnych skryptów systemowych: Plik wyjściowy automatycznie otrzymuje nagłówek środowiskowy #!/bin/sh, co pozwala na jego bezpośrednie uruchomienie w systemie po nadaniu uprawnień.

## Czego się nauczyłem podczas realizacji projektu
* Strumieniowego przetwarzania tekstu: Praktyczne opanowanie potoków (pipe) oraz narzędzi grep i sed do filtrowania i modyfikacji danych w locie.
* Wyrażeń regularnych (Regex): Wykorzystanie zaawansowanych mechanizmów, takich jak klasy znaków standardu POSIX ([[:space:]]) oraz grup przechwytujących do izolowania fragmentów tekstu.

## Instrukcja uruchomienia krok po kroku

Wszystkie kroki należy wykonać w terminalu systemowym systemu operacyjnego ChromeOS/Linux.

1. Edytuj plik wejściowy z kodem C o nazwie `test.c` przy użyciu edytora tekstowego:

         nano test.c
 
    przykładowy kod z pliku test.c:

        int licznik = 10;
        printf("Wartosc licznika to %d", licznik);
        for(int i=0; i<5; i++) {}

        
    Zapisz plik i wyjdź z edytora.

2. Nadaj uprawnienia wykonywalności dla głównego skryptu translatora:
    
        chmod +x translator.sh

3. Uruchom proces translacji kodu:
   
        ./translator.sh

4. Zweryfikuj wygenerowane pliki:

   * Aby zobaczyć przetłumaczony kod sh:
        
            cat program.sh
   * Aby zobaczyć linie, które nie zostały obsłużone (np. pętla for):
    
            cat diagnostyka.txt

5. Nadaj uprawnienia wykonywalności dla nowo powstałego skryptu:
   
        chmod +x program.sh

6. Uruchom przetłumaczony program, aby zobaczyć wynik jego działania:
   
        ./program.sh
