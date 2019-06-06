import 'package:cineproyecto/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'model.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => new _HomeState();
 }
class _HomeState extends State<Home> {

  FirebaseMessaging firebaseMessaging = new FirebaseMessaging();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
     _firebaseCloudMessaging(); 
    });
  }
  @override
    Widget build(BuildContext context) {
    return   MaterialApp(
      title: 'json',
      theme: ThemeData(primarySwatch: Colors.teal),
      home: Scaffold(
        appBar: AppBar(title: Text('Peliculas'),),
        body: Center(
          child: FutureBuilder<List<Pelicula>>(
            future: ListaPelicula(),
            builder: (context,snapshot){
              if(snapshot.hasData){
                List<Pelicula> peliculas = snapshot.data;
                
                return  new ListView(
                   
                  children: peliculas
                  .map((pelicula)=> Column(mainAxisAlignment: MainAxisAlignment.center,children: <Widget>[
                         Text('Nombre: ${pelicula.nombre}'),
                        Text('Duracion: ${pelicula.duracion}'),
                        Text('Clasificacion: ${pelicula.id_clasificacion}'),
                        Text('Genero: ${pelicula.id_genero}'),
                          
                        new Divider()
                        
                  ])) 
                  .toList(),
                  
                  
                );
              }
              else if(snapshot.hasError){
                return Text('${snapshot.error}');

              }
              return new CircularProgressIndicator();
            }

          ),
        ),
        drawer: new Drawer(
          child: ListView(
            children: <Widget>[
              new ListTile(
                title: new Text('Cerrar Sesión'),
                onTap: (){
                   logout();
                },
              )
            ],
          ),
          

         )
      ),
    
    );
    }
  void logout() async{ //cuando damos clic en logout borra todo lo de la preferences 
     SharedPreferences preferences = await SharedPreferences.getInstance();
     preferences.clear();
     Navigator.of(context).pushAndRemoveUntil(
       MaterialPageRoute(builder:(context) => Login()),
       (Route<dynamic> route) => false
     );
   }
   void _firebaseCloudMessaging() {

    firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('on message - $message');
      },
      onResume: (Map<String, dynamic> message) async {
        print('on resume $message');
      },
      onLaunch: (Map<String, dynamic> message) async {
        print('on launch - ${message['data']['click_action']}');}
    );
  }
}

