import 'package:coba_firebase/providers/processors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/ram.dart';
import '../providers/pcs.dart';
import '../providers/rams.dart';
import '../models/FormData.dart';

class PcBuild extends StatefulWidget{
  static const routeName = "/pc-build";

  @override
  State<PcBuild> createState() => _PcBuildState();
}

class _PcBuildState extends State<PcBuild> {

  bool isNanti = true;
  @override
  void didChangeDependencies() {
    print("test did");
    if(isNanti){
      Provider.of<Rams>(context).initalData();
      Provider.of<Processors>(context).initalData();
    }
    isNanti = false;


    super.didChangeDependencies();
  }

  String dropdownValue = "null";
  String dropdownValue2 = "null";

  @override
  Widget build(BuildContext context) {

    final pcs = Provider.of<Pcs>(context);
    final rams = Provider.of<Rams>(context);
    final processors = Provider.of<Processors>(context);

    var formData = ModalRoute.of(context)!.settings.arguments as FormData;

    print("test");
    print(rams.allRam);
    print(processors.allProcessor);

    List<String> allRamsName = [];

    rams.allRam.forEach((element) {
      allRamsName.add(element.name);
    });

    var seen = Set<String>();
    List<String> uniqueList = allRamsName.where((ram) => seen.add(ram)).toList();

    if(dropdownValue.contains("null")){
      dropdownValue = uniqueList[0];
    }


    List<String> allProcessorsName = [];

    processors.allProcessor.forEach((element) {
      allProcessorsName.add(element.name);
    });

    var seenProcessor = Set<String>();
    List<String> uniqueListProcessors = allProcessorsName.where((processor) => seenProcessor.add(processor)).toList();


    if(dropdownValue2.contains("null")){
      dropdownValue2 = uniqueListProcessors[0];
    }

    // print(uniqueList);
    print(uniqueListProcessors);

    return Scaffold(
      appBar: AppBar(
        title: Text("PC BUILD"),
      ),
      body: Container(
          // margin: const EdgeInsets.all(20.0),
          padding:  const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children:  [
            DropdownButton<String>(
              isExpanded: true,
            value: dropdownValue,
            icon: const Icon(Icons.arrow_downward),
            elevation: 16,
            style: const TextStyle(color: Colors.deepPurple),
            underline: Container(
              height: 2,
              color: Colors.deepPurpleAccent,
            ),
            onChanged: (String? value) {
              // This is called when the user selects an item.
              setState(() {
                dropdownValue = value!;
                pcs.editPc(formData.id, pcs.selectById(formData.id).processor, dropdownValue, context).then((_) {
                  setState(() {
                  });
                });
              });
            },
            items: uniqueList.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Center(child: Text(value)),
              );
            }).toList(),
            ),
              Container(
                height: 50,
                margin: const EdgeInsets.all(15.0),
                child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children:  [
                DropdownButton<String>(
                isExpanded: true,
                value: dropdownValue2,
                icon: const Icon(Icons.arrow_downward),
                elevation: 16,
                style: const TextStyle(color: Colors.deepPurple),
                underline: Container(
                  height: 2,
                  color: Colors.deepPurpleAccent,
                ),
                onChanged: (String? value) {
                  // This is called when the user selects an item.
                  setState(() {
                    dropdownValue2 = value!;
                    uniqueListProcessors.add(dropdownValue2);
                    pcs.editPc(formData.id, dropdownValue2, pcs.selectById(formData.id).ram, context).then((_) {
                      setState(() {
                      });
                    });
                  });
                },
                items: uniqueListProcessors.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Center(child: Text(value)),
                  );
                }).toList(),
              ),
              ])),
              Container(
                height: 40,
                margin: const EdgeInsets.all(15.0),
                color: Colors.greenAccent,
                child: const Center(child: Text("Ram")),
              ),
            ],
          ),
        ),
      );
  }
}
