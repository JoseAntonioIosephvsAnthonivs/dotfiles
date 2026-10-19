
#!/bin/bash

# Verifica se o CopyQ está acessível
if ! copyq count >/dev/null 2>&1; then
    copyq &
    sleep 2
fi

# Monta a lista com os índices e textos do histórico
ITEMS=$(copyq eval -- '
for (var i = 0; i < size(); ++i) {
    var text = str(read(i)).replace(/\r?\n/g, " ↵ ");
    print(i + "\t" + text + "\n");
}
')

[[ -z "$ITEMS" ]] && exit 0

# Mostra o histórico no Rofi
CHOICE=$(printf '%s\n' "$ITEMS" |
    rofi -dmenu -i -p "Clipboard" -format s)

# Extrai o índice escolhido e restaura o conteúdo original
if [[ -n "$CHOICE" ]]; then
    INDEX="${CHOICE%%$'\t'*}"
    if [[ "$INDEX" =~ ^[0-9]+$ ]]; then
        copyq select "$INDEX"
    fi
fi

