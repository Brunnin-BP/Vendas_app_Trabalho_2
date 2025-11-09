import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDb();
    return _db!;
  }

  Future<Database> _initDb() async {
    // Inicializa o sqflite_common_ffi para uso no Windows/Desktop
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;

    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'loja.db');

    return await databaseFactory.openDatabase(
      path,
      options: OpenDatabaseOptions(
        version: 4, // ✅ aumente a versão sempre que mudar as tabelas
        onCreate: _onCreate,
        onUpgrade: _onUpgrade,
      ),
    );
  }

  // ✅ Criação das tabelas
  Future<void> _onCreate(Database db, int version) async {
    // Tabela de produtos
    await db.execute('''
      CREATE TABLE produtos (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT,
        categoria TEXT,
        preco REAL,
        estoque INTEGER,
        descricao TEXT
      )
    ''');

    // Tabela de vendas
    await db.execute('''
      CREATE TABLE vendas (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        idProduto INTEGER,
        quantidade INTEGER,
        valorTotal REAL,
        data TEXT,
        cliente TEXT,
        FOREIGN KEY (idProduto) REFERENCES produtos (id)
      )
    ''');
  }

  // ✅ Atualiza o banco se já existir uma versão anterior
  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 4) {
      // Remove tabelas antigas e recria tudo
      await db.execute('DROP TABLE IF EXISTS vendas');
      await db.execute('DROP TABLE IF EXISTS produtos');
      await _onCreate(db, newVersion);
    }
  }

  // ✅ Métodos para produtos
  Future<int> inserirProduto(Map<String, dynamic> produto) async {
    final db = await database;
    return await db.insert('produtos', produto);
  }

  Future<List<Map<String, dynamic>>> listarProdutos() async {
    final db = await database;
    return await db.query('produtos');
  }

  Future<int> deletarProduto(int id) async {
    final db = await database;
    return await db.delete('produtos', where: 'id = ?', whereArgs: [id]);
  }

  // ✅ Métodos para vendas
  Future<int> inserirVenda(Map<String, dynamic> venda) async {
    final db = await database;
    return await db.insert('vendas', venda);
  }

  Future<List<Map<String, dynamic>>> listarVendas() async {
    final db = await database;
    return await db.query('vendas');
  }

  Future<int> deletarVenda(int id) async {
    final db = await database;
    return await db.delete('vendas', where: 'id = ?', whereArgs: [id]);
  }
}
