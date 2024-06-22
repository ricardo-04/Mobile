import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'login.dart';

class ContaCreate extends StatefulWidget {
  @override
  _ContaCreateState createState() => _ContaCreateState();
}

class _ContaCreateState extends State<ContaCreate> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();
  final _nifController = TextEditingController();
  final _moradaController = TextEditingController();
  final _nTelemovelController = TextEditingController();
  final _dataInicioController = TextEditingController();
  String? _selectedCentro;
  List<Map<String, dynamic>> _centros = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchCentros();
  }

  Future<void> _fetchCentros() async {
    try {
      final response = await http.get(Uri.parse('http://192.168.1.79:3000/centro/list'));

      if (response.statusCode == 200) {
        final List<dynamic> centrosJson = jsonDecode(response.body);
        setState(() {
          _centros = centrosJson.map((centro) {
            return {
              'ID_CENTRO': centro['ID_CENTRO'],
              'NOME_CENTRO': centro['NOME_CENTRO']
            };
          }).toList();
          if (_centros.isNotEmpty) {
            _selectedCentro = _centros.first['ID_CENTRO'].toString();
          }
          _isLoading = false;
        });
      } else {
        throw Exception('Erro ao buscar centros. Status code: ${response.statusCode}');
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao buscar centros: $e')),
      );
    }
  }

  Future<void> _createAccount() async {
    if (_formKey.currentState?.validate() ?? false) {
      final response = await http.post(
        Uri.parse('http://192.168.1.79:3000/auth/create'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'user_name': _nomeController.text,
          'user_mail': _emailController.text,
          'user_password': _senhaController.text,
          'NIF': _nifController.text,
          'MORADA': _moradaController.text,
          'NTELEMOVEL': _nTelemovelController.text,
          'DATAINICIO': _dataInicioController.text,
          'ID_CENTRO': _selectedCentro ?? '',
        }),
      );

      if (response.statusCode == 201) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao criar conta. Tente novamente.')),
        );
      }
    }
  }

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
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height -
                kToolbarHeight - MediaQuery.of(context).padding.top,
          ),
          child: IntrinsicHeight(
            child: Container(
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
                      onPressed: _createAccount,
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
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Container(
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
                controller: _nomeController,
                decoration: const InputDecoration(
                  labelText: 'Nome',
                  hintText: 'Digite seu nome',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o seu nome';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'E-mail',
                  hintText: 'Digite o seu e-mail',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o seu e-mail';
                  }
                  Pattern pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
                  RegExp regex = RegExp(pattern.toString());
                  if (!regex.hasMatch(value)) {
                    return 'Por favor, insira um e-mail válido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                controller: _senhaController,
                decoration: const InputDecoration(
                  labelText: 'Senha',
                  hintText: 'Digite a sua senha',
                ),
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
                controller: _nifController,
                decoration: const InputDecoration(
                  labelText: 'NIF',
                  hintText: 'Digite o seu NIF',
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o seu NIF';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Por favor, insira um número válido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                controller: _moradaController,
                decoration: const InputDecoration(
                  labelText: 'Morada',
                  hintText: 'Digite a sua morada',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira a sua morada';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                controller: _nTelemovelController,
                decoration: const InputDecoration(
                  labelText: 'Nº Telemóvel',
                  hintText: 'Digite o seu nº telemóvel',
                ),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o seu nº telemóvel';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Por favor, insira um número válido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                controller: _dataInicioController,
                decoration: const InputDecoration(
                  labelText: 'Data de Início',
                  hintText: 'yyyy-mm-dd',
                ),
                keyboardType: TextInputType.datetime,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira a data de início';
                  }
                  // Adicionar validação de formato de data se necessário
                  return null;
                },
              ),
              const SizedBox(height: 20.0),
              if (_isLoading)
                CircularProgressIndicator()
              else
                DropdownButtonFormField<String>(
                  value: _selectedCentro,
                  items: _centros.map((centro) {
                    return DropdownMenuItem<String>(
                      value: centro['ID_CENTRO'].toString(),
                      child: Text(centro['NOME_CENTRO']),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      _selectedCentro = newValue;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, selecione um centro';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Centro',
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
