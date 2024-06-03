import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_mvvm_learning/model/user_model.dart';
import 'package:flutter_mvvm_learning/repository/auth_repository.dart';
import 'package:flutter_mvvm_learning/utils/routes/routes_name.dart';
import 'package:flutter_mvvm_learning/utils/utils.dart';
import 'package:provider/provider.dart';

import 'user_view_model.dart';

class AuthViewModel with ChangeNotifier{

  final _myRepo=AuthRepository();

  bool _loading=false;
  bool get loading=>_loading;
  setLoading(bool value){
    _loading=value;
    notifyListeners();
  }

  bool _signupLoading=false;
  bool get signupLoading=>_signupLoading;
  setSignupLoading(bool value){
    _signupLoading=value;
    notifyListeners();
  }

  Future<void> loginApi(dynamic data, BuildContext context)async{

    setSignupLoading(true);

    _myRepo.loginApi(data).then((value)async{
      
      setSignupLoading(false);
      Utils.snackBar('Login Successful',context);
      // Provider.of<UserViewModel>(context, listen: false);

      final userPreferences=Provider.of<UserViewModel>(context,listen: false);
      UserModel user=await userPreferences.getUser();
      userPreferences.saveUser(user).then((value){
        log(value.toString());
        Utils.snackBar(value.toString(), context);
        Navigator.pushNamedAndRemoveUntil(context, RoutesName.home, (route)=>route.isCurrent);
      }).onError((error, stackTrace){
        Utils.flushbarErrorMessage(error.toString(), context);
      });
      // Navigator.pushNamedAndRemoveUntil(context, RoutesName.home, (route)=>route.isCurrent);
      // Navigator.pushNamed(context,RoutesName.home); 
      log(value.toString());
    }).onError((error, stackTrace){
      setSignupLoading(false);
      Utils.flushbarErrorMessage(error.toString(),context);
      log(error.toString());
    });
  }

  Future<void> signupApi(dynamic data, BuildContext context)async{

    setLoading(true);

    _myRepo.signupApi(data).then((value){
      setLoading(false);
      Utils.snackBar('Login(signup) Successful',context);
      Navigator.popUntil(context, (route) => route.isCurrent);
      Navigator.pushReplacementNamed(context, RoutesName.home);
      log('$value signup');
    }).onError((error, stackTrace){
      setLoading(false);
      Utils.flushbarErrorMessage(error.toString(),context);
      log(error.toString());
    });
  }
}