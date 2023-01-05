import 'package:coba_firebase/models/ram.dart';
import 'package:coba_firebase/pages/add_pc_page.dart';
import 'package:coba_firebase/pages/add_ram_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/rams.dart';

class HomePage extends StatefulWidget{

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isInit = true;
  @override
  void didChangeDependencies() {
    if(isInit){
      Provider.of<Rams>(context).initalData();
    }
    isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {

    final allRamsProvider = Provider.of<Rams>(context);

    List<String> allRamName = [];

    allRamsProvider.allRam.forEach((element) {
      allRamName.add(element.name);
    });



    String dropDownValue = allRamsProvider.allRam.first.id;

    return Scaffold(
      appBar: AppBar(
        title: Text("All PC"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
                Navigator.pushNamed(context, AddPc.routeName);
            },
          ),
          IconButton(
            icon: Icon(Icons.remove_red_eye_outlined),
            onPressed: () {
              allRamsProvider.initalData().then((_) {
                setState(() {});
              });
            },
          )
        ],
      ),
      body: (allRamsProvider.jumlahRam == 0) ?
      Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "No Data",
              style: TextStyle(fontSize: 25),
            ),
            SizedBox(height: 20),
            OutlinedButton(
              onPressed: () {
                Navigator.pushNamed(context, AddRam.routeName);
              },
              child: Text(
                "Add Player",
                style: TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
      ) : ListView.builder(
        itemCount: allRamsProvider.jumlahRam,
        itemBuilder:(BuildContext context, int index) {
          String dropDownValue = allRamName.first;
          return GestureDetector(
            child: Container(
              child: Text(allRamsProvider.allRam[index].name),
            ),
            onTap: (){
                print(allRamsProvider.allRam[index].name);
            },
          );
        }
      )
    );
  }
}