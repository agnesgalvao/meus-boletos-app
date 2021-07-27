import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:rede_pos/src/models/boleto.dart';
import 'package:rede_pos/src/models/infosUser.dart';




class homeControllers{
  var url = 'https://mobile-test.redepos.com.br';


 Map boletos;
 List<boleto> listaBoletos =[];

  Future recuperarBoletos(String token, BuildContext context) async{
    var uri = Uri.parse('${url}/getalldata');

    var corpo =  jsonEncode({
    });

    http.Response response = await http.post(uri,
        headers: {"Content-type": "application/json; charset=UTF-8", "Token": token },
        body:jsonEncode({}));

    print(response.body);

    var retorno = jsonDecode(response.body);
if(response.body.contains( 'data')) {
  boletos = retorno['data'];
  boletos.forEach((k, v) => listaBoletos.add(boleto(k, v)));
  listaBoletos.removeLast();
  print(listaBoletos);
  return listaBoletos;
}else if(response.body.contains('1012')){

  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
       content:   Text("Login Expirado!"),


        );
      }).then((value) =>  Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false,));



}

    }

    adcionarBoleto(BuildContext context, boleto Boleto, infosUser InfosUser)async{
      var uri = Uri.parse('${url}/setvalue');

      var corpo =  jsonEncode({
        'key': Boleto.key ,
        'value': Boleto.value
      });


      http.Response response = await http.post(uri,
          headers: {"Content-type": "application/json; charset=UTF-8", "Token": InfosUser.token },
          body: corpo);
      final retorno = response.body;

         if ( retorno.contains('key')){
             
           Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false, arguments: infosUser(InfosUser.email, InfosUser.name, InfosUser.token));
               
         }else if(retorno.contains('1012')){
         return  showDialog(
               context: context,
               builder: (context) {
                 return  AlertDialog(
                   content:   Text("Login Expirado!"),


                 );
               }).then((value) =>  Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false,));



         }





    }




    removerBoleto(String key, BuildContext context, infosUser InfosUser)async{
      var uri = Uri.parse('${url}/remvalue');

      var corpo =  jsonEncode({
        'key':key ,

      });


      http.Response response = await http.post(uri,
          headers: {"Content-type": "application/json; charset=UTF-8", "Token": InfosUser.token },
          body: corpo);

      final retorno = response.body;


      if ( retorno.contains('value')){

        Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false, arguments: infosUser(InfosUser.email, InfosUser.name, InfosUser.token));

      }else if(retorno.contains('1012')){
      return  showDialog(
      context: context,
      builder: (context) {
      return  AlertDialog(
      content:   Text("Login Expirado!"),


      );
      }).then((value) =>  Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false,));



      }





    }

    BuscarBoleto(String key,  BuildContext context, infosUser InfosUser)async{

      var uri = Uri.parse('${url}/getvalue');

      var corpo =  jsonEncode({
        'key':key ,

      });


      http.Response response = await http.post(uri,
          headers: {"Content-type": "application/json; charset=UTF-8", "Token": InfosUser.token },
          body: corpo);
print(response.body);
      final retorno = response.body;
      var value =  retorno != null ? jsonDecode(retorno): "";

      if(retorno.contains('1008')){
      return  showDialog(
      context: context,
      builder: (context) {
      return Dialog(
      child: Container(
      padding: EdgeInsets.all(40),
        height: 150,
        width: 400,
      child:   Center(child: Text('nenhum resultado para ${key}', style: TextStyle(fontSize: 20),),


      ),
      ),


      );
      }).then((value) => Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false, arguments: infosUser(InfosUser.email, InfosUser.name, InfosUser.token)));}
      else if ( retorno.contains('value')){

        showDialog(
            context: context,
            builder: (context) {
              return Dialog(
                child: Container(
                  height: 150,
                  width: 400,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
                  padding: EdgeInsets.all(40),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(key,style: TextStyle(fontSize: 20)),
                       Text(value['value'], style: TextStyle(fontSize: 20)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: (){removerBoleto(key, context, InfosUser);},
                            child: Text( 'Apagar',  style: TextStyle(fontSize: 20, color: Colors.red)),),

                        ],
                      )
                    ],
                  ),
                ),


              );
            }).then((value) => Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false, arguments: infosUser(InfosUser.email, InfosUser.name, InfosUser.token)));


      }else if(retorno.contains('1012')){
        print(retorno);return  showDialog(
            context: context,
            builder: (context) {
              return  AlertDialog(
                content:   Text("Login Expirado!"),


              );
            }).then((value) =>  Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false,));






      }





    }


  }


