import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'contaCreate.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height -
              kToolbarHeight - MediaQuery.of(context).padding.top,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Color.fromRGBO(33, 150, 243, 1), Color.fromARGB(255, 13, 58, 95)],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20.0),
                _buildLoginForm(),
                const SizedBox(height: 20.0),
                ElevatedButton.icon(
                  icon: Image.asset('assets/google_logo.png', height: 24.0),
                  label: const Text(
                    'Login com conta Google',
                    style: TextStyle(
                      color: Color.fromARGB(255, 13, 58, 95),
                    ),
                  ),
                  onPressed: () {
                    // lógica de login com conta Google
                  },
                ),
                const SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ContaCreate()),
                    );
                  },
                  child: const Text(
                    'Criar Conta',
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

  Widget _buildLoginForm() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 6.0,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'E-mail',
                  hintText: 'Digite o seu e-mail',
                  labelStyle: TextStyle(
                    color: _emailController.text.isEmpty ? Colors.black : Colors.blue,
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blue,
                    ),
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
                style: const TextStyle(
                  color: Colors.black,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o seu e-mail';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Senha',
                  hintText: 'Digite a sua senha',
                  labelStyle: TextStyle(
                    color: _passwordController.text.isEmpty ? Colors.black : Colors.blue,
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blue,
                    ),
                  ),
                ),
                obscureText: true,
                style: const TextStyle(
                  color: Colors.black,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira a sua senha';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20.0),
              TextButton(
                onPressed: () {
                  // Navegar para a página de esqueci minha senha
                },
                child: const Text(
                  'Esqueceu-se da senha?',
                  style: TextStyle(
                    color: Color.fromARGB(255, 5, 67, 117),
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Implementar a lógica de login
                  }
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(const Color.fromARGB(255, 255, 255, 255)),
                ),
                child: const Text(
                  'Entrar',
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
