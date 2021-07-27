

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:rede_pos/src/models/User.dart';
import 'package:rede_pos/src/models/infosUser.dart';
class loginControllers {
  var url = 'https://mobile-test.redepos.com.br';

  verificar_campos(user User, BuildContext context) {
    if (User.email.isEmpty ||User.password.isEmpty) {
      return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Preencha o email corretamente!"),

            );
          });
    }else{
      login(User, context);}



  }

  login(user User, BuildContext context) async{

    var url = Uri.parse('https://mobile-test.redepos.com.br/login');

    var corpo = jsonEncode({
      'apptoken': 'b5ce205e-f505-428a-b5fc-8e5dfb980f64',
      'password':User.password,
       'email': User.email
    });

    http.Response response = await http.post(url,
        headers: {"Content-type": "application/json; charset=UTF-8"},
        body: corpo);

      final retorno = response.body;

    if (retorno.contains('email') && retorno.contains('jwttoken')) {
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      var token = jsonResponse['jwttoken'];

      recuperarInfosUser(User.email, token, context);
    } else if(retorno.contains('1005') ){

     return showDialog(
          context: context,
          builder: (context) {
            return Dialog(
                backgroundColor: Colors.transparent,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.2,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "E-mail ou senha incorretos!",

                      ),
                    ],
                  ),
                ));
          });
    }

  }


    recuperarInfosUser(String email, String token, BuildContext context)async{
      var uri = Uri.parse('${url}/getvalue');

      var corpo =  jsonEncode({
        'key': 'name'
      });


      http.Response response = await http.post(uri,
          headers: {"Content-type": "application/json; charset=UTF-8", "Token": token },
          body: corpo);
      final retorno = response.body;

      Map<String, dynamic> jsonResponse = jsonDecode(response.body);
   String name = jsonResponse['value'];


      if(retorno.contains('value')){
        Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false, arguments: infosUser(email, name, token) );



      }else{

        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text('Erro ao realizar login')
              );

        });
      }





    }

}






















