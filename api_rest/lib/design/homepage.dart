import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import '../infraestructure/models/pokemon.dart';


class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  dynamic pokemon;

  final dio = Dio();
  final List<Pokemon> pokemons=[];

  @override
  void initState() {
    //getpoke();
    getpokemones();
    super.initState();
    //getapi();
  }

  Future<void> getpokemones() async{
    Pokemon? pokemon;
    for (int i=1; i<=20; i++){
      final response = await dio.get("https://pokeapi.co/api/v2/pokemon/$i");
      final pokemon = Pokemon.fromJson(response.data);
      setState(() {
        pokemons.add(pokemon);
      });
    }
  }

  Future<void> getpoke() async{
    String uri = "https://pokeapi.co/api/v2/pokemon/1";
    final response = await Dio().get(uri);
    pokemon =response.data;

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Poke Home Page'),
          centerTitle: true,
        ),
        body:
        ListView.builder(
            itemCount: pokemons.length,
            itemBuilder: (context,index){

              return ListTile(
                title: Text(pokemons[index].name),
                subtitle: Text(pokemons[index].height.toString()),
                leading: Image.network(pokemons[index].sprites.frontShiny),
              );

            }
        )

      /*Column(
        children: [
          Text(pokemon?['name'] ?? 'no data'),
          Text(pokemon?['height'].toString() ?? 'no data'),
          Text(pokemon?.toString() ?? 'Sin datos'),
        ],
      ),*/
    );
  }
}