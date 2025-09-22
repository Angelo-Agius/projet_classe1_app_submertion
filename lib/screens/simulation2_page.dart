import 'package:flutter/material.dart';

class Simulation2Page extends StatefulWidget {
  const Simulation2Page({super.key});

  @override
  State<Simulation2Page> createState() => _Simulation2PageState();
}

class _Simulation2PageState extends State<Simulation2Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Simulation 2 Page'),
          ElevatedButton(
            onPressed: () {
              
            },
            child: const Text('Start AR Experience'),
          ),
        ],
      ),)),
    );
  }
}
