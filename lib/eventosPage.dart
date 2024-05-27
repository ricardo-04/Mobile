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
        // Adicione seu Drawer aqui
        // Exemplo:
        // child: ListView(
        //   children: <Widget>[
        //     DrawerHeader(child: Text('Header')),
        //     ListTile(title: Text('Item 1')),
        //   ],
        // ),
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
                  child: Text('PRÓXIMOS EVENTOS'),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text('EVENTOS JÁ OCORRIDOS'),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
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
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(imagePath, fit: BoxFit.cover),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              date,
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              subtitle,
              style: TextStyle(fontSize: 16, color: Colors.grey),
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
                    SizedBox(width: 5),
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

