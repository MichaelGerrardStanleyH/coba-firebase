import 'package:coba_firebase/models/processor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/processors.dart';

class AddProcessor extends StatelessWidget{
  static const routeName = "/add-processor";
  final TextEditingController nameController = TextEditingController();
  final TextEditingController vendorController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final processors = Provider.of<Processors>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text("ADd RAMS"),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              processors.addProcessor(
                  nameController.text,
                  vendorController.text,
                  int.parse(priceController.text),
                  context
              );
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          child: Column(
            children: [
              TextFormField(
                autocorrect: false,
                autofocus: true,
                decoration: InputDecoration(labelText: "Name"),
                textInputAction: TextInputAction.next,
                controller: nameController,
              ),
              TextFormField(
                autocorrect: false,
                decoration: InputDecoration(labelText: "Vendor"),
                textInputAction: TextInputAction.next,
                controller: vendorController,
              ),
              TextFormField(
                autocorrect: false,
                decoration: InputDecoration(labelText: "Price"),
                textInputAction: TextInputAction.next,
                controller: priceController,
              ),
              SizedBox(height: 50),
              Container(
                width: double.infinity,
                alignment: Alignment.centerRight,
                child: OutlinedButton(
                  onPressed: () {
                    processors.addProcessor(
                        nameController.text,
                        vendorController.text,
                        int.parse(priceController.text),
                        context
                    ).then((response) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Berhasil Ditambahkan"),
                          duration: Duration(seconds: 2),
                        ),
                      );
                      Navigator.pop(context);
                    });
                  },
                  child: Text(
                    "Submit",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}