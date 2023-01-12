import 'package:coba_firebase/models/pc.dart';
import 'package:coba_firebase/providers/motherboards.dart';
import 'package:coba_firebase/providers/processors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/ram.dart';
import '../providers/pcs.dart';
import '../providers/psus.dart';
import '../providers/rams.dart';
import '../models/FormData.dart';
import '../providers/storages.dart';
import '../providers/vgas.dart';

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
      Provider.of<Vgas>(context).initalData();
      Provider.of<Storages>(context).initalData();
      Provider.of<Psus>(context).initalData();
    }
    isNanti = false;


    super.didChangeDependencies();
  }


  @override
  Widget build(BuildContext context) {
    // var for dropdown
    String dropdownValueRam,
        dropdownValueProcessor,
        dropdownValueMotherboard,
        dropdownValueVga,
        dropdownValueStorage,
        dropdownValuePsu;;

    // providers
    final pcs = Provider.of<Pcs>(context);
    final rams = Provider.of<Rams>(context);
    final processors = Provider.of<Processors>(context);
    final motherboards = Provider.of<Motherboards>(context);
    final vgas = Provider.of<Vgas>(context);
    final storages = Provider.of<Storages>(context);
    final psus = Provider.of<Psus>(context);

    // print(vgas.allVga.first.name);

    var formData = ModalRoute.of(context)!.settings.arguments as FormData;
    
    // existPc from id
    Pc existPc = pcs.selectById(formData.id);
    
    // all list
    var allMotherboard = motherboards.allMotherboard;
    var allProcessor = processors.allProcessor;
    var allRam = rams.allRam;

    // pricing

    int processorInitialPrice = 0;
    int motherboardInitialPrice = 0;
    int ramInitialPrice = 0;
    int vgaInitialPrice = 0;
    int storageInitalPrice = 0;
    int psuIntialPrice = 0;

    if(existPc.processor != "null")
      processorInitialPrice = processors.selectByName(existPc.processor).price;

    if(existPc.motherboard != "null")
      motherboardInitialPrice = motherboards.selectByName(existPc.motherboard).price;

    if(existPc.ram != "null")
      ramInitialPrice = rams.selectByName(existPc.ram).price;

    if(existPc.vga != "null")
      vgaInitialPrice = vgas.selectByName(existPc.vga).price;

    if(existPc.storage != "null")
      storageInitalPrice = storages.selectByName(existPc.storage).price;

    if(existPc.psu != "null")
      psuIntialPrice = psus.selectByName(existPc.psu).price;


    
    int processorsPrice = processorInitialPrice;
    int motherboardPrice = motherboardInitialPrice;
    int ramPrice = ramInitialPrice;
    int vgaPrice = vgaInitialPrice;
    int storagePrice = storageInitalPrice;
    int psuPrice = psuIntialPrice;

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

    if(existPc.processor != "null" && existPc.motherboard != "null"){
      if(motherboards.selectByName(existPc.motherboard).vendor != processors.selectByName(dropdownValueProcessor).vendor){
        dropdownValueMotherboard = moboVendor.first.name;
        setState(() {
            pcs.editPc(formData.id, existPc.processor, existPc.ram, dropdownValueMotherboard, existPc.vga, existPc.storage, existPc.psu, context);
          });
        motherboardPrice = motherboards.selectByName(dropdownValueMotherboard).price;
      }else if(motherboards.selectByName(existPc.motherboard).vendor == processors.selectByName(dropdownValueProcessor).vendor)
      {
        dropdownValueMotherboard = existPc.motherboard;
      }
      else{
        dropdownValueMotherboard = uniqueListMotherboard[0];
      }
    }else{
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

    // vga
    List<String> allVgasName = [];

    vgas.allVga.forEach((element) {
      allVgasName.add(element.name);
    });

    var seenVga = Set<String>();
    List<String> uniqueListVga = allVgasName.where((vga) => seenVga.add(vga)).toList();

    if(existPc.vga != "null"){
      dropdownValueVga = existPc.vga;
    }
    else{
      dropdownValueVga = uniqueListVga[0];
    }

    // storage
    List<String> allStoragesName = [];

    storages.allStorage.forEach((element) {
      allStoragesName.add(element.name);
    });

    var seenStorage = Set<String>();
    List<String> uniqueListStorage = allStoragesName.where((storage) => seenVga.add(storage)).toList();

    if(existPc.storage != "null"){
      dropdownValueStorage = existPc.storage;
    }
    else{
      dropdownValueStorage = uniqueListStorage[0];
    }

    // psu
    List<String> allPsusName = [];

    psus.allPsu.forEach((element) {
      allPsusName.add(element.name);
    });

    var seenPsu = Set<String>();
    List<String> uniqueListPsu = allPsusName.where((psu) => seenPsu.add(psu)).toList();

    if(existPc.psu != "null"){
      dropdownValuePsu = existPc.psu;
    }
    else{
      dropdownValuePsu = uniqueListPsu[0];
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
              Container(
                margin: EdgeInsets.only(bottom: 20),
                child: Wrap(
                  children: [
                    Text("Processor"),
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
                          pcs.editPc(formData.id, dropdownValueProcessor, existPc.ram, existPc.motherboard, existPc.vga, existPc.storage, existPc.psu, context).then((_) {
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
                  ],
                ),
              ),
              // motherboard
              Container(
                margin: EdgeInsets.only(bottom: 20),
                child: Wrap(
                  children: [
                    Text("Motherboard"),
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
                          pcs.editPc(formData.id, existPc.processor, existPc.ram, dropdownValueMotherboard, existPc.vga, existPc.storage, existPc.psu, context).then((_) {
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
                  ],
                ),
              ),
              // ram
              Container(
                margin: EdgeInsets.only(bottom: 20),
                child: Wrap(
                  children: [
                    Text("Ram"),
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
                          pcs.editPc(formData.id, existPc.processor, dropdownValueRam, existPc.motherboard, existPc.vga, existPc.storage, existPc.psu, context).then((_) {
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
                  ],
                ),
              ),
              // vga
              Container(
                margin: EdgeInsets.only(bottom: 20),
                child: Wrap(
                  children: [
                    Text("Vga"),
                    DropdownButton<String>(
                      isExpanded: true,
                      value: dropdownValueVga,
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
                          dropdownValueVga = value!;
                          vgaPrice = vgas.selectByName(dropdownValueVga).price;
                          pcs.editPc(formData.id, existPc.processor, existPc.ram, existPc.motherboard, dropdownValueVga, existPc.storage, existPc.psu, context).then((_) {
                            setState(() {
                            });
                          });
                        });
                      },
                      items: uniqueListVga.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Center(child: Text(value)),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
              // storage
              Container(
                margin: EdgeInsets.only(bottom: 20),
                child: Wrap(
                  children: [
                    Text("Storage"),
                    DropdownButton<String>(
                      isExpanded: true,
                      value: dropdownValueStorage,
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
                          dropdownValueStorage = value!;
                          storagePrice = storages.selectByName(dropdownValueStorage).price;
                          pcs.editPc(formData.id, existPc.processor, existPc.ram, existPc.motherboard, existPc.vga, dropdownValueStorage, existPc.psu, context).then((_) {
                            setState(() {
                            });
                          });
                        });
                      },
                      items: uniqueListStorage.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Center(child: Text(value)),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
              // psu
              Container(
                margin: EdgeInsets.only(bottom: 20),
                child: Wrap(
                  children: [
                    Text("PSU",),
                    DropdownButton<String>(
                      isExpanded: true,
                      value: dropdownValuePsu,
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
                          dropdownValuePsu = value!;
                          psuPrice = psus.selectByName(dropdownValuePsu).price;
                          pcs.editPc(formData.id, existPc.processor, existPc.ram, existPc.motherboard, existPc.vga, existPc.storage, dropdownValuePsu, context).then((_) {
                            setState(() {
                            });
                          });
                        });
                      },
                      items: uniqueListPsu.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Center(child: Text(value)),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10.0),
                margin: const EdgeInsets.all(15.0),
                color: Colors.greenAccent,
                child: Wrap(
                  children: [
                    Center(child: Text("$processorsPrice")),
                    Center(child: Text("$motherboardPrice")),
                    Center(child: Text("$ramPrice"),),
                    Center(child: Text("$vgaPrice"),),
                    Center(child: Text("$storagePrice"),),
                    Center(child: Text("$psuPrice"),),
                  ],
                ),
              )
            ]
          ),
      )
    );
  }
}
