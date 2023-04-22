import 'dart:ffi';

import 'package:c_flutter_calc/calc_ffi/generated_bindings.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dart C Interop Calculator',
      theme: FlexThemeData.light(
        scheme: FlexScheme.aquaBlue,
        useMaterial3: true,
      ),
      darkTheme: FlexThemeData.dark(
        scheme: FlexScheme.aquaBlue,
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

const List<String> dropdownOptions = <String>['+', '-', '×', '÷'];

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _firstNumberController = TextEditingController();
  final TextEditingController _secondNumberController = TextEditingController();
  String dropdownValue = dropdownOptions.first;
  double answer = 0;
  CalcNativeFFI calcNativeFFI = CalcNativeFFI(
    DynamicLibrary.open('libcalc.dylib'),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dart C Interop Calculator'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          switch (dropdownValue) {
            case "+":
              answer = calcNativeFFI.additon(
                double.parse(_firstNumberController.text),
                double.parse(_secondNumberController.text),
              );
              break;
            case "-":
              answer = calcNativeFFI.subtract(
                double.parse(_firstNumberController.text),
                double.parse(_secondNumberController.text),
              );
              break;
            case "×":
              answer = calcNativeFFI.multiply(
                double.parse(_firstNumberController.text),
                double.parse(_secondNumberController.text),
              );
              break;
            case "÷":
              answer = calcNativeFFI.divide(
                double.parse(_firstNumberController.text),
                double.parse(_secondNumberController.text),
              );
              break;
            default:
              answer = 0;
          }
          setState(() {});
        },
        child: Text(dropdownValue),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 200,
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _firstNumberController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Enter first number',
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    DropdownButton<String>(
                      value: dropdownValue,
                      onChanged: (String? value) {
                        setState(() {
                          dropdownValue = value!;
                          answer = 0;
                        });
                      },
                      items: dropdownOptions.map<DropdownMenuItem<String>>(
                        (String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        },
                      ).toList(),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextField(
                        controller: _secondNumberController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Enter second number',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Text(
                '= ${answer.toStringAsFixed(3)}',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
