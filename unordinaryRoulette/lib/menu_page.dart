// Em: lib/menu_page.dart

import 'package:flutter/material.dart';
import 'package:unordinaryroulette/character.dart';
import 'package:unordinaryroulette/create_character_page.dart';
import 'package:unordinaryroulette/character_list_page.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  // A lista agora vive apenas na memória.
  final List<Character> _savedCharacters = [];

  void _navigateToCreateCharacterPage() async {
    // Navega e espera a página de criação ser fechada
    final newCharacter = await Navigator.push<Character>(
      context,
      MaterialPageRoute(builder: (context) => const CreateCharacterPage()),
    );

    // Se um personagem foi retornado (ou seja, o usuário salvou)...
    if (newCharacter != null) {
      // Adiciona o personagem à lista na memória e atualiza a tela
      setState(() {
        _savedCharacters.add(newCharacter);
      });
    }
  }

  void _navigateToShowCharactersPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CharacterListPage(characters: _savedCharacters),
      ),
    );
  }

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
              onPressed: _navigateToCreateCharacterPage,
              child: const Text('Criar Novo Personagem'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _navigateToShowCharactersPage,
              child: const Text('Ver Personagens Carregados'),
            ),
          ],
        ),
      ),
    );
  }
}