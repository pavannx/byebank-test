import 'package:byebank/utils/services.dart';
import 'package:flutter/material.dart';

class Resgate extends StatefulWidget {
  // final String valor;

  // Resgate({this.valor});

  static const routeName = '/resgate';
  @override
  _ResgateState createState() => _ResgateState();
}

class _ResgateState extends State<Resgate> {
  @override
  Widget build(BuildContext context) {
    final valorController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text('Resgate'),
      ),
      body: Form(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Insira o valor que deseja resgatar',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              TextFormField(
                controller: valorController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Valor do resgate',
                ),
              ),
              Container(
                width: double.infinity,
                child: FlatButton(
                  color: Colors.blue,
                  child: Text(
                    'finalizar'.toUpperCase(),
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    MenuServices().sendResgate(
                      context,
                      DateTime.now().toString(),
                      valorController.text,
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
