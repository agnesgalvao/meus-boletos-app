import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rede_pos/src/controllers/Home_controllers.dart';
import 'package:rede_pos/src/models/boleto.dart';
import 'package:rede_pos/src/models/infosUser.dart';


class Home extends StatefulWidget {
  final infosUser  infouser;

  const Home({Key key, this.infouser}) : super(key: key);



  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  homeControllers controller = homeControllers();

  TextEditingController buscar = TextEditingController();
  TextEditingController key = TextEditingController();
  TextEditingController value = TextEditingController();

  Color green = Colors.green;
  addAndEditView(){

  }
Future recuperarBoleto;
  @override
  void initState() {
    recuperarBoleto = controller.recuperarBoletos(widget.infouser.token, context);
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    TextStyle style = TextStyle(
        color:Colors.white,
        fontSize: height*0.024,
        fontWeight: FontWeight.bold);
    TextStyle style2 = TextStyle(
        color: green,
        fontSize: height*0.024,
        fontWeight: FontWeight.bold);

    return Scaffold(

      floatingActionButton: FloatingActionButton(
        onPressed: (){
          return showDialog(
              context: context,
              builder: (context) {
                return Dialog(
                  backgroundColor: Colors.transparent,
                  child: Container(
                    height: height*0.4,
                    width: width*0.9,
                    decoration: BoxDecoration( color: green, borderRadius: BorderRadius.circular(40)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                            height: height*0.06,
                            width: width*0.7
                            ,child: TextField(
                          style: style2,
                          controller:  key,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(5),

                            hintText: 'Digite o nome do boleto',
                            hintStyle: TextStyle(color: Colors.grey),
                            fillColor: Colors.white,
                            filled: true,
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(10)),

                          ),
                        )),
                        SizedBox(
                            height: height*0.06,
                            width: width*0.7
                            ,child: TextField(
                          keyboardType: TextInputType.number,
                          style: style2,

                          controller: value,
                          decoration: InputDecoration(
                            prefix: Text('R\$', style: style2,),
                            contentPadding: EdgeInsets.all(5),
                            hintText: '0,00',
                            hintStyle: TextStyle(color: Colors.grey),
                            fillColor: Colors.white,
                            filled: true,
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        )),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Colors.white),
                            onPressed: () {

                              if(key.text.isEmpty || value.text.isEmpty){}else {
                                controller.adcionarBoleto(
                                    context, boleto(key.text, value.text),
                                    infosUser(widget.infouser.email,
                                        widget.infouser.name,
                                        widget.infouser.token));
                              }
                            },
                            child: Text(
                              'salvar',
                              style: TextStyle(fontSize: 16, color: green),
                            ))


                      ],
                    ),
                  ),
                );
              }).then((value) => Navigator.pushReplacementNamed(context, "/home",arguments: infosUser(widget.infouser.email,widget.infouser.name, widget.infouser.token)));




        },
        backgroundColor: green,
        foregroundColor: Colors.white,
        child: Icon(Icons.add),
      ),

      appBar:
      AppBar(
        toolbarHeight: height*0.2,
        backgroundColor: green,
        actions: [Container(
width: width*1,
          padding: EdgeInsets.only(left: height*0.005,top: height*0.028, right: height*0.005 ),
height: height*0.1,
          decoration: BoxDecoration(
            color: green
          ),
          child: Row(mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.account_circle, size: height*0.12,),
              Padding(
                padding: EdgeInsets.only(left: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children:[
                      Text( widget.infouser.name, style: style,),
                      Text( widget.infouser.email, style: style,),
                      Padding(
                        padding:  EdgeInsets.only(top: height*0.02),
                        child: SizedBox(
                            height: height*0.06,
                            width: width*0.7
                            ,child: TextField(
                          
                          style: style2,
                          textInputAction: TextInputAction.search,
                          onSubmitted: (value){
                                     if(buscar.text.isEmpty){}else{ controller.BuscarBoleto(buscar.text, context, widget.infouser);}
                          },
                          controller: buscar,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(5),

                             hintText: 'Digite o nome do boleto',
                              hintStyle: TextStyle(color: Colors.grey),
                              fillColor: Colors.white,
                          filled: true,
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(10)),
                            suffixIcon: GestureDetector(
                              onTap: (){    if(buscar.text.isEmpty){}else{ controller.BuscarBoleto(buscar.text, context, widget.infouser);}},
                              child: Icon(Icons.search, size: height*0.05, color: Colors.grey),)

                         ),
                        )),
                      )


                    ]

                ),
              )

            ],
          ),
        ),

        ],
      ),

      body: Container(
        padding: EdgeInsets.all(20),

   child: FutureBuilder(
     future: recuperarBoleto,
    builder: (context, snapshot) {



      if (snapshot.connectionState == ConnectionState.none &&
          snapshot.hasData == null) {
        //print('project snapshot data is: ${projectSnap.data}');
        return Container();
      }else if( snapshot.hasData ){

        return snapshot.data.length == 0 ? Center(child: Text('Adicione boletos e controle seus gastos', style: style2,)) :ListView.builder(
          itemCount: snapshot.data.length,
          itemBuilder: (BuildContext context, int index){
            return Padding(
              padding: const EdgeInsets.all(10),
              child: new Container(
                padding: EdgeInsets.only(left: 10, right: 10),
                height: height*0.1,
                width: width*0.8,
                decoration: BoxDecoration(color: green, borderRadius: BorderRadius.circular(20)),
                child:  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(snapshot.data[index].key, style: style,),
                        Text('R\$${snapshot.data[index].value}', style: style,)
                      ],


                    ),
                    Container(
                      width: width*0.22,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(

                           onTap:(){
                                     key.text = snapshot.data[index].key;
                                     value.text = snapshot.data[index].value;
                             return showDialog(
                                 context: context,
                                 builder: (context) {
                                   return Dialog(
                                     backgroundColor: Colors.transparent,
                                     child: Container(
                                       height: height*0.4,
                                       width: width*0.9,
                                       decoration: BoxDecoration( color: green, borderRadius: BorderRadius.circular(40)),
                                       child: Column(
                                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                         children: [
                                           SizedBox(
                                               height: height*0.06,
                                               width: width*0.7
                                               ,child: TextField(
                                             style: style2,
                                             controller:  key,
                                             decoration: InputDecoration(
                                               enabled: false,
                                               contentPadding: EdgeInsets.all(5),

                                               fillColor: Colors.white,
                                               filled: true,
                                               border: OutlineInputBorder(
                                                   borderSide: BorderSide.none,
                                                   borderRadius: BorderRadius.circular(10)),

                                             ),
                                           )),
                                           SizedBox(
                                               height: height*0.06,
                                               width: width*0.7
                                               ,child: TextField(
                                             keyboardType: TextInputType.number,
                                             style: style2,

                                             controller: value,
                                             decoration: InputDecoration(
                                               contentPadding: EdgeInsets.all(5),
                                               prefix: Text('R\$', style: style2,),
                                               hintText: '0,00',
                                               hintStyle: TextStyle(color: Colors.grey),
                                               fillColor: Colors.white,
                                               filled: true,
                                               border: OutlineInputBorder(
                                                   borderSide: BorderSide.none,
                                                   borderRadius: BorderRadius.circular(10)),
                                             ),
                                           )),
                                           ElevatedButton(
                                               style: ElevatedButton.styleFrom(
                                                   primary: Colors.white),
                                               onPressed: () {

                                                 if(value.text.isEmpty){}else {
                                                   controller.adcionarBoleto(
                                                       context, boleto(
                                                       key.text, value.text),
                                                       infosUser(widget.infouser
                                                           .email,
                                                           widget.infouser.name,
                                                           widget.infouser
                                                               .token));
                                                 }
                                               },
                                               child: Text(
                                                 'salvar',
                                                 style: TextStyle(fontSize: 16, color: green),
                                               ))


                                         ],
                                       ),
                                     ),
                                   );
                                 }).then((value) => Navigator.pushReplacementNamed(context, "/home",arguments: infosUser(widget.infouser.email,widget.infouser.name, widget.infouser.token)));



                           },             child: Icon(Icons.edit_outlined, size: height*0.05, color: Colors.white,), ),
                          GestureDetector(child: Icon(Icons.delete, size: height*0.05, color: Colors.white,
                          ),    onTap:(){
                            controller.removerBoleto(snapshot.data[index].key,  context, widget.infouser);
                          })

                        ],
                      ),
                    )

                  ],
                ),
              ),
            );
          },


        );

      }else{return Center(child: CircularProgressIndicator( )); }

     }


   ),

      ) );
  }
}
