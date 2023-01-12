import 'package:coba_firebase/models/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Users with ChangeNotifier{
   late User _user;

   void setProperty(String id, String username, String password){
     _user.id = id;
     _user.username = username;
     _user.password = password;
   }

  Future<void> addUser(String username, String password, BuildContext context)async {
    Uri url = Uri.parse("https://http-req-d5914-default-rtdb.firebaseio.com/users.json");
    return http.post(
      url,
      body: json.encode({
        "username": username,
        "password": password,
      },
      ),
    ).then((response) {
       setProperty(
         json.decode(response.body)["name"].toString(),
          username,
          password,
       );
    });
  }
}