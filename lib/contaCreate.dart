//contaCreate.dart
import 'package:flutter/material.dart';
import 'login.dart';


class ContaCreate extends StatefulWidget {
  @override
  _ContaCreateState createState() => _ContaCreateState();
}

class _ContaCreateState extends State<ContaCreate> {
  final _formKey = GlobalKey<FormState>();
  final _primeiroNomeController = TextEditingController();
  final _ultimoNomeController = TextEditingController();
  final _idadeController = TextEditingController();
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();
  final _confirmarSenhaController = TextEditingController();
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
            colors: [Colors.blue, Color.fromARGB(255, 13, 58, 95)],
          ),
        ),
        child: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.all(16.0),
            //child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Criar Conta',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Container(
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
                  child: Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          controller: _primeiroNomeController,
                          decoration: InputDecoration(labelText: 'Primeiro Nome'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor, insira o seu primeiro nome';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: _ultimoNomeController,
                          decoration: InputDecoration(labelText: 'Último Nome'),
                          validator:(value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor, insira o seu último nome';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: _idadeController,
                          decoration: InputDecoration(labelText: 'Idade'),
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor, insira a sua idade';
                            }
                            if (int.tryParse(value) == null) {
                              return 'Por favor, insira um número válido';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(labelText: 'Email'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor, insira o seu email';
                            }
                            Pattern pattern =
                                r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
                            RegExp regex = new RegExp(pattern.toString());
                            if (!regex.hasMatch(value)) {
                              return 'Por favor, insira um email válido';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: _senhaController,
                          decoration: InputDecoration(labelText: 'Palavra-passe'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor, insira a sua palavra-passe';
                            }
                            return null;
                          },
                          obscureText: true,
                        ),
                        TextFormField(
                          controller: _confirmarSenhaController,
                          decoration: InputDecoration(labelText: 'Confirmar Palavra-passe'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor, insira a sua palavra-passe';
                            }
                            if (value != _senhaController.text) {
                              return 'As palavras-passe não coincidem';
                            }
                            return null;
                          },
                          obscureText: true,
                        ),
                      ],
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    if(_formKey.currentState?.validate() ?? false)
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                    // Aqui você pode adicionar a lógica para criar a conta
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
      //)
    );
  }
}