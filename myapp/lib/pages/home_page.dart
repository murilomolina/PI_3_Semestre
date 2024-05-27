import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EurekaMap',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Row(
          children: [
            Image.asset(
              'lib/assets/logo/logo_maua_provisorio.jpg',
              fit: BoxFit.cover,                    
            ),
            const SizedBox(width: 8),
            const Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'EurekaMap',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
      body: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreen()),
          );
        },
        child: const Center(
          child: Text(
            'Bem Vindo ao EurekaMap',
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: const Text('Login', style: TextStyle(color: Colors.white)),
      ),
      body: const Center(
        child: Text(
          'Tela de Login',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
