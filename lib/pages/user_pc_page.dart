import 'package:coba_firebase/pages/add_motherboard_page.dart';
import 'package:coba_firebase/pages/add_pc_page.dart';
import 'package:coba_firebase/pages/add_processor_page.dart';
import 'package:coba_firebase/pages/add_ram_page.dart';
import 'package:coba_firebase/pages/pc_build_page.dart';
import 'package:coba_firebase/providers/rams.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/pcs.dart';
import '../models/FormData.dart';


class UserPage extends StatefulWidget{

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  bool isInit = true;
  @override
  void didChangeDependencies() {
    if(isInit){
      Provider.of<Pcs>(context).initalData();
    }
    isInit = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    isInit = true;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {


    final allPcsProvider = Provider.of<Pcs>(context, listen: false);


    print(allPcsProvider);

    List<String> allPcName = [];

    allPcsProvider.allPc.forEach((element) {
      allPcName.add(element.name);
    });


    return Scaffold(
      appBar: AppBar(
        title: Text("All PC"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
                Navigator.pushNamed(context, AddPc.routeName,);
            },
          ),
          IconButton(
            icon: Icon(Icons.remove_red_eye_outlined),
            onPressed: () {
                Navigator.pushNamed(context, AddRam.routeName);
              },
          ),
          IconButton(
            icon: Icon(Icons.abc),
            onPressed: () {
              Navigator.pushNamed(context, AddProcessor.routeName);
            },
          ),
          IconButton(
            icon: Icon(Icons.baby_changing_station),
            onPressed: () {
              Navigator.pushNamed(context, AddMotherboard.routeName);
            },
          ),
        ],
      ),
      body: (allPcsProvider.jumlahPc == 0) ?
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
      ) : Padding(
          padding:  const EdgeInsets.all(20.0),
          child: ListView.builder(
              itemCount: allPcsProvider.jumlahPc,
              itemBuilder:(BuildContext context, int index) {
                String dropDownValue = allPcName.first;
                return GestureDetector(
                    child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: GestureDetector(
                          child: Container(
                              height: 50,
                              color: Colors.blueAccent,
                              child: Center(
                                child: Text(allPcsProvider.allPc[index].name),
                              )
                          ),
                          onTap: (){
                            Navigator.pushNamed(context, PcBuild.routeName
                                ,arguments: FormData(id: allPcsProvider.allPc[index].id),
                            );
                          },
                        ))
                );
              }
          ),
      )
    );
  }
}