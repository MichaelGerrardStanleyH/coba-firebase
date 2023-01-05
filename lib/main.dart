import 'package:coba_firebase/pages/add_ram_page.dart';
import 'package:coba_firebase/providers/rams.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Rams(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomePage(),
        routes: {
          AddRam.routeName: (context) => AddRam(),
        },
      ),
    );
  }
}

