import 'dart:async';

import 'package:flutter/material.dart';


class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  counter() {
    Timer(Duration(seconds: 3), setpage);
  }
  setpage() {
    Navigator.pushReplacementNamed(context, "/login");
  }
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    counter();

    return Container(
      decoration: BoxDecoration(color: Colors.white),

      height: double.infinity,
      width: double.infinity,
      child: Icon(Icons.monetization_on_outlined, size: height*0.15, color: Colors.green,),



    );
  }
}






