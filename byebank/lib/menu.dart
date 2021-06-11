import 'package:byebank/login/login_screen.dart';
import 'package:byebank/resgate.dart';
import 'package:byebank/utils/services.dart';
import 'package:byebank/utils/shared_preferences.dart';
import 'package:flutter/material.dart';

class Menu extends StatefulWidget {
  static const routeName = '/menu';

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  final dataStyle = TextStyle(fontWeight: FontWeight.w500, fontSize: 18);
  final dataValor =
      TextStyle(fontWeight: FontWeight.w500, fontSize: 18, color: Colors.white);
  dynamic dataValues;
  double saldo;
  var totalAplicacao;
  var totalResgate;
  List resgate = [];
  List aplicacao = [];
  List aplicacaoValor = [];
  List resgateValor = [];

  accessData() {
    MenuServices().getData().then(
      (data) {
        setState(() {
          dataValues = data;

          aplicacao = data.where((x) => x['tipo'] == 'aplicacao').toList();
          resgate = data.where((x) => x['tipo'] == 'resgate').toList();

          for (var i = 0; i < data.length; i++) {
            var elementoAtual = data[i]['valor'];
            var tipo = data[i]['tipo'];

            if (tipo == "aplicacao") {
              aplicacaoValor.add(elementoAtual);
              totalAplicacao =
                  aplicacaoValor.reduce((value, element) => value + element);
            } else if (tipo == "resgate") {
              resgateValor.add(elementoAtual);
              totalResgate =
                  resgateValor.reduce((value, element) => value + element);
            }
          }

          print(totalAplicacao);
          print(totalResgate);
          saldo = (totalAplicacao - totalResgate);
          saldo.toStringAsFixed(2);
          print(saldo);
        });
      },
    );
  }

  @override
  void initState() {
    accessData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.black,
          actions: [
            IconButton(
              icon: Icon(Icons.exit_to_app, color: Colors.white),
              onPressed: () async {
                LocalData prefs = LocalData();
                await prefs.clearAll();
                Navigator.of(context)
                    .pushReplacementNamed(LoginScreen.routeName);
              },
            ),
          ],
          title: Text(
            'saldo: '.toUpperCase() + saldo.toStringAsFixed(2),
            style: dataValor,
            textAlign: TextAlign.left,
          ),
          automaticallyImplyLeading: false,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ExpansionTile(
                  title: Text(
                    'Aplicações',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  children: [
                    Container(
                      height: 200,
                      margin: EdgeInsets.only(
                        top: 10,
                      ),
                      child: ListView.builder(
                        itemCount: aplicacao.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  aplicacao[index]['tipo'],
                                  style: dataStyle,
                                  textAlign: TextAlign.left,
                                ),
                                Text(
                                  aplicacao[index]['data'],
                                  style: dataStyle,
                                  textAlign: TextAlign.left,
                                ),
                                Text(
                                  aplicacao[index]['valor'].toStringAsFixed(2),
                                  style: dataStyle,
                                  textAlign: TextAlign.left,
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: 20, bottom: 10),
                  color: Colors.black,
                  width: double.infinity,
                  child: FlatButton(
                    onPressed: () {},
                    child: Text(
                      'Fazer nova aplicação',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                ExpansionTile(
                  title: Text(
                    'Resgates',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  children: [
                    Container(
                      height: 200,
                      margin: EdgeInsets.only(top: 10),
                      child: ListView.builder(
                        itemCount: resgate.length,
                        itemBuilder: (context, index) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                resgate[index]['tipo'],
                                style: dataStyle,
                                textAlign: TextAlign.left,
                              ),
                              Text(
                                resgate[index]['data'],
                                style: dataStyle,
                                textAlign: TextAlign.left,
                              ),
                              Text(
                                resgate[index]['valor'].toString(),
                                style: dataStyle,
                                textAlign: TextAlign.left,
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
                Container(
                  color: Colors.black,
                  margin: EdgeInsets.only(top: 20),
                  width: double.infinity,
                  child: FlatButton(
                    onPressed: () {},
                    child: Text(
                      'Fazer novo resgate',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
