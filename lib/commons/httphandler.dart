import 'package:http/http.dart' as http;
import 'dart:async';

class HttpHandler{

  Future<bool> getLogin(username, password) async{

    http.Response response = await http.get('http://192.168.43.28:8080/WSAPPCINE/apirest/WSUsuario/validacion/$username/$password');
     Map<String, dynamic> map = response.headers;
    print('Berrer: ${response.headers}');
    print(response.statusCode);
    if(response.statusCode == 200)
      return true;
    else
      return false;

  }
}