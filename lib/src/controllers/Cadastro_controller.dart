
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rede_pos/src/controllers/Login_controllers.dart';
import 'dart:convert';

import 'package:rede_pos/src/models/User.dart';
import 'package:rede_pos/src/models/infosUser.dart';

class cadastroController{


  var url = 'https://mobile-test.redepos.com.br';
  verificarCampos(user User, BuildContext context, String confirmarsSenha){

    if( User.email.isEmpty || User.password.isEmpty || User.name.isEmpty){


      return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Preencha todos os campos!"),

            );
          });

    }else if( User.email.contains('@') == false || User.email.contains('.')== false){
      return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Email invalido!"),

            );
          });
    }else if(User.password != confirmarsSenha ){

      return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("As senhas não correspondem!"),

            );
          });
      }else{

      cadastrarUsuario(User, context);
      return showDialog(context: context, builder:(context){
        return AlertDialog(
          content: Container(
              height: 100,
              width: 100,
              child: Center(child: CircularProgressIndicator())),
        );
      }

      );}

  }


  cadastrarUsuario(user User, BuildContext context) async{



    var uri = Uri.parse('${url}/signup');

    var corpo =  jsonEncode( User.toJson());


    http.Response response = await http.post(uri,
        headers: {"Content-type": "application/json; charset=UTF-8"},
        body: corpo);
    final retorno = response.body;
    if(retorno.contains('userid')){

          gerarJWT(User, context);

    }else{
      print(retorno);
      return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("erro ao realizar cadastro!"),

            );
          });
    }



  }


  gerarJWT(user User, BuildContext context)async{

    var uri = Uri.parse('${url}/login');

    var corpo = jsonEncode({
      'apptoken': 'b5ce205e-f505-428a-b5fc-8e5dfb980f64',
      'password':User.password,
      'email': User.email
    });

    http.Response response = await http.post(uri,
        headers: {"Content-type": "application/json; charset=UTF-8"},
        body: corpo);
   //
    final retorno = response.body;

    if (retorno.contains('email') && retorno.contains('jwttoken')) {
      Map<String, dynamic> retorno = json.decode(response.body);
      String Token = retorno['jwttoken'];
      salvarInfosUser(User, context, Token);
    }else{

      gerarJWT(User, context);
    }




  }


  salvarInfosUser(user User, BuildContext context,String token)async{


    var uri = Uri.parse('${url}/setvalue');

    var corpo =  jsonEncode({
      'key': 'name',
      'value': User.name
    });


    http.Response response = await http.post(uri,
        headers: {"Content-type": "application/json; charset=UTF-8", "Token": token },
        body: corpo);
    final retorno = response.body;




    if(retorno.contains('key')){
      print(retorno);
      return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Cadastro realizado com sucesso!"),

            );
          }).then((value) => Navigator.pushNamedAndRemoveUntil(context, "/home", (route) => false,arguments: infosUser(User.email, User.name, token)));


    }else{
      return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Erro ao realizar cadastro!"),

            );
          });


    }



  }


}






























