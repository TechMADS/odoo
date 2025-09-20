class Validators{
  static bool isEmail(String email){
    return RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email);
  }
}