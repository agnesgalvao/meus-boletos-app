import 'package:flutter/material.dart';
import 'package:rede_pos/src/pages/Cadastro.dart';
import 'package:rede_pos/src/pages/Home.dart';
import 'package:rede_pos/src/pages/Login.dart';
import 'package:rede_pos/src/pages/Splash.dart';

class Routes {

  static Route<dynamic> genRoutes(RouteSettings settings){

   final args = settings.arguments;
    switch (settings.name){
      case "/" : return MaterialPageRoute(builder: (_) => Splash());
      case "/login" : return MaterialPageRoute(builder: (_) => Login());
      case "/cadastro" : return MaterialPageRoute(builder: (_) => Cadastro());
      case "/home" : return MaterialPageRoute(builder: (_) => Home(infouser: args,));




    }




  }


}
