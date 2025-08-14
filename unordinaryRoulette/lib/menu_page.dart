import 'package:flutter/material.dart';
import 'package:unordinaryroulette/create_character_page.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'UnOrdinary Roulette',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 50),
            ElevatedButton(
              onPressed: () {
                // Lógica de navegação atualizada
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CreateCharacterPage()),
                );
              },
              child: const Text('Criar Novo Personagem'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Implementar a navegação para a tela de visualização de personagens
                // Por enquanto, apenas exibe um SnackBar
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Navegar para a tela de personagens carregados'),
                  ),
                );
              },
              child: const Text('Ver Personagens Carregados'),
            ),
          ],
        ),
      ),
    );
  }
}