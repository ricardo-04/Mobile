import 'package:flutter/material.dart';
import 'package:flutter_application_1/drawer/definicoes.dart';
import 'eventosPage.dart';
import 'criarEvento.dart';
import 'eventosPage.dart';
import 'detailEventos.dart'; // Import the detail page
import 'package:http/http.dart' as http;
import 'dart:convert';

class EventosPage extends StatefulWidget {
  @override
  _EventosPageState createState() => _EventosPageState();
}

class _EventosPageState extends State<EventosPage> {
  List<dynamic> eventos = [];

  @override
  void initState() {
    super.initState();
    _fetchEventos();
  }

  Future<void> _fetchEventos() async {
    final response = await http.get(Uri.parse('http://192.168.1.79:3000/evento/list'));
    if (response.statusCode == 200) {
      setState(() {
        eventos = json.decode(response.body);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Colors.blue,
            Color.fromARGB(255, 13, 58, 95),
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Container(
            height: kToolbarHeight,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Color.fromRGBO(33, 150, 243, 1),
                  Color.fromARGB(255, 13, 58, 95),
                ],
              ),
            ),
            child: Image.asset(
              'assets/logo-softinsa.png',
              height: kToolbarHeight,
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CreateEventPage()),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.business),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LocaisPage()),
                );
              },
            ),
          ],
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Color.fromRGBO(33, 150, 243, 1),
                ),
                child: Text(
                  'SOFTINSA',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.settings),
                title: const Text('Definições'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SettingsPage()),
                  );
                },
              ),
            ],
          ),
        ),
        body: _buildEventsList(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CreateEventPage()),
            );
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }

  Widget _buildEventsList() {
    return ListView.builder(
      itemCount: eventos.length,
      itemBuilder: (context, index) {
        final evento = eventos[index];
        return _buildEventCard(
          context,
          evento['DATA_EVENTO'],
          evento['NOME_EVENTO'],
          evento['foto'],
          'DETALHES',
          evento['ID_EVENTO'], // Pass the ID_EVENTO to the card
        );
      },
    );
  }

  String _getFullImageUrl(String imagePath) {
    if (imagePath.startsWith('http')) {
      return imagePath;
    } else {
      return 'http://192.168.1.79:3000/$imagePath';
    }
  }

  Widget _buildEventCard(
    BuildContext context,
    String date,
    String title,
    String imagePath,
    String buttonText,
    int idEvento, // Accept the ID_EVENTO as a parameter
  ) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (imagePath != null)
            Image.network(_getFullImageUrl(imagePath), fit: BoxFit.cover)
          else
            Container(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              date,
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DetalhesEvento(idEvento: idEvento)),
                );
              },
              child: Text(buttonText),
            ),
          ),
        ],
      ),
    );
  }
}


///////////////DAQUI PARA BAIXO É PARA RETIRAR
///////////////este código é para mudar para o estabelecimenstos
class LocaisPage extends StatefulWidget {
  @override
  _LocaisPageState createState() => _LocaisPageState();
}

class _LocaisPageState extends State<LocaisPage> {
  List<dynamic> locais = [];

  @override
  void initState() {
    super.initState();
    _fetchLocais();
  }

  Future<void> _fetchLocais() async {
    final response = await http.get(Uri.parse('http://192.168.1.79:3000/locais/list'));
    if (response.statusCode == 200) {
      setState(() {
        locais = json.decode(response.body);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Colors.blue,
            Color.fromARGB(255, 13, 58, 95),
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Container(
            height: kToolbarHeight,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Color.fromRGBO(33, 150, 243, 1),
                  Color.fromARGB(255, 13, 58, 95),
                ],
              ),
            ),
            child: Image.asset(
              'assets/logo-softinsa.png',
              height: kToolbarHeight,
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.add_location),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CreateLocalPage()),
                );
              },
            ),
          ],
        ),
        body: _buildLocaisList(),
      ),
    );
  }
///////////////este código é para mudar para o estabelecimenstos, mas talvez haja um erro
  Widget _buildLocaisList() {
    return ListView.builder(
      itemCount: locais.length,
      itemBuilder: (context, index) {
        final local = locais[index];
        return _buildLocalCard(
          context,
          local['DESIGNACAO_LOCAL'],
          local['LOCALIZACAO'],
          local['foto'],
          'DETALHES',
        );
      },
    );
  }

  String _getFullImageUrl(String imagePath) {
    if (imagePath.startsWith('http')) {
      return imagePath;
    } else {
      return 'http://192.168.1.79:3000/$imagePath';
    }
  }

  Widget _buildLocalCard(
    BuildContext context,
    String title,
    String subtitle,
    String imagePath,
    String buttonText,
  ) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (imagePath != null)
            Image.network(_getFullImageUrl(imagePath), fit: BoxFit.cover)
          else
            Container(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              subtitle,
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {},
              child: Text(buttonText),
            ),
          ),
        ],
      ),
    );
  }
}
////////////////////////código para ir para outro ficheiro
class CreateLocalPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adicionar Estabelecimento'),
      ),
      body: Center(
        child: Text('Página para adicionar estabelecimento'),
      ),
    );
  }
}
