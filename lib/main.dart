import 'package:cineproyecto/screens/home.dart';
import 'package:flutter/material.dart';
import 'screens/login.dart';  //aqui
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState(
  
  );
 }

//este metodo es el que decide donde va a ir 
Future<bool> getSession()async{//el future es espera a que cargue lo de mas y luego lo hace

  bool loginActivo = false;
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.getBool('session') == null || preferences.getBool('session')== false? loginActivo = false: loginActivo = true;
  return loginActivo;
}  

class _MyAppState extends State<MyApp> {
  bool session;

   @override
   void initState(){  //carga todo el get session 
     super.initState();
     getSession().then(updateSession);
   }

   @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.orange,
        primarySwatch: Colors.blue,
      ),
      home: session ? Home() : Login()
    );
  }
  void updateSession(bool session){
    setState(() { //cambia el estado de algo eje de la app
     this.session = session; 
     print(this.session);
    });
  }
}
