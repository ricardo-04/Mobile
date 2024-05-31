//main.dart
import 'package:flutter/material.dart';
import 'login.dart';
import 'welcome_page.dart';
import 'contaCreate.dart';
import 'eventosPage.dart';
import 'package:flutter_application_1/drawer/definicoes.dart';
//import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_core/firebase_core.dart';

void main() /*async*/ { //adicionar a palavra-chave async aqui
  WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp(); 
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bem-vindo...',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/', //welcome_page
      routes: {
        '/': (context) => WelcomePage(), //welcome_page
        '/login': (context) => LoginPage(), //login
        '/contaCreate': (context) => ContaCreate(), //contaCreate
        '/eventosPage': (context) => EventosPage(), //eventosPage
        '/definicoes': (context) => SettingsPage(), //definicoes
      },
    );
  }
}