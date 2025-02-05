HOST_IP="0.0.0.0"
HOST_PORT="9090"
TEST_DIR="/app/reports/allure-test"
REPORT_DIR="/app/reports/allure-report"

cd /app/repo || { echo "Failed to change directory"; exit 1; }

allure_dirs=$(find . -type d -name "allure-results")

for dir in $allure_dirs; do
  if [ -d "$dir" ]; then
    jsonFiles=$(find "$dir" -type f -name "*.json")
    for jsonFile in $jsonFiles; do
      mkdir -p "$TEST_DIR"
      cp "$jsonFile" "$TEST_DIR/$(basename "$jsonFile")"
    done
  fi
done

allure generate "$TEST_DIR" -o "$REPORT_DIR" --clean
allure open "$REPORT_DIR" -h "$HOST_IP" -p "$HOST_PORT"
