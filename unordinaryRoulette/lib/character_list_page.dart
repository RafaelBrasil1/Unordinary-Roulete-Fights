// Em: lib/character_list_page.dart

import 'package:flutter/material.dart';
import 'package:unordinaryroulette/character.dart';
import 'package:unordinaryroulette/stat_painter.dart'; // Reutilizando nosso pintor!

class CharacterListPage extends StatelessWidget {
  final List<Character> characters;

  const CharacterListPage({super.key, required this.characters});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 1. Fundo branco (removido o backgroundColor preto)
      appBar: AppBar(
        title: const Text('Personagens Salvos'),
        // 2. Cores do AppBar voltam ao padrão do seu tema
        centerTitle: true,
      ),
      body: characters.isEmpty
          ? const Center(
        child: Text(
          'Nenhum personagem foi criado ainda.',
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      )
          : ListView.builder(
        padding: const EdgeInsets.only(top: 8), // Reduzido o padding
        itemCount: characters.length,
        itemBuilder: (context, index) {
          final character = characters[index];
          return _CharacterCard(character: character);
        },
      ),
    );
  }
}

class _CharacterCard extends StatelessWidget {
  const _CharacterCard({required this.character});

  final Character character;

  @override
  Widget build(BuildContext context) {
    final String portraitImage = character.gender == 'Masculino'
        ? 'assets/images/male_character.png'
        : 'assets/images/female_character.png';

    return Card( // 3. Usando Card para um visual mais integrado com o tema Material
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 3,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.grey.shade300, width: 1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            // Imagem do Rosto
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: Colors.grey.shade400),
              ),
              clipBehavior: Clip.antiAlias, // Para cortar a imagem nas bordas arredondadas
              child: Image.asset(
                portraitImage,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 16),

            // Coluna com Nome e Nível
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    character.name,
                    style: const TextStyle( // 4. Cor do texto alterada para preto
                      color: Colors.black87,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Level',
                    style: TextStyle(
                      color: Colors.black54, // Cor do texto alterada
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    character.finalLevel.toStringAsFixed(2),
                    style: const TextStyle(
                      color: Colors.black87, // Cor do texto alterada
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),

            // Coluna com Poder e Origem
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  character.power,
                  style: const TextStyle(
                    color: Colors.black87, // Cor do texto alterada
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  character.origin,
                  style: TextStyle(
                    color: Colors.grey.shade600, // Cor do texto alterada
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}