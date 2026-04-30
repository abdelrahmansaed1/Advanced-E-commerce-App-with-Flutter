import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class WishlistDbHelpers {
  static Database? _db;
  static const String _dbName = 'ecommerce.db';
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
      version: 3,
      onCreate: _onCreate,
      onUpgrade: (db, oldVersion, newVersion) async {
        await db.execute('DROP TABLE IF EXISTS $_wishlistTable');
        await _onCreate(db, newVersion);
      },
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $_wishlistTable(
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
  }

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
    return database.query(_wishlistTable);
  }

  Future<void> clearWishlist() async {
    final database = await db;
    await database.delete(_wishlistTable);
  }
}
