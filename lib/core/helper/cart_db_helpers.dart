import 'package:e_commerce_project/features/screens/cart/model/cart_model.dart';
import 'package:path/path.dart';

import 'package:sqflite/sqflite.dart';

class CartDbHelper {
  static final CartDbHelper _instance = CartDbHelper._internal();
  factory CartDbHelper() => _instance;
  CartDbHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDb();
    return _database!;
  }

  Future<Database> _initDb() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'cart.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE cart(
            id TEXT PRIMARY KEY,
            name TEXT,
            quantity INTEGER,
            price TEXT,
            image TEXT,
            description TEXT
          )
        ''');
      },
    );
  }

  Future<void> insertItem(CartModel item) async {
    final db = await database;
    await db.insert(
      'cart',
      item.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateItem(CartModel item) async {
    final db = await database;
    await db.update(
      'cart',
      item.toMap(),
      where: 'id = ?',
      whereArgs: [item.id],
    );
  }

  Future<void> deleteItem(String id) async {
    final db = await database;
    await db.delete('cart', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> clear() async {
    final db = await database;
    await db.delete('cart');
  }

  Future<List<CartModel>> getItems() async {
    final db = await database;
    final maps = await db.query('cart');

    return maps.map((e) => CartModel.fromMap(e)).toList();
  }
}
