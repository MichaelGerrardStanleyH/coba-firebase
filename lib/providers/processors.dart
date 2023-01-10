import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/processor.dart';

class Processors with ChangeNotifier{
  List<Processor> _allProcessors = [];

  List<Processor> get allProcessor => _allProcessors;

  int get jumlahProcessors => _allProcessors.length;

  Processor selectById(String id) =>
      _allProcessors.firstWhere((element) => element.id == id);

  Processor selectByName(String name) =>
    _allProcessors.firstWhere((element) => element.name == name);

  Future<void> addProcessor(
      String name,
      String vendor,
      int price,
      BuildContext context
      )async {
    Uri url = Uri.parse("https://http-req-d5914-default-rtdb.firebaseio.com/processors.json");
    return http.post(
        url,
        body: json.encode({
          "name": name,
          "vendor": vendor,
          "price": price,
        })
    ).then((response){
      _allProcessors.add(
          Processor(
              name: name,
              vendor: vendor,
              id: json.decode(response.body)["name"].toString(),
              price: price,
          )
      );
      notifyListeners();
    });
  }

  Future<void> editProcessor(
      String id,
      String name,
      String vendor,
      int price,
      BuildContext context
      )async {
    Uri url = Uri.parse("https://http-req-d5914-default-rtdb.firebaseio.com/processors/$id.json");
    return http.patch(
        url,
        body: json.encode({

        })
    ).then((response){
      Processor existPc = _allProcessors.firstWhere((element) => element.id == id);
      existPc.name = name;
      existPc.vendor = vendor;
      existPc.price = price;
      notifyListeners();
    });
  }

  Future<void> initalData() async {
    Uri url = Uri.parse("https://http-req-d5914-default-rtdb.firebaseio.com/processors.json");

    var hasilGetData = await http.get(url);
    var dataResponse = json.decode(hasilGetData.body) as Map<String, dynamic>;

    dataResponse.forEach((key, value) {
      _allProcessors.add(
        Processor(id: key,
            name: value["name"],
            vendor: value["vendor"],
            price: value["price"],
        ),
      );
    });
    notifyListeners();
  }
}