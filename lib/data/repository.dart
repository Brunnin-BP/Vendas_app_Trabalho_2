import 'package:sqflite/sqflite.dart';
import '../models/produto.dart';
import '../models/venda.dart';
import 'database_helper.dart';

class Repository {
  final dbHelper = DatabaseHelper();

  Future<void> salvarProduto(Produto produto) async {
    final db = await dbHelper.database;
    await db.insert('produtos', produto.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Produto>> listarProdutos() async {
    final db = await dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('produtos');
    return List.generate(maps.length, (i) => Produto.fromMap(maps[i]));
  }

  Future<void> salvarVenda(Venda venda) async {
    final db = await dbHelper.database;
    await db.insert('vendas', venda.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Venda>> listarVendas() async {
    final db = await dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('vendas');
    return List.generate(maps.length, (i) => Venda.fromMap(maps[i]));
  }
}
