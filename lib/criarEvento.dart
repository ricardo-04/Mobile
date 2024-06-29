import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';

class CreateEventPage extends StatefulWidget {
  @override
  _CreateEventPageState createState() => _CreateEventPageState();
}

class _CreateEventPageState extends State<CreateEventPage> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedCentro;
  String _nomeEvento = '';
  String _tipoEvento = '';
  DateTime? _dataEvento;
  String _localizacao = '';
  String _tipoArea = '';
  int _numParticipantes = 0;
  File? _foto;

  String? _idCriador;
  String? _token;
  List<dynamic> centros = [];

  @override
  void initState() {
    super.initState();
    _initData();
  }

  Future<void> _initData() async {
    await _fetchTokenAndProfile();
    _fetchCentros();
  }

  Future<void> _fetchTokenAndProfile() async {
  _token = await _getAuthToken();

  if (_token == null) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Token de autenticação não encontrado')));
    return;
  }

  final response = await http.get(
    Uri.parse('http://192.168.1.79:3000/user/profile'),
    headers: {
      'x-auth-token': _token!,
    },
  );

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    setState(() {
      _idCriador = data['ID_FUNCIONARIO'].toString(); // Certifique-se que isso é um INTEGER convertido para String
    });
  } else {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erro ao obter dados do usuário')));
  }
}



  Future<String?> _getAuthToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  Future<void> _fetchCentros() async {
    final response = await http.get(Uri.parse('http://192.168.1.79:3000/centro/list'));
    if (response.statusCode == 200) {
      setState(() {
        centros = json.decode(response.body);
      });
    }
  }

  Future<void> _createEvent() async {
  if (_formKey.currentState!.validate()) {
    _formKey.currentState!.save();

    if (_idCriador == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erro ao obter ID do criador')));
      return;
    }

    var request = http.MultipartRequest(
      'POST',
      Uri.parse('http://192.168.1.79:3000/evento/create'),
    );

    request.fields['ID_CENTRO'] = _selectedCentro!; // Certifique-se que está como INTEGER
    request.fields['ID_CRIADOR'] = _idCriador!; // Certifique-se que está como INTEGER
    request.fields['NOME_EVENTO'] = _nomeEvento;
    request.fields['TIPO_EVENTO'] = _tipoEvento;
    request.fields['DATA_EVENTO'] = _dataEvento?.toIso8601String() ?? '';
    request.fields['LOCALIZACAO'] = _localizacao;
    request.fields['TIPO_AREA'] = _tipoArea;
    request.fields['N_PARTICIPANTSE'] = _numParticipantes.toString();

    if (_foto != null) {
      request.files.add(await http.MultipartFile.fromPath('foto', _foto!.path));
    }

    if (_token != null) {
      request.headers['x-auth-token'] = _token!;
    }

    final response = await request.send();

    if (response.statusCode == 201) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Evento criado com sucesso')));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erro ao criar evento')));
    }
  }
}



  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _dataEvento)
      setState(() {
        _dataEvento = picked;
      });
  }

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _foto = File(pickedFile.path);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Criar Novo Evento'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              if (centros.isEmpty)
                Center(child: CircularProgressIndicator())
              else
                DropdownButtonFormField<String>(
                  value: _selectedCentro,
                  hint: Text('Selecione um centro'),
                  onChanged: (newValue) {
                    setState(() {
                      _selectedCentro = newValue!;
                    });
                  },
                  items: centros.map<DropdownMenuItem<String>>((centro) {
                    return DropdownMenuItem<String>(
                      value: centro['ID_CENTRO'].toString(),
                      child: Text(centro['NOME_CENTRO']),
                    );
                  }).toList(),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor selecione um centro';
                    }
                    return null;
                  },
                ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Nome do Evento'),
                onSaved: (value) {
                  _nomeEvento = value!;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor insira o nome do evento';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Tipo de Evento'),
                onSaved: (value) {
                  _tipoEvento = value!;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor insira o tipo de evento';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Data do Evento',
                  hintText: 'dd/mm/aaaa',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.calendar_today),
                    onPressed: () => _selectDate(context),
                  ),
                ),
                readOnly: true,
                controller: TextEditingController(
                  text: _dataEvento == null ? '' : _dataEvento.toString().substring(0, 10),
                ),
                validator: (value) {
                  if (_dataEvento == null) {
                    return 'Por favor selecione a data do evento';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Localização'),
                onSaved: (value) {
                  _localizacao = value!;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor insira a localização';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Tipo de Área'),
                onSaved: (value) {
                  _tipoArea = value!;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor insira o tipo de área';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Número de Participantes'),
                keyboardType: TextInputType.number,
                onSaved: (value) {
                  _numParticipantes = int.parse(value!);
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor insira o número de participantes';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: _pickImage,
                    child: Text('Escolher Foto'),
                  ),
                  SizedBox(width: 10),
                  if (_foto != null) Text('Foto selecionada'),
                ],
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _createEvent,
                child: Text('Criar Evento'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
