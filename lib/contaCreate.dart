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
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height -
              kToolbarHeight - MediaQuery.of(context).padding.top,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Colors.blue, Color.fromARGB(255, 13, 58, 95)],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'Criar Conta',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20.0),
                _buildForm(),
                const SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      // Lógica para criar a conta
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    }
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

  Widget _buildForm() {
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
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: _primeiroNomeController,
              decoration: const InputDecoration(labelText: 'Primeiro Nome',
              hintText: 'Digite primeiro nome',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, insira o seu primeiro nome';
                }
                return null;
              },
            ),
            const SizedBox(height: 20.0),
            TextFormField(
              controller: _ultimoNomeController,
              decoration: const InputDecoration(labelText: 'Último Nome',
              hintText: 'Digite último nome',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, insira o seu último nome';
                }
                return null;
              },
            ),
            const SizedBox(height: 20.0),
            TextFormField(
              controller: _idadeController,
              decoration: const InputDecoration(labelText: 'Idade',
              hintText: 'Digite a sua idade',
              ),
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
            const SizedBox(height: 20.0),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email',
              hintText: 'Digite o seu email',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, insira o seu email';
                }
                Pattern pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
                RegExp regex = RegExp(pattern.toString());
                if (!regex.hasMatch(value)) {
                  return 'Por favor, insira um email válido';
                }
                return null;
              },
            ),
            const SizedBox(height: 20.0),
            TextFormField(
              controller: _senhaController,
              decoration: const InputDecoration(labelText: 'Senha',
              hintText: 'Digite a sua senha',),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, insira a sua senha';
                }
                return null;
              },
              obscureText: true,
            ),
            const SizedBox(height: 20.0),
            TextFormField(
              controller: _confirmarSenhaController,
              decoration: const InputDecoration(labelText: 'Confirmar Senha',
              hintText: 'Digite a senha novamente',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, insira a sua Senha';
                }
                if (value != _senhaController.text) {
                  return 'As senhas não coincidem';
                }
                return null;
              },
              obscureText: true,
            ),
          ],
        ),
      ),
    );
  }
}
