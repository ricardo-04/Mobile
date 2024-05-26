//welcome_page.dart
import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(),
        flexibleSpace: Align(
          alignment: Alignment.center,
          child: Image.asset('assets/logo-softinsa.png', fit: BoxFit.cover, height: kToolbarHeight),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Colors.blue, Color.fromARGB(255, 14, 2, 73)],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Bem-vindo!',
                style: TextStyle(
                  fontSize: 32.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/login'); // Navegar para a página de login
                },
                child: const Text('Entrar',
                style: TextStyle(
                  color: Color.fromARGB(255, 13, 58, 95),
                ),
                )
              ),
            ],
          ),
        ),
      ),
    );
  }
}