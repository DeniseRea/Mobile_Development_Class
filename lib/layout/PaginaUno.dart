/*
* Hay que tener en cuenta que función va a cumplir
* si es statefull o less
* */
import 'package:flutter/material.dart';

import '../core/Btn.dart';

class paginaUno extends StatefulWidget {
  const paginaUno({super.key});

  @override
  State<paginaUno> createState() => _paginaUnoState();
}

class _paginaUnoState extends State<paginaUno> {
  @override
  Widget build(BuildContext context) {
    return Container(

      width: 50,
        //crossAxisAlignment: CrossAxisAlignment.start,
        child: Column(
          children: [
            Text('Esto es el primer texto de body'),
            Text('Otro texto'),
            newBoton(textito: "este es el texto del button"),
          ],
        )

    );
  }
}
