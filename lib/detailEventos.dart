import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class DetalhesEvento extends StatefulWidget {
  final int idEvento;

  DetalhesEvento({required this.idEvento});

  @override
  _DetalhesEventoState createState() => _DetalhesEventoState();
}

class _DetalhesEventoState extends State<DetalhesEvento> {
  late Map<String, dynamic> evento;
  List<dynamic> participantes = [];
  List<dynamic> comentarios = [];
  String novoComentario = '';
  bool isParticipating = false;
  bool isLoading = true;
  String erro = '';
  
  String? _token;
  String? _idUsuario;

  @override
  void initState() {
    super.initState();
    _initData();
  }

  Future<void> _initData() async {
    await _fetchTokenAndProfile();
    if (_idUsuario != null) {
      _fetchEventoDetails();
    } else {
      setState(() {
        erro = 'Erro ao obter ID do usuário';
        isLoading = false;
      });
    }
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
        _idUsuario = data['ID_FUNCIONARIO'].toString(); // Certifique-se que isso é um INTEGER convertido para String
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erro ao obter dados do usuário')));
    }
  }

  Future<String?> _getAuthToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  Future<void> _fetchEventoDetails() async {
    try {
      final eventoResponse = await http.get(
        Uri.parse('http://192.168.1.79:3000/evento/get/${widget.idEvento}'),
        headers: { 'x-auth-token': _token! },
      );
      final eventoData = json.decode(eventoResponse.body);

      final participantesResponse = await http.get(
        Uri.parse('http://192.168.1.79:3000/participantesevento/eventos/${widget.idEvento}/participantes'),
      );
      final participantesData = json.decode(participantesResponse.body);

      final comentariosResponse = await http.get(
        Uri.parse('http://192.168.1.79:3000/forum/listevento/${widget.idEvento}'),
      );
      final comentariosData = json.decode(comentariosResponse.body);

      setState(() {
        evento = eventoData;
        participantes = participantesData;
        comentarios = comentariosData;
        isParticipating = participantesData.any((p) => p['ID_FUNCIONARIO'] == _idUsuario); // Check if the user is participating
        isLoading = false;
      });
    } catch (error) {
      setState(() {
        erro = 'Erro ao carregar dados.';
        isLoading = false;
      });
    }
  }

  Future<void> _addComentario() async {
    if (novoComentario.trim().isEmpty) return;

    try {
      final response = await http.post(
        Uri.parse('http://192.168.1.79:3000/forum/create'),
        headers: { 'Content-Type': 'application/json' },
        body: json.encode({
          'ID_FUNCIONARIO': _idUsuario, // Utilize o ID do usuário
          'DESCRICAO': novoComentario,
          'NEVENTO': evento['ID_EVENTO'],
        }),
      );

      setState(() {
        comentarios.add(json.decode(response.body));
        novoComentario = '';
      });
    } catch (error) {
      setState(() {
        erro = 'Erro ao adicionar comentário.';
      });
    }
  }

  Future<void> _deleteComentario(int idForum) async {
    try {
      await http.delete(Uri.parse('http://192.168.1.79:3000/forum/delete/$idForum'));
      setState(() {
        comentarios.removeWhere((comentario) => comentario['ID_FORUM'] == idForum);
      });
    } catch (error) {
      setState(() {
        erro = 'Erro ao apagar comentário.';
      });
    }
  }

  Future<void> _participarEvento() async {
    try {
      await http.post(
        Uri.parse('http://192.168.1.79:3000/participantesevento/participantes'),
        headers: { 'Content-Type': 'application/json' },
        body: json.encode({
          'ID_FUNCIONARIO': _idUsuario, // Utilize o ID do usuário
          'ID_EVENTO': evento['ID_EVENTO'],
        }),
      );

      setState(() {
        isParticipating = true;
        participantes.add({ 'ID_FUNCIONARIO': _idUsuario }); // Adicione o ID do usuário
      });
    } catch (error) {
      setState(() {
        erro = 'Erro ao participar do evento.';
      });
    }
  }

  Future<void> _deixarEvento() async {
    try {
      await http.delete(
        Uri.parse('http://192.168.1.79:3000/participantesevento/participantesdelete/$_idUsuario/${evento['ID_EVENTO']}'), // Utilize o ID do usuário
      );

      setState(() {
        isParticipating = false;
        participantes.removeWhere((participante) => participante['ID_FUNCIONARIO'] == _idUsuario); // Remova o ID do usuário
      });
    } catch (error) {
      setState(() {
        erro = 'Erro ao deixar o evento.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Detalhes do Evento'),
        ),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (erro.isNotEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Detalhes do Evento'),
        ),
        body: Center(
          child: Text(erro),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes do Evento'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(evento['NOME_EVENTO'], style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              Text('Criador: ${evento['CRIADOR']}'),
              Text('Data: ${evento['DATA_EVENTO']}'),
              Text('Localização: ${evento['LOCALIZACAO']}'),
              Text('Tipo de Evento: ${evento['TIPO_EVENTO']}'),
              SizedBox(height: 10),
              evento['IMAGEM'] != null && evento['IMAGEM'].isNotEmpty
                ? Image.network(evento['IMAGEM'])
                : Container(height: 200, color: Colors.grey[300], child: Center(child: Text('Nenhuma imagem disponível'))),
              SizedBox(height: 10),
              isParticipating
                ? ElevatedButton(
                    onPressed: _deixarEvento,
                    child: Text('Deixar de Participar'),
                  )
                : ElevatedButton(
                    onPressed: _participarEvento,
                    child: Text('Participar'),
                  ),
              SizedBox(height: 20),
              Text('Participantes:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              for (var participante in participantes)
                Text(participante['EMAIL'] ?? 'Email não disponível'),
              SizedBox(height: 20),
              Text('Comentários:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              for (var comentario in comentarios)
                ListTile(
                  title: Text(comentario['DESCRICAO']),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => _deleteComentario(comentario['ID_FORUM']),
                  ),
                ),
              TextField(
                onChanged: (value) => setState(() => novoComentario = value),
                decoration: InputDecoration(labelText: 'Adicionar Comentário'),
              ),
              ElevatedButton(
                onPressed: _addComentario,
                child: Text('Comentar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}