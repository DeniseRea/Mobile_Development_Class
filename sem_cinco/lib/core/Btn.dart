import 'package:app_sem_cinco/layout/PaginaDos.dart';
import 'package:flutter/material.dart';

class newBoton extends StatelessWidget {
  final String textito;


  const newBoton({super.key, required this.textito});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.lightGreen,),
            onPressed: (){
            //para ir entre pantallos, usamos navigator
              Navigator.push(context, MaterialPageRoute(builder: (context)=> pagina_dos()));
            },
        child:  Text(textito));

  }
}
