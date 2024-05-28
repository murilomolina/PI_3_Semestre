import 'package:flutter/material.dart';
import 'package:myapp/pages/tela_login.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const TelaLogin()),
        );
      },
      child: Scaffold(
        body: Container(
          color: Colors.white,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                const Text(
                  'Bem Vindo ao EurekaMap',
                  style: TextStyle(fontSize: 24),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Clique em qualquer lugar para começar',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}



