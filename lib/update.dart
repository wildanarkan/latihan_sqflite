import 'package:flutter/material.dart';
import 'package:latihan_sqflite/database_instance.dart';
import 'package:latihan_sqflite/product_model.dart';
import 'package:sqflite/sqflite.dart';

class UpdateScreen extends StatefulWidget {
  final ProductModel? productModel;
  const UpdateScreen({super.key, this.productModel});

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  DatabaseInstance databaseInstance = DatabaseInstance();
  TextEditingController nameC = TextEditingController();
  TextEditingController categoryC = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    databaseInstance.database();
    nameC.text = widget.productModel!.name ?? '';
    categoryC.text = widget.productModel!.category ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("UPDATE"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Name Product"),
            TextField(
              controller: nameC,
            ),
            SizedBox(
              height: 20,
            ),
            Text("Category"),
            TextField(
              controller: categoryC,
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () async {
                  await databaseInstance.update(widget.productModel!.id!,{
                    'name': nameC.text,
                    'category': categoryC.text,
                    'update_at': DateTime.now().toString(),
                  });
                  Navigator.pop(context);
                },
                child: Text("SUBMIT"))
          ],
        ),
      ),
    );
  }
}
