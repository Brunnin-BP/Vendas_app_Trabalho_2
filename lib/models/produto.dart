class Produto {
  int? id;
  String nome;
  String categoria;
  double preco;
  int estoque;
  String descricao;

  Produto({
    this.id,
    required this.nome,
    required this.categoria,
    required this.preco,
    required this.estoque,
    required this.descricao,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'categoria': categoria,
      'preco': preco,
      'estoque': estoque,
      'descricao': descricao,
    };
  }

  factory Produto.fromMap(Map<String, dynamic> map) {
    return Produto(
      id: map['id'] as int?,
      nome: map['nome'] as String,
      categoria: map['categoria'] as String,
      preco: (map['preco'] as num).toDouble(),
      estoque: map['estoque'] as int,
      descricao: map['descricao'] as String,
    );
  }
}
