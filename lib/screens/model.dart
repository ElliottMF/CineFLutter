 import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
 
  //void main() => runApp(new MyApp());
 
 class Model extends StatelessWidget {
  @override
    Widget build(BuildContext context) {
    return   MaterialApp(
      title: 'json',
      theme: ThemeData(primarySwatch: Colors.teal),
      home: Scaffold(
        appBar: AppBar(title: Text('json aaa'),),
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
      ),
    
    );
    }
 }
 Future <List<Pelicula>> ListaPelicula() async{
   final response = await http.get('http://192.168.200.85:8080/WSAPPCINE/apirest/WSPELICULAS/listado');

   if(response.statusCode == 200)
   {
     List peliculas = json.decode(response.body);
     return peliculas.map((pelicula)=> new Pelicula.fromJson(pelicula)).toList();
   }
   else
    throw Exception('error al cargar las peliculas');
  
 }

 /* 
   {
        "id_pelicula": 1,
        "nombre": "zombieland",
        "duracion": "120",
        "id_clasificacion": 1,
        "id_genero": 1
    }
 */
class Pelicula{
  final String nombre;
  final String duracion;
  final String id_clasificacion;
  final String id_genero;

  Pelicula({this.nombre, this.duracion, this.id_clasificacion, this.id_genero});

  factory Pelicula.fromJson(Map<String,dynamic> json)
  {
    return Pelicula(
      nombre:json['nombre'],
      duracion: json['duracion'].toString(),
      id_clasificacion: json['id_clasificacion'],
      id_genero: json['id_genero'],
    );
  }
}
