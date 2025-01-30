HOST_IP="0.0.0.0"  # IP внутри контейнера
HOST_PORT="9090"  # Порт внутри контейнера

TEST_DIR="/app/reports/allure-test"
REPORT_DIR="/app/reports/allure-report"

# Переходим в рабочую директорию
cd /app/repo || { echo "Failed to change directory"; exit 1; }

# Находим все директории allure-results по всему проекту
allure_dirs=$(find . -type d -name "allure-results")

# Копируем все .json файлы в директорию отчётов
for dir in $allure_dirs; do
  if [ -d "$dir" ]; then
    jsonFiles=$(find "$dir" -type f -name "*.json")
    for jsonFile in $jsonFiles; do
      mkdir -p "$TEST_DIR"
      cp "$jsonFile" "$TEST_DIR/$(basename "$jsonFile")"
    done
  fi
done

# Генерация отчета с очисткой целевой директории
allure generate "$TEST_DIR" -o "$REPORT_DIR" --clean

# Открытие отчета
allure open "$REPORT_DIR" -h "$HOST_IP" -p "$HOST_PORT"
