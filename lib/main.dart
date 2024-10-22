import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Virtual Aquarium',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: 'Virtual Aquarium'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  //State<MyHomePage> createState() => _MyHomePageState();

  //class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange.shade600,
        title: Text("Welcome toa Your Aquarium"),
      ),
      body: Container(
        color: Colors.blueAccent.shade700,
        height: 500,
        width: double.infinity,
        margin: const EdgeInsets.all(20),
        padding: const EdgeInsets.all(30),
        //decoration: BoxDecoration(
        //border: Border.all(color: Colors.black, width: 3),
        //),
        child: const Text("Hello! i am inside a container!",
            style: TextStyle(fontSize: 20)),
      ),
    );
  }
}
