import 'package:flutter/material.dart';
import 'package:sorteio/components/sorteio_app_bar.dart';
import 'package:sorteio/controller/sorteio_controller.dart';

class SorteioHome extends StatefulWidget {
  @override
  _SorteioHomeState createState() => _SorteioHomeState();
}

class _SorteioHomeState extends State<SorteioHome> {
  SorteioController sorteioController = SorteioController();
  String item = '';
  List<String> itens = [];
  var _controller = TextEditingController();

  atualizaItens() {
    setState(() {
      itens = sorteioController.itensSorteados;
    });
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text(
            'Participante sorteado',
            style: TextStyle(color: Colors.grey[800]),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  sorteioController.escolhido,
                  style: TextStyle(color: Colors.grey[500]),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Ok',
                style: TextStyle(
                  color: Color.fromRGBO(255, 43, 52, 1),
                  fontSize: 16,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color.fromRGBO(255, 43, 52, 1),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            SorteioAppBar(),
            Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, bottom: 8),
                    child: Container(
                      alignment: Alignment.bottomLeft,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 4,
                            child: Text(
                              'Sorteio',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Expanded(
                            child: IconButton(
                              iconSize: 30,
                              color: Colors.white,
                              icon: Icon(
                                Icons.refresh,
                              ),
                              onPressed: () {
                                sorteioController.limpar();
                                atualizaItens();
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(height: 20),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 5,
                          child: TextField(
                            controller: _controller,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                labelText: 'Digite algo para o sorteio'),
                            onChanged: (value) {
                              item = value;
                            },
                          ),
                        ),
                        Expanded(
                          child: IconButton(
                            iconSize: 35,
                            color: Color.fromRGBO(255, 43, 52, 1),
                            icon: Icon(
                              Icons.add,
                            ),
                            onPressed: () {
                              _controller.clear();
                              sorteioController.addItem(item);
                              atualizaItens();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                      itemCount: itens.length,
                      itemBuilder: (context, index) {
                        String item = itens[index];
                        return Card(
                          child: ListTile(
                            title: Text(item),
                            trailing: IconButton(
                              icon: Icon(
                                Icons.delete,
                                color: Color.fromRGBO(255, 43, 52, 1),
                              ),
                              onPressed: () {
                                sorteioController.deletarItem(index);
                                atualizaItens();
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width / 2,
                    child: RaisedButton(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(
                          color: Color.fromRGBO(255, 43, 52, 1),
                          width: 2,
                        ),
                      ),
                      child: Text(
                        'Sortear',
                        style: TextStyle(
                          color: Color.fromRGBO(255, 43, 52, 1),
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      onPressed: () {
                        sorteioController.sortear(itens);
                        _showMyDialog();
                      },
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
