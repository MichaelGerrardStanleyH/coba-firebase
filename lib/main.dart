import 'package:coba_firebase/pages/add_motherboard_page.dart';
import 'package:coba_firebase/pages/add_pc_page.dart';
import 'package:coba_firebase/pages/add_processor_page.dart';
import 'package:coba_firebase/pages/add_psu_page.dart';
import 'package:coba_firebase/pages/add_ram_page.dart';
import 'package:coba_firebase/pages/add_storage_page.dart';
import 'package:coba_firebase/pages/add_user_page.dart';
import 'package:coba_firebase/pages/add_vga_page.dart';
import 'package:coba_firebase/pages/pc_build_page.dart';
import 'package:coba_firebase/providers/motherboards.dart';
import 'package:coba_firebase/providers/pcs.dart';
import 'package:coba_firebase/providers/processors.dart';
import 'package:coba_firebase/providers/psus.dart';
import 'package:coba_firebase/providers/rams.dart';
import 'package:coba_firebase/providers/storages.dart';
import 'package:coba_firebase/providers/users.dart';
import 'package:coba_firebase/providers/vgas.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './pages/user_pc_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Rams(),),
            ListenableProvider(create: (context) => Pcs()),
            ListenableProvider(create: (context) => Processors()),
            ListenableProvider(create: (context) => Motherboards()),
            ListenableProvider(create: (context) => Vgas()),
            ListenableProvider(create: (context) => Storages()),
            ListenableProvider(create: (context) => Psus()),
            ListenableProvider(create: (context) => Users()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: AddUser(),
        routes: {
          PcBuild.routeName: (context) => PcBuild(),
          AddRam.routeName: (context) => AddRam(),
          AddPc.routeName: (context) => AddPc(),
          AddProcessor.routeName: (context) => AddProcessor(),
          AddMotherboard.routeName: (context) => AddMotherboard(),
          AddVga.routeName: (context) => AddVga(),
          AddStorage.routeName: (context) => AddStorage(),
          AddPsu.routeName: (context) => AddPsu(),
          UserPage.routeName: (context) => UserPage(),
        },
      ),
    );
  }
}

