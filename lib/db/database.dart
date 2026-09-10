import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DB {
  static Database? _db;

  static Future<Database> get db async {
    if (_db != null) return _db!;
    _db = await _init();
    return _db!;
  }

  static Future<Database> _init() async {
    final path = join(await getDatabasesPath(), 'adel_vip.db');
    return openDatabase(
      path,
      version: 1,
      onCreate: (d, v) async {
        await d.execute('''
          CREATE TABLE products(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            buy_price REAL DEFAULT 0,
            sell_price REAL DEFAULT 0,
            qty INTEGER DEFAULT 0
          )''');

        await d.execute('''
          CREATE TABLE customers(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            phone TEXT
          )''');

        await d.execute('''
          CREATE TABLE sales(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            customer_id INTEGER,
            total REAL DEFAULT 0,
            note TEXT,
            date TEXT
          )''');

        await d.execute('''
          CREATE TABLE repairs(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            customer_id INTEGER,
            device TEXT,
            problem TEXT,
            cost REAL DEFAULT 0,
            status TEXT DEFAULT 'قيد التنفيذ',
            date TEXT
          )''');

        await d.execute('''
          CREATE TABLE expenses(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT,
            amount REAL DEFAULT 0,
            type TEXT DEFAULT 'مصروف',
            date TEXT
          )''');
      },
    );
  }
}
