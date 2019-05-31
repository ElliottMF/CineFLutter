import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

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
   return new Scaffold(
     appBar: AppBar(
       title: Text('Cine',style: TextStyle(color: Colors.white),),    
     ),
     body: Center(
       child: RaisedButton(
         child: Text('cerrar sesion'),
         onPressed:()=>logout(),
       ),

     )
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

