const sqlite3 = require('sqlite3').verbose();
const path = require('path');

const dbPath = path.resolve(__dirname, 'database.sqlite');
const db = new sqlite3.Database(dbPath);

db.all("SELECT id, name, stock, offerPrice FROM products", [], (err, rows) => {
    if (err) {
        console.error(err);
        return;
    }
    console.log("Current products stock:");
    console.table(rows);
    db.close();
});
