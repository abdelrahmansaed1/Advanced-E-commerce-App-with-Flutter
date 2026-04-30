import 'package:path/path.dart';

import 'package:sqflite/sqflite.dart';

// class CartDbHelper {
//   static final CartDbHelper _instance = CartDbHelper._internal();
//   factory CartDbHelper() => _instance;
//   CartDbHelper._internal();

//   static Database? _database;

//   Future<Database> get database async {
//     if (_database != null) return _database!;
//     _database = await _initDb();
//     return _database!;
//   }

//   Future<Database> _initDb() async {
//     final dbPath = await getDatabasesPath();
//     final path = join(dbPath, 'cart.db');

//     return await openDatabase(
//       path,
//       version: 1,
//       onCreate: (db, version) async {
//         await db.execute('''
//           CREATE TABLE cart(
//             id TEXT PRIMARY KEY,
//             name TEXT,
//             quantity INTEGER,
//             price TEXT,
//             image TEXT,
//             description TEXT
//           )
//         ''');
//       },
//     );
//   }

//   Future<void> insertItem(CartModel item) async {
//     final db = await database;
//     await db.insert(
//       'cart',
//       item.toMap(),
//       conflictAlgorithm: ConflictAlgorithm.replace,
//     );
//   }

//   Future<void> updateItem(CartModel item) async {
//     final db = await database;
//     await db.update(
//       'cart',
//       item.toMap(),
//       where: 'id = ?',
//       whereArgs: [item.id],
//     );
//   }

//   Future<void> deleteItem(String id) async {
//     final db = await database;
//     await db.delete('cart', where: 'id = ?', whereArgs: [id]);
//   }

//   Future<void> clear() async {
//     final db = await database;
//     await db.delete('cart');
//   }

//   Future<List<CartModel>> getItems() async {
//     final db = await database;
//     final maps = await db.query('cart');

//     return maps.map((e) => CartModel.fromMap(e)).toList();
//   }
// }

class CartDbHelper {
  static Database? _db;
  static const String _dbName = 'ecommerce.db';
  static const String _cartTable = 'cart';

  Future<Database> get db async {
    _db ??= await _initDb();
    return _db!;
  }

  Future<Database> _initDb() async {
    final dbpath = await getDatabasesPath();
    final path = join(dbpath, _dbName);
    return await openDatabase(
      path,
      version: 3,
      onCreate: _onCreate,
      onUpgrade: (db, oldVersion, newVersion) async {
        await db.execute('DROP TABLE IF EXISTS $_cartTable');
        await _onCreate(db, newVersion);
      },
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $_cartTable(
        productId TEXT PRIMARY KEY,
        name TEXT,
        price TEXT,
        special TEXT,
        thumbnail TEXT,
        quantity INTEGER,
        currency TEXT,
        discountPrecentage TEXT,
        selectedSize TEXT,
        selectedColor TEXT
        )
''');
  }

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
}
