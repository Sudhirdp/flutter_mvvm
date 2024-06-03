import 'package:flutter/material.dart';
import 'package:flutter_mvvm_learning/utils/routes/routes_name.dart';
import 'package:flutter_mvvm_learning/utils/utils.dart';

import '../user_view_model.dart';
import '../../model/user_model.dart';

class SplashServices{

  Future<UserModel> getUserData()=> UserViewModel().getUser();
  
  void checkAuthentication(BuildContext context) async{
    getUserData().then((value)async{
      // UserModel usermod=value;
      Utils.flushbarErrorMessage(value.token.toString(), context);
      
      if(value.token=='null' || value.token=='' || value.token==null){
        await Future.delayed(const Duration(seconds: 3));
        Navigator.pushReplacementNamed(context, RoutesName.login);
      }else{
        await Future.delayed(const Duration(seconds: 3));
        Navigator.pushReplacementNamed(context, RoutesName.home);
      }
    }).onError((error, stackTrace){

    });
  }
  
}