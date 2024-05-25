//login.dart
import 'package:flutter/material.dart';
import 'contaCreate.dart';

class LoginPage extends StatelessWidget {
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
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [const Color.fromRGBO(33, 150, 243, 1), Color.fromARGB(255, 13, 58, 95)],
          ),
        ),
        child: Form(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 20.0),
                _buildLoginForm(context),
                SizedBox(height: 20.0),
                SizedBox(height: 20.0),
                ElevatedButton.icon(
                  icon: Image.asset('assets/google_logo.png', height: 24.0),                   
                  label: Text('Login com conta Google',
                    style: TextStyle(
                      color: Color.fromARGB(255, 13, 58, 95),
                    ),
                  ),
                  onPressed: () {
                    //lógica de login com conta Google ou route para uma página de login com conta Google
                  },
                ),
                SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ContaCreate()),
                    );
                  },
                  child: Text('Criar Conta',
                    style: TextStyle(
                      color: Color.fromARGB(255, 13, 58, 95),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoginForm(BuildContext context) {
    return Container(
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(10.0),
    boxShadow: [
      BoxShadow(
        color: Colors.black26,
        blurRadius: 6.0,
        offset: Offset(0, 2),
      ),
    ],
  ),
  child: Form(
    child: Padding(
      padding: EdgeInsets.all(20.0),
      child: Column(
        children: <Widget>[
          Theme(
            data: Theme.of(context).copyWith(
              inputDecorationTheme: InputDecorationTheme(
                hintStyle: TextStyle(color: Colors.black),
                labelStyle: TextStyle(color: Colors.black),
              ),
            ),
            child: TextFormField(
              decoration: InputDecoration(
                labelText: 'E-mail',
                hintText: 'Digite seu e-mail',
              ),
              keyboardType: TextInputType.emailAddress,
              style: TextStyle(
                color: Colors.black,
              ),  
              //lógica para guardar o e-mail
            ),
          ),
          SizedBox(height: 20.0),
          Theme(
            data: Theme.of(context).copyWith(
              inputDecorationTheme: InputDecorationTheme(
                hintStyle: TextStyle(color: Colors.black),
                labelStyle: TextStyle(color: Colors.black), 
              ),
            ),
            child: TextFormField(
              decoration: InputDecoration(
                labelText: 'Senha',
                hintText: 'Digite sua senha',
              ),
              obscureText: true,
              style: TextStyle(
                color: Colors.black, 
              ),
              // lógica para guardar a senha
            ),
          ),
          SizedBox(height: 20.0),
          TextButton(
            onPressed: () {/*
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ForgotPasswordPage()),
              );*/
            },
            child: Text(
              'Esqueceu-se da senha?',
              style: TextStyle(
                color: const Color.fromARGB(255, 5, 67, 117),
              ),
            ),
          ),
          SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: () {
              // Implementar a lógica de login aqui
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255, 255, 255, 255)),
            ),
            child: Text('Entrar',
                    style: TextStyle(
                      color: Color.fromARGB(255, 13, 58, 95),
                    ),
                  ),
          ),
        ],
      ),
    ),
  ),
);
}
}