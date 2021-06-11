/// class used for valitation fields and control login

class ValidateFields {
  ///validation email .
  static String emailValidation(String email) {
    ///Regex email validation.
    const String _pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    ///checking if email is valid

    if (email == null) {
      return null;
    } else if (email == '') {
      // return "Email não pode ser vazio";
    } else if (!RegExp(_pattern).hasMatch(email)) {
      return "Email inválido";
    }
    return null;
  }

  ///validation password login
  static String passwordValidation(String passw) {
    if (passw == null) {
      return null;
    } else if (passw == '') {
      return 'Senha não pode ser vazia';
    }
    return null;
  }
}
