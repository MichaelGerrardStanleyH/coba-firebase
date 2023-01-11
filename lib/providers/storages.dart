import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/storage.dart';

class Storages with ChangeNotifier{
  List<Storage> _allStorages = [];

  List<Storage> get allStorage => _allStorages;

  int get jumlahStorage => _allStorages.length;

  Storage selectById(String id)=>
  _allStorages.firstWhere((element) => element.id == id);

  Storage selectByName(String name)=>
  _allStorages.firstWhere((element) => element.name == name);

  Future<void> addStorage(String name, int price, BuildContext context)async {
    Uri url = Uri.parse("https://http-req-d5914-default-rtdb.firebaseio.com/storages.json");
    return http.post(
      url,
      body: json.encode({
        "name": name,
        "price": price,
      },
      ),
    ).then((response) {
      _allStorages.add(
          Storage(
            name: name,
            price: price,
            id: json.decode(response.body)["name"].toString(),
          ));

      notifyListeners();
    });
  }

  Future<void> initalData()async {
    Uri url = Uri.parse("https://http-req-d5914-default-rtdb.firebaseio.com/storages.json");

    var hasilGetData = await http.get(url);
    var dataResponse = json.decode(hasilGetData.body) as Map<String, dynamic>;


    dataResponse.forEach((key, value) {
      _allStorages.add(
          Storage(
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