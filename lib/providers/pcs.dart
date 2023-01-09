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

  Pc selectByName(String name)=>
      _allPcs.firstWhere((element) => element.name == name);

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
          "ram": "null ya ",
          "motherboard": "null ini",
          "totalPrice": 0,
        })
    ).then((response){
      _allPcs.add(
        Pc(
            name: name,
            processor: "null",
            ram: "null",
            motherboard: "null",
            id: json.decode(response.body)["name"].toString(),
            totalPrice: 0
        )
      );
      notifyListeners();
    });
  }

  Future<void> editPc(
      String id,
      // String name,
      String processor,
      String ram,
      // String motherboard,
      // int price,
      BuildContext context
      )async {
    Uri url = Uri.parse("https://http-req-d5914-default-rtdb.firebaseio.com/pcs/$id.json");
    return http.patch(
        url,
        body: json.encode({
          // "name": name,
          "processor": processor,
          "ram": ram,
          // "motherboard": motherboard,
          // "price": price
        })
    ).then((response){
      Pc existPc = _allPcs.firstWhere((element) => element.id == id);
      existPc.name = "ini nama edit";
      existPc.ram = ram;
      existPc.motherboard = "null";
      existPc.processor = processor;
      existPc.totalPrice = 0;
      notifyListeners();
    });
  }

  Future<void> initalData() async {
    Uri url = Uri.parse("https://http-req-d5914-default-rtdb.firebaseio.com/pcs.json");

    var hasilGetData = await http.get(url);
    var dataResponse = json.decode(hasilGetData.body) as Map<String, dynamic>;

    dataResponse.forEach((key, value) {
      _allPcs.add(
        Pc(
            id: key,
            name: value["name"],
            processor: value["processor"],
            ram: value["ram"],
            motherboard: value["motherboard"],
            totalPrice: value["totalPrice"]
        ),
      );
    });
    notifyListeners();
  }
}