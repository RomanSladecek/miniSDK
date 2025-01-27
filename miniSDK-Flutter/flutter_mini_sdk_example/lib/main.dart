import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Flutter SDK Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: const Text('Show Form'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const FormViewScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class FormViewScreen extends StatelessWidget {
  const FormViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('iOS Form View')),
      body: Center(
        child: SizedBox(
          width: 500,
          height: 800,
          child: Platform.isIOS
              ? UiKitView(
            viewType: 'mini_sdk_view',
            creationParams: <String, dynamic>{
              'apiEndpoint': 'https://api.example.com/form',
            },
            creationParamsCodec: const StandardMessageCodec(),
          )
              : const Text('iOS only view'),
        ),
      ),
    );
  }
}