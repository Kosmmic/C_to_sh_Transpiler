#!/bin/sh

INPUT_FILE="test.c"
CLEAN_FILE="clean.tmp"
OUTPUT_FILE="program.sh"
DIAG_FILE="diagnostyka.txt"

rm -f "$CLEAN_FILE" "$OUTPUT_FILE" "$DIAG_FILE"

echo "=== URUCHAMIANIE TRANSLATORA==="

#czyszczenie komentarzy i zbednych spacji
grep -v '^[[:space:]]*//' "$INPUT_FILE" | grep -v '^[[:space:]]*$' > "$CLEAN_FILE"

echo "#!/bin/sh" > "$OUTPUT_FILE"

while read -r linia; do
	linia_bez_srednika=$(echo "$linia" | sed 's/;[[:space:]]*$//')

	case "$linia_bez_srednika" in
		int\ *)
			zmienna=$(echo "$linia_bez_srednika" | sed 's/int[[:space:]]*//; s/[[:space:]]*=[[:space:]]*/=/')
			echo "$zmienna" >> "$OUTPUT_FILE"
			;;
		printf*)
			# Szukamy tekstu po przecinku i usuwamy ewentualne spacje i nawias zamykający
			nazwa_zmiennej=$(echo "$linia_bez_srednika" | sed -n 's/.*,[[:space:]]*\([a-zA-Z0-9_]*\).*/\1/p')
			# Zostanie nam np Wartosc: %d
			czysty_tekst=$(echo "$linia_bez_srednika" | sed 's/printf("//; s/".*//')
			if [ -n "$nazwa_zmiennej" ]; then
				tekst_koncowy=$(echo "$czysty_tekst" | sed "s/%d/\$$nazwa_zmiennej/")
			else
				tekst_koncowy="$czysty_tekst"
			fi
			
			echo "echo \"$tekst_koncowy\"" >> "$OUTPUT_FILE"
			;;
		*)
			echo "BLAD: Nie mozna przetlumaczyc sekwencji: -> $linia" >> "$DIAG_FILE"
			echo "[DIAGNOSTYKA] Pominieto nieznana linie."
			;;
	esac
done < "$CLEAN_FILE"

rm -f "$CLEAN_FILE"

echo "===KONIEC PRACY==="
echo "Skrypt wynikowy: $OUTPUT_FILE"
echo "Logi diagnostyczne: $DIAG_FILE"
