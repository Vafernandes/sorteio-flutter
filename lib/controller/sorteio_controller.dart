import 'dart:math';

class SorteioController {
  List<String> itensSorteados = [];
  String escolhido = '';

  void addItem(String item) {
    itensSorteados.add(item);
  }

  String sortear(List<String> itens) {
    if (itens.isEmpty || itens == null) {
      escolhido = 'Primeiro informe alguém para ser sorteado!';
    } else {
      Random random = Random();

      int resultado = random.nextInt(itens.length);
      for (var i = 0; i < itens.length; i++) {
        if (i == resultado) escolhido = itens[i];
      }
    }
    return escolhido;
  }

  void deletarItem(int item) {
    for (var i = 0; i < itensSorteados.length; i++) {
      if (i == item) itensSorteados.removeAt(item);
    }
  }

  void limpar() {
    itensSorteados = [];
  }
}
