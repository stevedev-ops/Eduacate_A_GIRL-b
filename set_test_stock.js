const sqlite3 = require('sqlite3').verbose();
const path = require('path');

const dbPath = path.resolve(__dirname, 'database.sqlite');
const db = new sqlite3.Database(dbPath);

// Set Brass Pendant Necklace (p3) to 0 stock
db.run("UPDATE products SET stock = 0 WHERE id = 'p3'", [], (err) => {
    if (err) {
        console.error(err);
        return;
    }
    console.log("Updated p3 stock to 0");

    // Verify
    db.all("SELECT id, name, stock FROM products", [], (err, rows) => {
        if (err) {
            console.error(err);
            return;
        }
        console.log("\nUpdated products stock:");
        console.table(rows);
        db.close();
    });
});
