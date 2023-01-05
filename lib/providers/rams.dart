import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/ram.dart';

class Rams with ChangeNotifier{
  List<Ram> _allRams = [];

  List<Ram> get allRam => _allRams;

  int get jumlahRam => _allRams.length;

  Ram selectById(String id) =>
    _allRams.firstWhere((element) => element.id == id);


  Future<void> addRam(String name, int size, BuildContext context)async {
    Uri url = Uri.parse("https://http-req-d5914-default-rtdb.firebaseio.com/ram.json");
    return http.post(
        url,
        body: json.encode({
          "name": name,
          "size": size,
        },
        ),
    ).then((response) {
      _allRams.add(
        Ram(name: name,
            size: size,
            id: json.decode(response.body)["name"].toString(),
      ));

      notifyListeners();
    });
  }

  Future<void> initalData()async {
    Uri url = Uri.parse("https://http-req-d5914-default-rtdb.firebaseio.com/rams.json");

    var hasilGetData = await http.get(url);
    var dataResponse = json.decode(hasilGetData.body) as Map<String, dynamic>;


      dataResponse.forEach((key, value) {
        _allRams.add(
          Ram(
                name: value["name"]
              , size: value["size"]
              , id: key
          )
        );
      });
      notifyListeners();
  }
}

