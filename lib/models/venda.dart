class Venda {
  int? id;
  int idProduto;
  int quantidade;
  double valorTotal;
  String data;
  String cliente;

  Venda({
    this.id,
    required this.idProduto,
    required this.quantidade,
    required this.valorTotal,
    required this.data,
    required this.cliente,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'idProduto': idProduto,
      'quantidade': quantidade,
      'valorTotal': valorTotal,
      'data': data,
      'cliente': cliente,
    };
  }

  factory Venda.fromMap(Map<String, dynamic> map) {
    return Venda(
      id: map['id'] as int?,
      idProduto: map['idProduto'] as int,
      quantidade: map['quantidade'] as int,
      valorTotal: (map['valorTotal'] as num).toDouble(),
      data: map['data'] as String,
      cliente: map['cliente'] as String,
    );
  }
}
