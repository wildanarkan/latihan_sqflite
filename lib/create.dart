import 'package:flutter/material.dart';
import 'package:latihan_sqflite/database_instance.dart';
import 'package:sqflite/sqflite.dart';

class CreateScreen extends StatefulWidget {
  const CreateScreen({super.key});

  @override
  State<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  DatabaseInstance databaseInstance = DatabaseInstance();
  TextEditingController nameC = TextEditingController();
  TextEditingController categoryC = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    databaseInstance.database();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CREATE"),
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
                  await databaseInstance.insert({
                    'name': nameC.text,
                    'category': categoryC.text,
                    'created_at': DateTime.now().toString(),
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
