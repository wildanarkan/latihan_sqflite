import 'package:flutter/material.dart';
import 'package:latihan_sqflite/create.dart';
import 'package:latihan_sqflite/database_instance.dart';
import 'package:latihan_sqflite/product_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DatabaseInstance databaseInstance = DatabaseInstance();

  Future _refresh () async{
    setState(() {
      
    });
  }

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
        title: Text("SQFLITE"),
        actions: [
          IconButton(onPressed:  () => Navigator.push(context, MaterialPageRoute(builder: (context) => CreateScreen(),)), icon: Icon(Icons.add))
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: FutureBuilder<List<ProductModel>>(
          future: databaseInstance.all(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(snapshot.data![index].name ?? ""),
                  );
                },
              );
            }else{
                return Center(
                  child: Text("Data masih kosong!"),);
            }
          },
        ),
      ),
    );
  }
}
