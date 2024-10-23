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

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> items = ['Green', 'Yellow', 'Red', 'Blue'];
  String? selectedItem = 'Green';
  Color color = Colors.yellow;
  void changeColor() {
    setState(() {
      color = Colors.green;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange.shade600,
          title: Text("Welcome to Your Aquarium"),
        ),
        body: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              color: Colors.blueAccent.shade700,
              height: 400,
              width: double.infinity,
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(30),
              alignment: Alignment.bottomLeft,
              child: Container(
                height: 60.0,
                width: 60.0,
                child: ColorFiltered(
                  colorFilter: ColorFilter.mode(
                    color,
                    BlendMode.modulate,
                  ),
                  child: const Image(
                    image: AssetImage('assets/fish1.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Container(
              alignment: Alignment.topCenter,
              child: ElevatedButton(
                onPressed: changeColor,
                child: Text("Change Color"),
              ),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              child: DropdownButton(
                value: selectedItem,
                items: items
                    .map((item) =>
                        DropdownMenuItem(value: item, child: Text(item)))
                    .toList(),
                onChanged: (item) => setState(() => selectedItem = item),
              ),
            ),
            SizedBox(height: 15),
            Container(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                onPressed: () {},
                child: Text("Add fish"),
              ),
            ),
          ],
        ));
  }
}
