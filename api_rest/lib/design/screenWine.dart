import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../infraestructure/models/wine.dart';

class WinePage extends StatefulWidget {
  const WinePage({super.key});

  @override
  State<WinePage> createState() => _WinePageState();
}

class _WinePageState extends State<WinePage> {

  dynamic wine;
  final dio= Dio();
  final List <Wine> wines=[];

  @override
  void initState() {
    getWines();
    super.initState();
  }
/*
  Future <void> getWines() async {
    Wine? wine;
    for (int i=1; i<=20; i++){
      final response = await dio.get("https://api.sampleapis.com/wines/reds/$i");
      final wine = Wine.fromJson(response.data);
      setState(() {
        wines.add(wine);
      });
    }
  }*/
// dart
  Future<void> getWines() async {
    try {
      final response = await dio.get("https://api.sampleapis.com/wines/reds");

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        setState(() {
          wines.addAll(
            data.map((item) => Wine.fromJson(item as Map<String, dynamic>)).toList(),
          );
        });
        print('Vinos cargados: ${wines.length}');
      }
    } on DioException catch (e) {
      print('Error DioException: ${e.message}');
      print('Status: ${e.response?.statusCode}');
    } catch (e) {
      print('Error inesperado: $e');
    }
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wines Home Page'),
        centerTitle: true,
      ),
      body: wines.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: wines.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                leading: Image.network(
                  wines[index].image,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
                title: Text(
                  wines[index].wine,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text('${wines[index].winery} - ${wines[index].location}'),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.star, color: Colors.amber, size: 16),
                   // Text(wines[index].rating.average as String),
                  ],
                ),
              ),
            ),
          );
        },
      ),

    );
  }
}
