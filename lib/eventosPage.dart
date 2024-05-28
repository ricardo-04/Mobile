import 'package:flutter/material.dart';

class EventosPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/logo-softinsa.png', height: kToolbarHeight),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {},
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
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
              leading: Icon(Icons.location_city),
              title: Text('Polos'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.local_hospital),
              title: Text('Saúde'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.sports),
              title: Text('Desporto'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.school),
              title: Text('Formação'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Habitação'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.directions_bus),
              title: Text('Transporte'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.local_activity),
              title: Text('Lazer'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.restaurant),
              title: Text('Gastronomia'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.help),
              title: Text('Ajuda & Suporte'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Definições'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text('Informação/Avisos'),
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
                  child: Text('EVENTOS JÁ OCORRIDOS'),
                ),
              ],
            ),
          ),
          const Padding(
            padding:  EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Explorar Eventos',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: [
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
              ],
            ),
          ),
        ],
      ),
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
