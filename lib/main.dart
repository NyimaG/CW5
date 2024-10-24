//import 'package:cw5/settings.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'fishclass.dart';
import 'aquariumdb.dart';

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

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  List<Fish> fishList = [];
  Timer? timer;
  double selectedSpeed = 5.0;
  Color selectedColor = Colors.red; // Default speed value
  final DatabaseHelper dbHelper = DatabaseHelper();

  @override
  void initState() {
    super.initState();
    _loadSettings();
    timer = Timer.periodic(Duration(milliseconds: 100), (timer) {
      setState(() {
        for (var fish in fishList) {
          fish.updatePosition(
              400, 600); // Update position within the container size
        }
      });
    });
  }

  void _addFish() {
    if (fishList.length < 10) {
      // Limiting to 10 fish
      setState(() {
        fishList.add(Fish(color: selectedColor, speed: selectedSpeed));
        _saveSettings();
      });
    }
  }

  void _saveSettings() async {
    await dbHelper.saveSettings(
        selectedSpeed, selectedColor.value.toRadixString(16), fishList.length);
  }

  void _loadSettings() async {
    final settings = await dbHelper.loadSettings();
    if (settings != null) {
      setState(() {
        selectedSpeed = settings['speed'];
        selectedColor =
            Color(int.parse(settings['color'])); // Convert back to Color
        fishList.length = settings['fishCount'];
      });
    }
  }

  @override
  void dispose() {
    // _saveSettings();
    timer?.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

  // Default speed value
  //List items = [Colors.green, 'Yellow', 'Red', 'Blue'];
  //String? selectedItem = 'Green';
  /*void changeColor() {
    setState(() {
      color = Colors.green;
    });
  }
  */

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
              width: 600,
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(30),
              alignment: Alignment.bottomLeft,
              child: Stack(
                children: fishList.map((fish) {
                  return Positioned(
                    left: fish.position.dx,
                    top: fish.position.dy,
                    child: fishwidget(color: fish.color),
                  );
                }).toList(),
              ),
            ),
            /*Container(
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
                ),*/

            /* Container(
              alignment: Alignment.topCenter,
              child: ElevatedButton(
                onPressed: changeColor,
                child: Text("Change Color"),
              ),
            ),
            */
            Slider(
              value: selectedSpeed,
              min: 1,
              max: 10,
              divisions: 9,
              label: selectedSpeed.round().toString(),
              onChanged: (value) {
                setState(() {
                  selectedSpeed = value;
                  for (var fish in fishList) {
                    fish.setSpeed(selectedSpeed); // Update each fish's speed
                  }
                });
              },
            ),
            DropdownButton<Color>(
              value: selectedColor,
              onChanged: (Color? newColor) {
                setState(() {
                  selectedColor = newColor!;
                });
              },
              items: [Colors.red, Colors.green, Colors.pink].map((color) {
                return DropdownMenuItem<Color>(
                  value: color,
                  child: Container(width: 20, height: 20, color: color),
                );
              }).toList(),
            ),
            /* DropdownButton(
                value: selectedItem,
                items: items
                    .map((item) =>
                        DropdownMenuItem(value: item, child: Text(item)))
                    .toList(),
                onChanged: (item) => setState(() => selectedItem = item),
              ),*/
            SizedBox(height: 15),
            Container(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                onPressed: _addFish,
                child: Text("Add fish"),
              ),
            ),
            SizedBox(height: 15),
            Container(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                onPressed: _saveSettings,
                child: Text("Save Aquarium Settings"),
              ),
            ),
          ],
        ));
  }

  /*@override
  void dispose() {
    timer?.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }
  */
}

class fishwidget extends StatelessWidget {
  final Color color;

  const fishwidget({Key? key, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20,
      height: 10,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20), // Create an oval shape
      ),
    );
  }
}
