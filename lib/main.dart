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
  DatabaseInstance? databaseInstance;

  Future _refresh() async {
    setState(() {});
  }

  Future initDatabase() async {
    await databaseInstance!.database();
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    databaseInstance = DatabaseInstance();
    initDatabase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SQFLITE"),
        actions: [
          IconButton(
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CreateScreen(),
                  )).then((value) => setState(() {})),
              icon: Icon(Icons.add))
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: databaseInstance != null
            ? FutureBuilder<List<ProductModel>>(
                future: databaseInstance!.all(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data == 0)
                      return Center(
                        child: Text("Data masih kosong!"),
                      );
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(snapshot.data![index].name ?? ""),
                          subtitle: Text(snapshot.data![index].category ?? ""),
                        );
                      },
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(
                        color: Colors.amber,
                      ),
                    );
                  }
                },
              )
            : Center(
                child: CircularProgressIndicator(
                  color: Colors.amber,
                ),
              ),
      ),
    );
  }
}
