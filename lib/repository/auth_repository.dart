import 'package:flutter_mvvm_learning/data/network/base_api_services.dart';
import 'package:flutter_mvvm_learning/data/network/network_api_services.dart';
import 'package:flutter_mvvm_learning/res/app_url.dart';

class AuthRepository{
  final BaseApiServices _apiServices=NetworkApiServices();

  Future<dynamic> loginApi(dynamic data)async{
    try{
      dynamic response = await _apiServices.getPostApiResponse(AppUrl.loginEndpoint,data);
      return response; 
    }catch(e){
      rethrow;
    }
  }

  Future<dynamic> signupApi(dynamic data)async{
    try{
      dynamic response = await _apiServices.getPostApiResponse(AppUrl.registerEndpoint,data);
      return response; 
    }catch(e){
      rethrow;
    }
  }
}