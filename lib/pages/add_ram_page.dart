import 'package:coba_firebase/providers/rams.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddRam extends StatelessWidget{
  static const routeName = "/add-ram";
  final TextEditingController nameController = TextEditingController();
  final TextEditingController sizeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final rams = Provider.of<Rams>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text("ADd Rams"),
        actions: [
          IconButton(
          icon: Icon(Icons.save),
            onPressed: () {
              rams.addRam(
                nameController.text,
                int.parse(sizeController.text),
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
                decoration: InputDecoration(labelText: "Price"),
                textInputAction: TextInputAction.next,
                controller: sizeController,
              ),
              SizedBox(height: 50),
              Container(
                width: double.infinity,
                alignment: Alignment.centerRight,
                child: OutlinedButton(
                  onPressed: () {
                    rams.addRam(
                      nameController.text,
                      int.parse(sizeController.text),
                      context,
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