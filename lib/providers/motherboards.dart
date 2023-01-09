import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../models/motherboard.dart';

class Motherboards with ChangeNotifier{
  List<Motherboard> _allMotherboards = [];

  List<Motherboard> get allMotherboard => _allMotherboards;

  int get jumlahMotherboard => _allMotherboards.length;

  Motherboard selectById(String id) =>
      _allMotherboards.firstWhere((element) => element.id == id);

Future<void> addMotherboard(
      String name,
      String vendor,
      int price,
      BuildContext context
      )async {
    Uri url = Uri.parse("https://http-req-d5914-default-rtdb.firebaseio.com/motherboards.json");
    return http.post(
        url,
        body: json.encode({
          "name": name,
          "vendor": vendor,
          "price": price,
        })
    ).then((response){
      _allMotherboards.add(
          Motherboard(
            name: name,
            vendor: vendor,
            id: json.decode(response.body)["name"].toString(),
            price: price,
          )
      );
      notifyListeners();
    });
  }

  Future<void> initalData() async {
    Uri url = Uri.parse("https://http-req-d5914-default-rtdb.firebaseio.com/motherboards.json");

    var hasilGetData = await http.get(url);
    var dataResponse = json.decode(hasilGetData.body) as Map<String, dynamic>;

    dataResponse.forEach((key, value) {
      _allMotherboards.add(
        Motherboard(id: key,
          name: value["name"],
          vendor: value["vendor"],
          price: value["price"],
        ),
      );
    });
    notifyListeners();
  }
}