import 'package:flutter/material.dart';
import 'data/repository.dart';
import 'models/produto.dart';
import 'models/venda.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final repo = Repository();

  // Teste de inserção inicial (executa só uma vez se quiser)
  await repo.salvarProduto(Produto(
    nome: 'Mouse Gamer',
    categoria: 'Periféricos',
    preco: 199.90,
    estoque: 20,
    descricao: 'Mouse RGB com 7 botões programáveis',
  ));

  await repo.salvarVenda(Venda(
    idProduto: 1,
    quantidade: 2,
    valorTotal: 399.80,
    data: DateTime.now().toIso8601String(),
    cliente: 'Brunno Brito',
  ));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Teste Sqflite',
      home: Scaffold(
        appBar: AppBar(title: const Text('Teste Sqflite')),
        body: const Center(child: Text('Veja o console para saída')),
      ),
    );
  }
}

