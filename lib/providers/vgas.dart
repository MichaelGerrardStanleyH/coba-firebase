import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/vga.dart';

class Vgas with ChangeNotifier{
  List<Vga> _allVgas = [];

  List<Vga> get allVga => _allVgas;

  int get jumlahVga => _allVgas.length;

  Vga selectById(String id)=>
      _allVgas.firstWhere((element) => element.id == id);

  Vga selectByName(String name)=>
      _allVgas.firstWhere((element) => element.name == name);

  Future<void> addVga(String name, int price, BuildContext context)async {
    Uri url = Uri.parse("https://http-req-d5914-default-rtdb.firebaseio.com/vgas.json");
    return http.post(
      url,
      body: json.encode({
        "name": name,
        "price": price,
      },
      ),
    ).then((response) {
      _allVgas.add(
          Vga(
            name: name,
            price: price,
            id: json.decode(response.body)["name"].toString(),
          ));

      notifyListeners();
    });
  }

  Future<void> initalData()async {
    Uri url = Uri.parse("https://http-req-d5914-default-rtdb.firebaseio.com/vgas.json");

    var hasilGetData = await http.get(url);
    var dataResponse = json.decode(hasilGetData.body) as Map<String, dynamic>;


    dataResponse.forEach((key, value) {
      _allVgas.add(
          Vga(
            id: key,
            name: value["name"],
            price: value["price"],
          )
      );
    });
    print("berhasil data");

    notifyListeners();
  }
}