
import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_app/data/remote/user_service.dart';
import 'package:flutter_app/shared/model/rest_error.dart';
import 'package:flutter_app/shared/model/user_data.dart';

class UserRepo {
  UserService _userService;


  UserRepo({@required UserService userService}) : _userService = userService;

  Future<UserData> signIn(String email, String pass) async
  {
    var c = Completer<UserData>();

      var response =  _userService.signIn(email, pass);
      if(response != null ) {
        var userData = UserData.fromData(response.email,response.displayName);
        c.complete(userData);
      }else {
        var msgErr = "Đăng nhập thất bại\nEmail/Password không đúng";
        print("UserRepo Dio Err: " + msgErr);
        RestError error = RestError.fromData(msgErr);
        c.completeError(error);
      }

    return c.future;
  }


}