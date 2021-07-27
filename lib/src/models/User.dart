import 'dart:convert';

import 'package:flutter/material.dart';


class user{

  String name;
  String email;
  String password;
  String apptoken;




  user(
      { this.apptoken,
        this.name,
        this.password,
        this.email,

        });

  Map<String, dynamic> toJson() =>
      { 'apptoken': 'b5ce205e-f505-428a-b5fc-8e5dfb980f64',
        'name': name,
        'password': password,
        'email' : email
      };



  }






