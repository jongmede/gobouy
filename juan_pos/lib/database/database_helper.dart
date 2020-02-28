import 'dart:async';
import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import '../model/product.dart';
import 'contact.dart';
import 'transaction.dart' as _Transaction;
import '../model/category.dart';
import 'tender.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = new DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;
  static Database _db;

  Future<Database> get db async {
    if (_db != null) return _db;
    _db = await initDb();
    return _db;
  }

  DatabaseHelper.internal();

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "db21.db");
    var theDb = await openDatabase(path, version: 20, onCreate: _onCreate);
    return theDb;
  }

  void _onCreate(Database db, int version) async {
    // When creating the db, create the table
    await db.execute(
      "CREATE TABLE Product("
        "productId INTEGER PRIMARY KEY AUTOINCREMENT,"
        "productName TEXT,"
        "categoryId INTEGER,"
        "productCode TEXT,"
        "unitCost FLOAT,"
        "unitPrice FLOAT,"
        "nonVat INTEGER,"
        "vat INTEGER,"
        "scDiscount INTEGER,"
        "scDiscountPercent FLOAT,"
        "pwdDiscount INTEGER,"
        "pwdDiscountPercent FLOAT,"
        "otherDiscount INTEGER,"
        "otherDiscountPercent FLOAT,"
        "scVatExempt INTEGER,"
        "pwdVatExempt INTEGER,"
        "zeroRated INTEGER"
        ")"
    );

    await db.execute(
      "CREATE TABLE Contact("
        "contactId INTEGER PRIMARY KEY AUTOINCREMENT,"
        "contactName TEXT,"
        "address TEXT,"
        "tin TEXT,"
        "busStyle TEXT,"
        "pwId TEXT,"
        "scId TEXT"
        ")"
    );

    await db.execute(
      "CREATE TABLE Tender("
        "tenderId INTEGER PRIMARY KEY AUTOINCREMENT,"
        "ctrId INTEGER,"
        "cashPay INTEGER,"
        "cardPay INTEGER,"
        "cardType INTEGER,"
        "cardNum INTEGER,"
        "transactionRefId INTEGER,"
        "contactId INTEGER,"
        "userId INTEGER,"
        "approvalCode TEXT,"
        "amount FLOAT"
        ")"
    );

    await db.execute(
      "CREATE TABLE Transac("
        "transacId INTEGER PRIMARY KEY AUTOINCREMENT,"
        "typeDoc TEXT,"
        "number INTEGER,"
        "productId INTEGER,"
        "qty FLOAT,"
        "unitPrice FLOAT,"
        "scDiscountAmt FLOAT,"
        "pwdDiscountAmt FLOAT,"
        "otherDiscountAmt FLOAT,"
        "taxType TEXT,"
        "nonVatSales FLOAT,"
        "vatableSales FLOAT,"
        "vatAmt FLOAT,"
        "vatExemptSales FLOAT,"
        "zeroRatedSales FLOAT,"
        "customerId INTEGER"
        ")"
    );

    await db.execute(
      "CREATE TABLE Category("
      "categoryId INTEGER PRIMARY KEY AUTOINCREMENT,"
      "categoryName TEXT"
      ")"
    );

  }

  Future<int> saveProduct(Product product) async {
    var dbClient = await db;
    int res = await dbClient.insert("Product", product.toMap());
    return res;
  }

  Future<int> saveContact(Contact contact) async {
    var dbClient = await db;
    int res = await dbClient.insert("Contact", contact.toMap());
    return res;
  }

  Future<int> saveTransaction(_Transaction.Transaction transaction) async {
    var dbClient = await db;
    int res = await dbClient.insert("Transac", transaction.toMap());
    return res;
  }

  Future<int> saveTender(Tender tender) async {
    var dbClient = await db;
    int res = await dbClient.insert("Tender", tender.toMap());
    return res;
  }

  Future<int> saveCategory(Category category) async {
    var dbClient = await db;
    int res = await dbClient.insert("Category", category.toMap());
    return res;
  }

  Future<List<Product>> getProducts() async {
    var dbClient = await db;
    List<Map> list = await dbClient.rawQuery('SELECT * FROM Product');
    List<Product> products = new List();
    list.forEach((result) {
      Product product = Product.fromMap(result);
      products.add(product);
    });
    return products;
  }

  Future<List<Contact>> getContact() async {
    var dbClient = await db;
    List<Map> list = await dbClient.rawQuery('SELECT * FROM Contact');
    List<Contact> contacts = new List();
    list.forEach((result) {
      Contact contact = Contact.fromMap(result);
      contacts.add(contact);
    });
    return contacts;
  }

  Future<List<_Transaction.Transaction>> getTransaction() async {
    var dbClient = await db;
    List<Map> list = await dbClient.rawQuery('SELECT * FROM Transac');
    List<_Transaction.Transaction> transactions = new List();
    list.forEach((result) {
      _Transaction.Transaction transaction = _Transaction.Transaction.fromMap(result);
      transactions.add(transaction);
    });
    return transactions;
  }

  Future<List<Tender>> getTender() async {
    var dbClient = await db;
    List<Map> list = await dbClient.rawQuery('SELECT * FROM Tender');
    List<Tender> tenders = new List();
    list.forEach((result) {
      Tender tender = Tender.fromMap(result);
      tenders.add(tender);
    });
    return tenders;
  }

  Future<List<Category>> getCategories() async {
    var dbClient = await db;
    List<Map> list = await dbClient.rawQuery('SELECT * FROM Category ORDER BY categoryName');
    List<Category> categories = new List();
    list.forEach((result) {
      Category category = Category.fromMap(result);
      categories.add(category);
    });
    return categories;
  }

  Future<int> deleteProduct(Product product) async {
    var dbClient = await db;

    int res =
    await dbClient.rawDelete('DELETE FROM Product WHERE productId = ?', [product.productId]);
    return res;
  }

  Future<int> deleteContact(Contact contact) async {
    var dbClient = await db;

    int res =
    await dbClient.rawDelete('DELETE FROM Contact WHERE contactId = ?', [contact.contactId]);
    return res;
  }

  Future<int> deleteTransaction(_Transaction.Transaction transaction) async {
    var dbClient = await db;

    int res =
    await dbClient.rawDelete('DELETE FROM Transaction WHERE id = ?', [transaction.transactionId]);
    return res;
  }

  Future<int> deleteCategory(Category category) async {
    var dbClient = await db;

    int res =
    await dbClient.rawDelete('DELETE FROM Category WHERE categoryId = ?', [category.categoryId]);
    return res;
  }

  Future<bool> updateProduct(Product product) async {
    var dbClient = await db;
    int res = await dbClient.update("Product", product.toMap(), where: "productId = ?", whereArgs: <int>[product.productId]);
    return res > 0 ? true : false;
  }

  Future<bool> updateContact(Contact contact) async {
    var dbClient = await db;
    int res =   await dbClient.update("Contact", contact.toMap(),
        where: "contactId = ?", whereArgs: <int>[contact.contactId]);
    return res > 0 ? true : false;
  }

  Future<bool> updateTransaction(_Transaction.Transaction transaction) async {
    var dbClient = await db;
    int res =   await dbClient.update("Transaction", transaction.toMap(),
        where: "id = ?", whereArgs: <int>[transaction.transactionId]);
    return res > 0 ? true : false;
  }

  Future<bool> updateCategory(Category c) async {
    var dbClient = await db;
    int res =   await dbClient.update('Category', c.toMap(), where: 'categoryId = ?', whereArgs: <int>[c.categoryId]);
    return res > 0 ? true : false;
  }
}