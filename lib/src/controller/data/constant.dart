const goldTableCreateQuery = '''
      $createTableQuery $goldTableName (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        barcodeText TEXT NOT NULL,
        piece INTEGER NOT NULL,
        name TEXT NOT NULL,
        carat INTEGER NOT NULL,
        purityRate DECIMAL NOT NULL,
        laborCost DECIMAL NOT NULL,
        gram DECIMAL NOT NULL,
        cost DECIMAL NOT NULL,
        salesGrams DECIMAL NOT NULL
      )
    ''';

const entriesTableCreateQuery = '''
      $createTableQuery $entriesTableName (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        product TEXT NOT NULL,
        enteredDate TEXT NOT NULL,
        piece INTEGER NOT NULL
      )
    ''';

const productSalesTableCreateQuery = '''
      $createTableQuery $salesTableName (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        product TEXT NOT NULL,
        soldDate TEXT NOT NULL,
        piece INTEGER NOT NULL,
        costPrice DECIMAL NOT NULL,
        soldPrice DECIMAL NOT NULL,
        soldGram DECIMAL NOT NULL,
        earnedProfitTL DECIMAL NOT NULL,
        earnedProfitGram DECIMAL NOT NULL
      )
    ''';
const folderName = 'databases';
const dbName = 'kuyumcu_stok_takibi.db';
const goldTableName = 'gold_products';
const entriesTableName = 'product_entries';
const salesTableName = 'product_sales';
const createTableQuery = 'CREATE TABLE IF NOT EXISTS';
