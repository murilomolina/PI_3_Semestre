import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EurekaMap',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Row(
          children: [
            Image.asset(
              'lib/assets/logo/logo_maua_provisorio.jpg',  
              width: 24,          
              height: 24,         
              color: Colors.white, 
            ),
            SizedBox(width: 8), 
            Text(
              'EurekaMap',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
      body: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()),
          );
        },
        child: Center(
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text('Login', style: TextStyle(color: Colors.white)),
      ),
      body: Center(
        child: Text(
          'Tela de Login',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
