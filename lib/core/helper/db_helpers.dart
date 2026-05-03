// ignore_for_file: avoid_print

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  static Database? _db;
  static const String _dbName = 'ecommerce.db';
  static const String _cartTable = 'cart';
  static const String _wishlistTable = 'wishlist';

  Future<Database> get db async {
    _db ??= await _initDb();
    return _db!;
  }

  Future<Database> _initDb() async {
    final dbpath = await getDatabasesPath();
    final path = join(dbpath, _dbName);

    return await openDatabase(
      path,
      version: 8, // Increased version to force upgrade
      onCreate: _onCreate,
      onUpgrade: (db, oldVersion, newVersion) async {
        await db.execute('DROP TABLE IF EXISTS $_cartTable');
        await _onCreate(db, newVersion);
      },
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $_cartTable (
        productId TEXT PRIMARY KEY,
        name TEXT,
        price TEXT,
        special TEXT,
        thumbnail TEXT,
        quantity INTEGER DEFAULT 1,
        currency TEXT,
        discountPercentage TEXT,
        selectedSize TEXT,
        selectedColor TEXT,
        maxQuantity INTEGER DEFAULT 99
      )
    ''');
    print("Creating wishlist table...");
    await db.execute('''
      CREATE TABLE IF NOT EXISTS $_wishlistTable (
        productId TEXT PRIMARY KEY,
        name TEXT,
        price TEXT,
        special TEXT,
        thumbnail TEXT,
        currency TEXT,
        discountPercentage TEXT,
        rating TEXT,
        sku TEXT
      )
    ''');
    print("✅ Wishlist table created successfully");
  }

  // ================== CRUD Operations ==================

  Future<void> insertCartItem(Map<String, dynamic> item) async {
    final database = await db;
    await database.insert(
      _cartTable,
      item,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateCartItem(Map<String, dynamic> item) async {
    final database = await db;
    await database.update(
      _cartTable,
      item,
      where: 'productId = ?',
      whereArgs: [item['productId']],
    );
  }

  Future<void> deleteCartItem(String productId) async {
    final database = await db;
    await database.delete(
      _cartTable,
      where: 'productId = ?',
      whereArgs: [productId],
    );
  }

  Future<List<Map<String, dynamic>>> getCartItems() async {
    final database = await db;
    return await database.query(_cartTable);
  }

  Future<void> clearCart() async {
    final database = await db;
    await database.delete(_cartTable);
  }

  // ---------------- Wishlist Operations
  Future<void> insertWishlistItem(Map<String, dynamic> item) async {
    final database = await db;
    await database.insert(
      _wishlistTable,
      item,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> deleteWishlistItem(String productId) async {
    final database = await db;
    await database.delete(
      _wishlistTable,
      where: 'productId = ?',
      whereArgs: [productId],
    );
  }

  Future<List<Map<String, dynamic>>> getWishlistItems() async {
    final database = await db;
    return await database.query(_wishlistTable);
  }

  Future<void> clearWishlist() async {
    final database = await db;
    await database.delete(_wishlistTable);
  }
}
