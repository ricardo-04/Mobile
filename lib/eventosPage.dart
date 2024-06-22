import 'package:flutter/material.dart';
import 'package:flutter_application_1/drawer/definicoes.dart';

class EventosPage extends StatelessWidget {
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
              onPressed: () {},
            ),
          ],
        ),
        //////////////////DRAWER////////////////////
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
                leading: const Icon(Icons.location_city),
                title: const Text('Polos'),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.local_hospital),
                title: const Text('Saúde'),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.sports),
                title: const Text('Desporto'),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.school),
                title: const Text('Formação'),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.home),
                title: const Text('Habitação'),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.directions_bus),
                title: const Text('Transporte'),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.local_activity),
                title: const Text('Lazer'),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.restaurant),
                title: const Text('Gastronomia'),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.help),
                title: const Text('Ajuda & Suporte'),
                onTap: () {},
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
              ListTile(
                leading: const Icon(Icons.info),
                title: const Text('Informação/Avisos'),
                onTap: () {},
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text('PRÓXIMOS EVENTOS'),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text('EVENTOS JÁ OCORRIDOS'),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Explorar Eventos',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Expanded(
              child: PageView(
                children: [
                  _buildEventsList(context, 'Próximos Eventos'),
                  _buildEventsList(context, 'Eventos Já Ocorridos'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEventsList(BuildContext context, String category) {
    return ListView(
      children: [
        if (category == 'Próximos Eventos') ...[
          _buildEventCard(
            context,
            '14 Dezembro 2023',
            'Jantar de Natal Softinsa',
            'assets/jantar.jpg',
            'Inscrições até 10/12',
            'DETALHES',
          ),
          _buildEventCard(
            context,
            '3 Janeiro 2024',
            'Jogatina de Poker sem o Chefe (hehe)',
            'assets/poker.jpg',
            'Casa Da Sorte',
            'APENAS CONVIDADOS',
            icon: Icons.lock,
          ),
        ] else if (category == 'Eventos Já Ocorridos') ...[
          _buildEventCard(
            context,
            '10 Novembro 2023',
            'Hackathon Softinsa',
            'assets/hackathon.jpg',
            'Evento encerrado',
            'VER DETALHES',
          ),
          _buildEventCard(
            context,
            '25 Outubro 2023',
            'Workshop de Flutter',
            'assets/flutter.jpg',
            'Evento encerrado',
            'VER DETALHES',
          ),
        ],
      ],
    );
  }

  Widget _buildEventCard(
    BuildContext context,
    String date,
    String title,
    String imagePath,
    String subtitle,
    String buttonText, {
    IconData? icon,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(imagePath, fit: BoxFit.cover),
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
            child: Text(
              subtitle,
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {},
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(buttonText),
                  if (icon != null) ...[
                    const SizedBox(width: 5),
                    Icon(icon),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
