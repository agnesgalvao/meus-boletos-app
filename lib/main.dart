import 'package:flutter/material.dart';
import 'package:rede_pos/src/app/routes.dart';

void main() async {

  runApp(

      MaterialApp(


        initialRoute:"/" ,

        onGenerateRoute: Routes.genRoutes,
        debugShowCheckedModeBanner: false,

  )
  );


}

