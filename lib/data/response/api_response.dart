
import 'status.dart';

class ApiResponse<T>{

  Status? status;
  T? data;
  String? message;

  ApiResponse(this.status,this.data,this.message);

  ApiResponse.loading():status =Status.LOADING;
  ApiResponse.completed():status =Status.COMPLETE;
  ApiResponse.error():status =Status.ERROR;

  @override
  String toString(){
    return 'satatus: $status \n Message:$message \n Data: $data';
  }
}