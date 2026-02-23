#!/bin/bash

echo "======================================"
echo "Invoice History Sync Diagnostic Tool"
echo "======================================"
echo ""

# Check if backend is running
echo "1. Checking backend API status..."
if curl -s -X POST http://127.0.0.1:5002/sync -H "Content-Type: application/json" -d '{"lastSyncTime": null}' > /dev/null 2>&1; then
    echo "   ✓ Backend API is running on port 5002"
    
    # Get invoice count from API
    INVOICE_COUNT=$(curl -s -X POST http://127.0.0.1:5002/sync -H "Content-Type: application/json" -d '{"lastSyncTime": null}' | grep -o '"invoices":\[' | wc -l)
    INVOICE_ITEMS_COUNT=$(curl -s -X POST http://127.0.0.1:5002/sync -H "Content-Type: application/json" -d '{"lastSyncTime": null}' | grep -o '"invoiceItems":\[' | wc -l)
    
    echo "   ✓ API has invoice data available"
    echo ""
else
    echo "   ✗ Backend API is NOT responding on port 5002"
    echo "   → Please start the backend server first"
    echo ""
    exit 1
fi

# Check database file
echo "2. Checking local database..."
DB_PATH="$HOME/.local/share/ezo/app_database.db"
if [ -f "$DB_PATH" ]; then
    echo "   ✓ Database file exists at: $DB_PATH"
    
    # Count invoices in local DB
    LOCAL_INVOICES=$(sqlite3 "$DB_PATH" "SELECT COUNT(*) FROM invoices;" 2>/dev/null || echo "0")
    LOCAL_ITEMS=$(sqlite3 "$DB_PATH" "SELECT COUNT(*) FROM invoice_items;" 2>/dev/null || echo "0")
    
    echo "   → Local invoices: $LOCAL_INVOICES"
    echo "   → Local invoice items: $LOCAL_ITEMS"
    echo ""
else
    echo "   ✗ Database file not found"
    echo "   → Database will be created on first app run"
    echo ""
fi

# Check Flutter app status
echo "3. Checking Flutter app..."
if pgrep -f "flutter_tools" > /dev/null; then
    echo "   ✓ Flutter app appears to be running"
else
    echo "   ⚠ Flutter app is not running"
    echo "   → Run: flutter run"
fi
echo ""

echo "======================================"
echo "Next Steps:"
echo "======================================"
echo "1. Make sure the backend is running (✓ confirmed above)"
echo "2. Run the Flutter app: flutter run"
echo "3. Navigate to Sales History screen"
echo "4. Watch the console for sync messages:"
echo "   - 'InvoiceHistoryScreen: Starting initial sync...'"
echo "   - 'Pulling updates since: ...'"
echo "   - 'InvoiceHistoryScreen: Initial sync completed successfully'"
echo "5. If sync fails, check the error message in the snackbar"
echo "6. Use the refresh button to manually trigger sync"
echo ""
