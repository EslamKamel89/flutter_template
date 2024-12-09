import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ModernDropdownScreen(),
    );
  }
}

class ModernDropdownScreen extends StatefulWidget {
  @override
  _ModernDropdownScreenState createState() => _ModernDropdownScreenState();
}

class _ModernDropdownScreenState extends State<ModernDropdownScreen> {
  final List<String> items = [
    'Option 1',
    'Option 2',
    'Option 3',
    'Option 4',
  ];

  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Modern Dropdown UI'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: DropdownButtonFormField<String>(
            value: selectedValue,
            isExpanded: true,
            icon: const Icon(Icons.keyboard_arrow_down_rounded, color: Colors.blue),
            decoration: InputDecoration(
              labelText: 'Select an Option',
              labelStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.blue, width: 1.5),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.blue, width: 2),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            ),
            items: items
                .map((item) => DropdownMenuItem<String>(
                      value: item,
                      child: Text(item, style: const TextStyle(fontSize: 16)),
                    ))
                .toList(),
            onChanged: (value) {
              setState(() {
                selectedValue = value;
              });
            },
            validator: (value) => value == null ? 'Please select an option' : null,
          ),
        ),
      ),
    );
  }
}
