// import 'package:flutter/material.dart';
// import 'package:mobile/models/user.dart';
// import 'package:mobile/services/auth_service.dart';
// import 'package:mobile/storage/token_storage.dart';
//  class AuthProvider with ChangeNotifier{
//    User? _user;

//    User? get user => _user;

//    Future<void> login(String email, String password) async{
//      _user = await AuthService().login(email, password);
//      final token = _user?.token;
//      await TokenStorage.saveToken(token!);
//      _user = User.fromJson(_user?.username as Map<String, dynamic>);
//      notifyListeners();
//    }
//  }