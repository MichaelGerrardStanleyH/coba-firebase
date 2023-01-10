import 'package:coba_firebase/models/pc.dart';
import 'package:coba_firebase/providers/motherboards.dart';
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
    if(isNanti){
      Provider.of<Rams>(context).initalData();
      Provider.of<Processors>(context).initalData();
      Provider.of<Motherboards>(context).initalData();
    }
    isNanti = false;


    super.didChangeDependencies();
  }


  @override
  Widget build(BuildContext context) {
    // var for dropdown
    String dropdownValueRam, dropdownValueProcessor, dropdownValueMotherboard;

    // providers
    final pcs = Provider.of<Pcs>(context);
    final rams = Provider.of<Rams>(context);
    final processors = Provider.of<Processors>(context);
    final motherboards = Provider.of<Motherboards>(context);

    var formData = ModalRoute.of(context)!.settings.arguments as FormData;
    
    // existPc from id
    Pc existPc = pcs.selectById(formData.id);
    
    // all list
    var allMotherboard = motherboards.allMotherboard;
    var allProcessor = processors.allProcessor;
    var allRam = rams.allRam;

    // pricing
    var processorInitialPrice = processors.selectByName(existPc.processor).price;
    var motherboardInitialPrice = motherboards.selectByName(existPc.motherboard).price;
    var ramInitialPrice = rams.selectByName(existPc.ram).price;
    
    int processorsPrice = processorInitialPrice;
    int motherboardPrice = motherboardInitialPrice;
    int ramPrice = ramInitialPrice;

    // processor
    List<String> allProcessorsName = [];

    processors.allProcessor.forEach((element) {
      allProcessorsName.add(element.name);
    });

    var seenProcessor = Set<String>();
    List<String> uniqueListProcessors = allProcessorsName.where((processor) => seenProcessor.add(processor)).toList();


    if(existPc.processor != "null"){
      dropdownValueProcessor = existPc.processor;
    }
    else{
      dropdownValueProcessor = uniqueListProcessors[0];
    }


    // motherboard
    List<String> allMotherboardName = [];

    var procieVendor = processors.selectByName(dropdownValueProcessor);

    var moboVendor = allMotherboard.where((element) => element.vendor == procieVendor.vendor);

    moboVendor.forEach((element) {
      allMotherboardName.add(element.name);
    });


    var seenMotherboards = Set<String>();
    List<String> uniqueListMotherboard = allMotherboardName.where((motherboard) => seenMotherboards.add(motherboard)).toList();


    if(motherboards.selectByName(existPc.motherboard).vendor != processors.selectByName(dropdownValueProcessor).vendor){
      dropdownValueMotherboard = moboVendor.first.name;
      motherboardPrice = motherboards.selectByName(dropdownValueMotherboard).price;
    }else if(motherboards.selectByName(existPc.motherboard).vendor == processors.selectByName(dropdownValueProcessor).vendor)
      {
        dropdownValueMotherboard = existPc.motherboard;
      }
    else{
      dropdownValueMotherboard = uniqueListMotherboard[0];
    }

    // ram
    List<String> allRamsName = [];

    rams.allRam.forEach((element) {
      allRamsName.add(element.name);
    });

    var seen = Set<String>();
    List<String> uniqueList = allRamsName.where((ram) => seen.add(ram)).toList();

    if(existPc.ram != "null"){
      dropdownValueRam = existPc.ram;
    }
    else{
      dropdownValueRam = uniqueList[0];
    }


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
              // processor
                DropdownButton<String>(
                isExpanded: true,
                value: dropdownValueProcessor,
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
                    dropdownValueProcessor = value!;
                    processorsPrice = processors.selectByName(dropdownValueProcessor).price;
                    uniqueListProcessors.add(dropdownValueProcessor);
                    pcs.editPc(formData.id, dropdownValueProcessor, existPc.ram, existPc.motherboard, context).then((_) {
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
              // motherboard
              DropdownButton<String>(
                isExpanded: true,
                value: dropdownValueMotherboard,
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
                    dropdownValueMotherboard = value!;
                    motherboardPrice = motherboards.selectByName(dropdownValueMotherboard).price;
                    uniqueListMotherboard.add(dropdownValueMotherboard);
                    pcs.editPc(formData.id, existPc.processor, existPc.ram, dropdownValueMotherboard, context).then((_) {
                      setState(() {
                      });
                    });
                  });
                },
                items: uniqueListMotherboard.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Center(child: Text(value)),
                  );
                }).toList(),
              ),
              // ram
              DropdownButton<String>(
                isExpanded: true,
                value: dropdownValueRam,
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
                    dropdownValueRam = value!;
                    ramPrice = rams.selectByName(dropdownValueRam).price;
                    pcs.editPc(formData.id, existPc.processor, dropdownValueRam, existPc.motherboard, context).then((_) {
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
                padding: const EdgeInsets.all(10.0),
                margin: const EdgeInsets.all(15.0),
                color: Colors.greenAccent,
                child: Wrap(
                  children: [
                    Center(child: Text("$processorsPrice")),
                    Center(child: Text("$motherboardPrice")),
                    Center(child: Text("$ramPrice"),)
                  ],
                ),
              )
            ]
          ),
      )
    );
  }
}
