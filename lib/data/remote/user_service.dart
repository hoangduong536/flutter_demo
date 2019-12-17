

import 'package:flutter_app/shared/api_method_name.dart';
import 'package:flutter_app/shared/constant.dart';
import 'package:flutter_app/shared/model/user_data.dart';

class UserService {



  UserData signIn(String email,String pass)
  {
      if(email == Constanst.EMAIL && pass == Constanst.PASSWORD) {
        return UserData(email: Constanst.EMAIL,displayName: Constanst.DISPLAY_NAME);
      }else {
        return null;
      }
  }



}