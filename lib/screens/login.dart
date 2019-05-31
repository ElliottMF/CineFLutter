import 'package:cineproyecto/commons/httphandler.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home.dart';




class Login extends StatefulWidget {
  @override
  _LoginState createState() => new _LoginState();
 }
class _LoginState extends State<Login> {

  TextEditingController usuarioControlador = new TextEditingController(); //para saber que escribes
  TextEditingController contrasenaControlador = new TextEditingController();

  
  final GlobalKey<ScaffoldState> _globalKey = new GlobalKey();

  @override
  Widget build(BuildContext context) {
   return new Scaffold(
     key: _globalKey,
     body: SingleChildScrollView(    //scroll 
      child: Container(
     padding: EdgeInsets.only(
       left: 18,
       right: 18,
       top: 60,
     ),

     height: MediaQuery.of(context).size.height, //para que tome todo el alto de la aplicacion 
     
     decoration: BoxDecoration(
       gradient: LinearGradient(   //degradado
         colors: [
           Colors.red,
           Colors.red,
           Colors.yellow,
         ],
         begin: FractionalOffset.topCenter, 
         end:  FractionalOffset.bottomCenter,
         tileMode: TileMode.clamp

       ),
     ),

    child: Column(
      children: <Widget>[
        CircleAvatar(
          backgroundColor: Colors.white,
          child:    Image.asset('assets/images/Palomitas.png'),
          radius: 110,
        ), 
        SizedBox(height: 30,), //espacio entre logo es una caja 
        TextFormField(
          controller: usuarioControlador,
          decoration: InputDecoration(
          labelText: 'Usuario',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.horizontal(
              left: Radius.circular(15),
              right: Radius.circular(15)
            )
          )
          ),
        ),
        SizedBox(height: 30,), //espacio
        TextFormField(
          obscureText: true,
          controller: contrasenaControlador,
           decoration: InputDecoration(
          labelText: 'Contraseña',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.horizontal(
              left: Radius.circular(15),
              right: Radius.circular(15)
            )
          )
          ),
         
        ),
      SizedBox(height: 30,),
      ButtonTheme(
        minWidth: double.infinity,  //ancho del boton
        height: 50,
        child: MaterialButton(
          onPressed: () => _login(),
          color: Colors.orange,
          child: Text(
            'Inicion Sesión',
            style: TextStyle(color:Colors.white),
          ),
        ),
      )
      ],
      

    )
   ),
     )
   );
  }
  _login() async {
    bool statusOK = await HttpHandler().getLogin(usuarioControlador.text,contrasenaControlador.text);


    if(statusOK){
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setBool('session', true); //llave
      Navigator.of(context).pushAndRemoveUntil(  //llamo a la otra pantalla  pero no lo deja regresar el untill
        MaterialPageRoute(builder: (constext) => Home()),
        (Route<dynamic> rote )=> false
      ); 



    }
    else
      _showSnackBar('Usuario y contraseña incorrectos pri'); 

  }
  _showSnackBar(String text){
      final snackBar = new SnackBar(
        content: Text(text),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.redAccent,
      );
      _globalKey.currentState.showSnackBar(snackBar);
    }
}