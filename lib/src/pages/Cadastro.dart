import 'package:flutter/material.dart';
import 'package:rede_pos/src/controllers/Cadastro_controller.dart';
import 'package:rede_pos/src/controllers/Login_controllers.dart';
import 'package:rede_pos/src/models/User.dart';





class Cadastro extends StatefulWidget {
  @override
  _CadastroState createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {

  final cadastroController controller = cadastroController();

  TextEditingController email_controller = TextEditingController();
  TextEditingController senha_controller = TextEditingController();
  TextEditingController confirmar_senha_controller = TextEditingController();
  TextEditingController nome_controller = TextEditingController();
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
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: 30),
          height: height * 1,
          width: double.infinity,
          decoration: BoxDecoration(
            color: green,
          ),
          child: Column(
            children: [
              Padding(
                padding:  EdgeInsets.all(10),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap:(){
                        Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
                      },
                      child:Icon(Icons.arrow_back, color: Colors.white,), ),
                  ],
                ),
              ),
              Center(
                  child: Container(
                    padding: EdgeInsets.all(30),
                    width: width * 0.9,
                    height: height * 0.8,
                    decoration: BoxDecoration(
                        color: Colors.white, borderRadius: BorderRadius.circular(40)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [

                        Padding(
                          padding: EdgeInsets.only(top: 10, bottom: 30),
                          child: Text(
                            "Cadastro",
                            style: style,
                          ),
                        ),
                        TextField(
                          controller:nome_controller,
                          decoration: InputDecoration(
                            hintText: "Nome",
                            suffixIcon: Icon(Icons.person),
                          ),
                          keyboardType: TextInputType.text,
                          style: style2,
                        ),
                        TextField(
                          controller: email_controller,
                          decoration: InputDecoration(
                            hintText: "e-mail",
                            suffixIcon: Icon(Icons.email),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          style: style2,
                        ),
                        TextField(
                          controller: senha_controller,
                          decoration: InputDecoration(
                            hintText: "senha",
                            suffixIcon: Icon(Icons.lock),
                          ),
                          obscureText: true,
                          keyboardType: TextInputType.text,
                          style: style2,
                        ),
                        TextField(
                          controller: confirmar_senha_controller,
                          decoration: InputDecoration(
                           hintText: "Confirme a senha",
                            suffixIcon: Icon(Icons.lock),
                          ),
                          obscureText: true,
                          keyboardType: TextInputType.text,
                          style: style2,
                        ),
                        ElevatedButton(
                          child: Text(
                            "Cadastrar",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          onPressed: () {
                          String confirmarSenha = confirmar_senha_controller.text;

                          user User = user();

                          User.name = nome_controller.text;
                          User.email = email_controller.text;
                          User.password = senha_controller.text;

                          controller.verificarCampos(User, context, confirmarSenha );



                          },
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.all(9),
                            primary: green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
