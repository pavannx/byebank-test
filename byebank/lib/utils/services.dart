import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:byebank/utils/shared_preferences.dart';

class MenuServices {
  LocalData prefs = LocalData();
  getData() async {
    String token = await prefs.getToken();
    Map<String, String> headers = Map<String, String>();
    headers['authorization'] = token;
    headers['content-type'] = 'application/json';
    var resp = await http.get(
        'https://mrwffgnpgf.execute-api.sa-east-1.amazonaws.com/prod/movimentacoes',
        headers: headers);

    if (resp.statusCode == 200) {
      var data = json.decode(resp.body);
      return data['movimentacoes'];
    }
  }

  sendAplicacao(String date, String valor) async {
    String token = await prefs.getToken();
    Map<String, String> headers = Map<String, String>();
    headers['authorization'] = token;
    headers['content-type'] = 'application/json';

    Map data = {
      "data": date,
      "valor": valor,
    };

    var body = json.encode(data);

    var resp = await http.put(
      'https://mrwffgnpgf.execute-api.sa-east-1.amazonaws.com/prod/aplicacao',
      headers: headers,
      body: body,
    );

    print(resp.statusCode);
    print(resp.body);
    if (resp.statusCode == 200) {
      // var data = json.decode(resp.body);
      // return data['movimentacoes'];
    }
  }

  sendResgate(BuildContext context, String date, String valor) async {
    String token = await prefs.getToken();
    Map<String, String> headers = Map<String, String>();
    headers['authorization'] = token;
    headers['content-type'] = 'application/json';

    Map data = {
      'data': date,
      'valor': valor,
    };
    var body = json.encode(data);

    var resp = await http.put(
      'https://mrwffgnpgf.execute-api.sa-east-1.amazonaws.com/prod/resgate',
      headers: headers,
      body: body,
    );

    print(resp.statusCode);
    print(resp.body);
    if (resp.statusCode == 200) {
      // var data = json.decode(resp.body);
      // return data['movimentacoes'];
    }
  }
}
