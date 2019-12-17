class Validation {


  static isPassValid(String pass) {
    return pass.length >= 6;
  }


  static isEmailValid(String email) {
    final regexEmail = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return regexEmail.hasMatch(email);
  }
}
