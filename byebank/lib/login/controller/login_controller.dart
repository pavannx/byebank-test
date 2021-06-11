import 'dart:convert';

import 'package:byebank/login/model/login_model.dart';
import 'package:byebank/menu.dart';
import 'package:byebank/utils/shared_preferences.dart';
import 'package:byebank/utils/validate_fields.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter/material.dart';
import 'dart:io';

part 'login_controller.g.dart';

class LoginController = _LoginControllerBase with _$LoginController;

abstract class _LoginControllerBase with Store {
  LocalData prefs = LocalData();
  final LoginModel loginModel = LoginModel();
  String reply;

  bool validated = true;
  @computed
  bool get isValid {
    return validateEmail() == null &&
        loginModel.email != null &&
        validatePassword() == null &&
        loginModel.passw != null;
  }

  // function to send information to API

  sendLogin(BuildContext context) async {
    Map data = {
      'username': loginModel.email,
      'password': loginModel.passw,
    };

    Future<String> apiRequest(String url, Map jsonMap) async {
      HttpClient httpClient = new HttpClient();
      HttpClientRequest request = await httpClient.postUrl(Uri.parse(url));
      request.headers.set('content-type', 'application/json');
      request.add(utf8.encode(json.encode(jsonMap)));
      HttpClientResponse response = await request.close();
      reply = await response.transform(utf8.decoder).join();
      httpClient.close();

      if (response.statusCode == 200) {
        var userData = json.decode(reply);
        await prefs.setToken(userData['token']);
        Navigator.of(context).pushNamed(Menu.routeName);
      } else {
        final snackBar = SnackBar(
          backgroundColor: Colors.redAccent,
          duration: Duration(seconds: 2),
          content: Text('Ocorreu um erro ao fazer o login! Tente novamente.'),
          action: SnackBarAction(
            textColor: Colors.white,
            label: 'Undo',
            onPressed: () {},
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }

      return reply;
    }

    apiRequest(
      'https://mrwffgnpgf.execute-api.sa-east-1.amazonaws.com/prod/login',
      data,
    );
  }

  // validate email
  String validateEmail() {
    return ValidateFields.emailValidation(loginModel.email);
  }

  // validate password
  String validatePassword() {
    return ValidateFields.passwordValidation(loginModel.passw);
  }

  // button validations
  onPressed(BuildContext context) async {
    print('entrando');
    sendLogin(context);
  }
}
