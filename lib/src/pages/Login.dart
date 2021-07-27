import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rede_pos/src/controllers/Login_controllers.dart';
import 'package:rede_pos/src/models/User.dart';




class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final loginControllers controller = loginControllers();

  TextEditingController email_controller = TextEditingController();
  TextEditingController senha_controller = TextEditingController();
  bool loading = false;
  Color green = Colors.green;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    TextStyle style = TextStyle(
        color: green,
        fontSize: height*0.05,
        fontWeight: FontWeight.bold);

    TextStyle style2 = TextStyle(
        color:green,
        fontSize: height*0.024,
        fontWeight: FontWeight.bold);

    return Scaffold(



      body:  Container(
          height: height * 1,
          width: double.infinity,
          decoration: BoxDecoration(color: green),
          padding: EdgeInsets.fromLTRB(20, 80, 20, 40),
          child: SingleChildScrollView(
            child: Container(
                padding: EdgeInsets.all(30),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(40)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Login',
                      style: style,
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 14),
                      child: TextField(
                        controller: email_controller,
                        style: style2,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            alignLabelWithHint: true,
                            labelText: 'E-mail',
                            labelStyle: style2),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10, bottom: 10),
                      child: TextField(
                        controller: senha_controller,
                        style: style2,
                        keyboardType: TextInputType.text,
                        obscureText: true,
                        decoration: InputDecoration(
                            alignLabelWithHint: true,
                            labelText: 'Senha',
                            labelStyle: style2),
                      ),
                    ),
                Padding(
                  padding: EdgeInsets.only( bottom: 20),
                  child: GestureDetector(
                    onTap: (){
                      Navigator.pushNamed(context, "/cadastro");
                    },
                    child: Text(
                      'Ainda não tem cadastro? Clique aqui!',
                      style: style2,
                    ),
                  ),),
                    Padding(
                      padding: EdgeInsets.only(bottom: 30),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: green),
                        onPressed: () {
                          user User = user();
                          User.email= email_controller.text;
                          User.password = senha_controller.text;
                          controller.verificar_campos( User , context,);
                          setState(() {
                            loading = true;
                          });

                          },
                        child: Text(
                          'Entrar',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ))
                    )
                      ,
                    GestureDetector(
                      child: Text(
                        '*Ao clicar em entrar você estará concordando com nossos Termos de uso e políticas de privacidede',
                        style: style2,
                      ),
                    ),
                  ],
                )),
          )),
    );
  }
}
