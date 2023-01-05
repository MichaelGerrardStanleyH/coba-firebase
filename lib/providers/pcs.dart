import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/pc.dart';

class Pcs with ChangeNotifier{
  List<Pc> _allPcs = [];

  List<Pc> get allPc => _allPcs;

  int get jumlahPc => _allPcs.length;

  Pc selectById(String id)=>
      _allPcs.firstWhere((element) => element.id == id);

  Future<void> addPc(
      String name,
      BuildContext context
      )async {
    Uri url = Uri.parse("https://http-req-d5914-default-rtdb.firebaseio.com/pcs.json");
    return http.post(
        url,
        body: json.encode({
          "name": name,
          "processor": "null ya anjing",
          "ram": "null",
          "motherboard": "null",
        })
    ).then((response){
      _allPcs.add(
        Pc(
            name: name,
            processor: "null",
            ram: "null",
            motherboard: "null",
            id: json.decode(response.body)["name"].toString()
        )
      );
    });
  }
}