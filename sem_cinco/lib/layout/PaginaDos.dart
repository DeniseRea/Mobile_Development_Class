import 'package:flutter/material.dart';

class pagina_dos extends StatelessWidget {
  const pagina_dos({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(

        width: 50,
        //crossAxisAlignment: CrossAxisAlignment.start,
        child: Column(
          children: [
            Text('Esto es de la pagina dos'),
            Text('Otro texto igual de la pagina dos '),
           // newBoton(textito: "este es el texto del button"),
          ],
        )

    );
  }
}
