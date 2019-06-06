import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cineproyecto/screens/login.dart';
import 'package:cineproyecto/screens/home.dart';



/**
 * async -> crea funciones asyncronas
 * Future -> Indica que será un método que espera una respuesta en un futuro
 * En este caso, esperaremos una respuesta de tipo booleano para validar si se ha iniciado sesión
 */
 Future<bool> getSesion() async{
   bool loginActivo;
   SharedPreferences preferences= await SharedPreferences.getInstance();
   preferences.getBool('sesion') == null || preferences.getBool('session') == false ? loginActivo= false: loginActivo =true;//?si es verdad : es un else
   print('Login Activo $loginActivo');
   return loginActivo;
 }

class Splash extends StatefulWidget {
  Splash({Key key}) : super(key: key);

  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  bool session;

  /**
   * Este metodo, carga todas las instrucciones que se le indiquen antes de que
   * cargue todo el demás codigo en la clase. (Es como si fuera un constructor en Java)
   */
  @override
  void initState() { 
    super.initState();//carga todo en un inicio
    getSesion().then(updateSession);//envia a updatesession 
  }

   void updateSession(bool session){
    setState(() {
      this.session=session;
      print('Sesion: ${this.session}');
    });
  }
  /**
   * El widget SPlashScreen en la linea n proviene del plugin instalado.
   * Permite crear un SplashScreen de manera sencilla y rápida
   */
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      gradientBackground: LinearGradient(
        colors: [
          Colors.yellow,
          Colors.red,
         
        ]
      ),
      seconds: 1,
      loaderColor: Colors.black,
      image: Image.asset('assets/images/Palomitas.png'),
      navigateAfterSeconds:  session ? Home(): Login(), //Pregunta se sessio es true (activo), si lo es manda al home, si no manda al login
    );
  }
}