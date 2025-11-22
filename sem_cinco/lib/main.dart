import 'package:app_sem_cinco/layout/PaginaUno.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(PrimerApp());
}

class PrimerApp extends StatelessWidget {
  //tenemos el primer constructor
  const PrimerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    title :'Aplicacion de Practica',
      //ThemeData es un widget, por lo tanto tiene propiedades
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.limeAccent)
      ),
      home: Scaffold(
      appBar: AppBar(
        title: Text('Titulo del AppBar'),
        backgroundColor: Colors.white70,
        //es tipo wlista widget
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.search)),
          IconButton(onPressed: (){}, icon: Icon(Icons.access_alarm)),
        ]
        ,
      ),

      //body: Text('Esto es el cuerpo o Body'),

        //lo puedo poner como una columna
        /*body: Column(
          children: [
            Text('Esto es el primer texto de body'),
            Text('Otro texto'),
          ],
        ),*/

        body: paginaUno(),


        ),


        
    );
  }
}

/*import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {

      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
*/