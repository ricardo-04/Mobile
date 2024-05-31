import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Image.asset(
          'assets/logo-softinsa.png',
          height: 40,
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color.fromARGB(255, 53, 92, 124), Color.fromARGB(255, 214, 235, 252)],
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: const [
            SectionTitle(title: 'Conta'),
            SettingsOption(title: 'Definições da Conta', icon: Icons.account_circle),
            SettingsOption(title: 'Notificações', icon: Icons.notifications),
            SettingsOption(title: 'Sign Out', icon: Icons.exit_to_app),
            SectionTitle(title: 'Eventos'),
            SettingsOption(title: 'Os meus Eventos', icon: Icons.event),
            SettingsOption(title: 'As minhas inscrições', icon: Icons.assignment),
            SettingsOption(title: 'Convites para Eventos', icon: Icons.event_available),
            SectionTitle(title: 'Gostos'),
            SettingsOption(title: 'Pessoas com Gosto', icon: Icons.people),
            SettingsOption(title: 'Estabelecimentos com Gosto', icon: Icons.store),
          ],
        ),
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class SettingsOption extends StatelessWidget {
  final String title;
  final IconData icon;

  const SettingsOption({required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: () {
        // Adicione a lógica de navegação ou outra ação aqui
      },
    );
  }
}
