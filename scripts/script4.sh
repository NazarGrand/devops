if [ $# -ne 2 ]; then
    echo "Використання: $0 <шлях до директорії> <розширення файлів>"
    exit 1
fi

directory="$1"
extension="$2"

if [ ! -d "$directory" ]; then
    echo "Директорія '$directory
' не існує."
    exit 1
fi

count=$(find "$directory" -type f -name "*.$extension" | wc -l)

echo "Кількість файлів з розширенням .$extension в директорії '$directory': $count"