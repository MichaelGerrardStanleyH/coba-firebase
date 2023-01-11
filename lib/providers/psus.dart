import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/psu.dart';

class Psus with ChangeNotifier{
  List<Psu> _allPsus = [];

  List<Psu> get allPsu => _allPsus;

  int get jumlahPsu => _allPsus.length;

  Psu selectById(String id)=>
      _allPsus.firstWhere((element) => element.id == id);

  Psu selectByName(String name)=>
      _allPsus.firstWhere((element) => element.name == name);

  Future<void> addPsu(String name, int price, BuildContext context)async {
    Uri url = Uri.parse("https://http-req-d5914-default-rtdb.firebaseio.com/psus.json");
    return http.post(
      url,
      body: json.encode({
        "name": name,
        "price": price,
      },
      ),
    ).then((response) {
      _allPsus.add(
          Psu(
            name: name,
            price: price,
            id: json.decode(response.body)["name"].toString(),
          ));

      notifyListeners();
    });
  }

  Future<void> initalData()async {
    Uri url = Uri.parse("https://http-req-d5914-default-rtdb.firebaseio.com/psus.json");

    var hasilGetData = await http.get(url);
    var dataResponse = json.decode(hasilGetData.body) as Map<String, dynamic>;


    dataResponse.forEach((key, value) {
      _allPsus.add(
          Psu(
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
