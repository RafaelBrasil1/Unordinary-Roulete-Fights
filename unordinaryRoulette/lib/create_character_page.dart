import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'dart:async';
import 'dart:math';
import 'package:unordinaryroulette/character.dart';

enum CharacterCreationStep { name, gender, power, summary }

class CreateCharacterPage extends StatefulWidget {
  const CreateCharacterPage({super.key});

  @override
  State<CreateCharacterPage> createState() => _CreateCharacterPageState();
}

class _CreateCharacterPageState extends State<CreateCharacterPage> {
  CharacterCreationStep _currentStep = CharacterCreationStep.name;

  final TextEditingController _nameController = TextEditingController();

  String _selectedGender = 'Girar Gênero';
  String _selectedPower = 'Girar Poder';

  final StreamController<int> _genderController = StreamController<int>();
  final StreamController<int> _powerController = StreamController<int>();

  final List<String> _genders = ['Masculino', 'Feminino', 'Não Binário'];
  final List<String> _powers = [
    'Super Força',
    'Telecinese',
    'Invisibilidade',
    'Manipulação de Fogo',
    'Cura Acelerada',
    'Eletrocinese',
  ];

  // Imagem do personagem dinâmico, que será sobreposta
  String get _characterImage {
    if (_selectedGender == 'Masculino') {
      return 'assets/images/male_character.png';
    } else if (_selectedGender == 'Feminino') {
      return 'assets/images/female_character.png';
    } else {
      // Usar a imagem de placeholder para a opção não-binária ou o estado inicial
      return 'assets/images/placeholder.png';
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _genderController.close();
    _powerController.close();
    super.dispose();
  }

  void _randomizeName() {
    final names = ['Alex', 'Morgan', 'Taylor', 'Jordan', 'Casey'];
    _nameController.text = names[Random().nextInt(names.length)];
  }

  void _nextStep() {
    setState(() {
      if (_currentStep == CharacterCreationStep.name) {
        _currentStep = CharacterCreationStep.gender;
      } else if (_currentStep == CharacterCreationStep.gender) {
        if (_selectedGender == 'Girar Gênero') {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Por favor, gire a roleta do Gênero.')),
          );
          return;
        }
        _currentStep = CharacterCreationStep.power;
      } else if (_currentStep == CharacterCreationStep.power) {
        if (_selectedPower == 'Girar Poder') {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Por favor, gire a roleta do Poder.')),
          );
          return;
        }
        _currentStep = CharacterCreationStep.summary;
      }
    });
  }

  void _saveCharacter() {
    final newCharacter = Character(
      name: _nameController.text.isEmpty ? 'Sem Nome' : _nameController.text,
      gender: _selectedGender,
      power: _selectedPower,
    );
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Personagem ${newCharacter.name} criado com sucesso!'),
      ),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Criar Novo Personagem'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Imagem de fundo com o personagem sobreposto
            SizedBox(
              height: 200, // Altura da sua imagem base
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Imagem de fundo (base)
                  Image.asset('assets/images/character_base.png'),
                  // Imagem do personagem (masculino, feminino, ou placeholder)
                  Image.asset(_characterImage),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: _buildCurrentStepWidget(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCurrentStepWidget() {
    switch (_currentStep) {
      case CharacterCreationStep.name:
        return _buildNameStep();
      case CharacterCreationStep.gender:
        return _buildGenderStep();
      case CharacterCreationStep.power:
        return _buildPowerStep();
      case CharacterCreationStep.summary:
        return _buildSummaryStep();
      default:
        return Container();
    }
  }

  // Métodos _buildNameStep, _buildGenderStep, etc. são os mesmos da resposta anterior.
  // ... (o restante do código é o mesmo da resposta anterior, mantendo a roleta e a lógica de passos)

  Widget _buildNameStep() {
    return Column(
      children: [
        const Text(
          'Passo 1: Nome do Personagem',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Nome do Personagem',
                ),
              ),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              onPressed: _randomizeName,
              child: const Text('Randomizar'),
            ),
          ],
        ),
        const SizedBox(height: 40),
        ElevatedButton(
          onPressed: _nextStep,
          child: const Text('Próximo Passo'),
        ),
      ],
    );
  }

  Widget _buildGenderStep() {
    return Column(
      children: [
        const Text(
          'Passo 2: Gênero do Personagem',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        _buildRoulette(
          items: _genders,
          streamController: _genderController,
          onSpin: (int index) {
            setState(() {
              _selectedGender = _genders[index];
            });
          },
        ),
        const SizedBox(height: 20),
        Text('Gênero selecionado: $_selectedGender', style: const TextStyle(fontSize: 16)),
        const SizedBox(height: 40),
        ElevatedButton(
          onPressed: _nextStep,
          child: const Text('Próximo Passo'),
        ),
      ],
    );
  }

  Widget _buildPowerStep() {
    return Column(
      children: [
        const Text(
          'Passo 3: Poder do Personagem',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        _buildRoulette(
          items: _powers,
          streamController: _powerController,
          onSpin: (int index) {
            setState(() {
              _selectedPower = _powers[index];
            });
          },
        ),
        const SizedBox(height: 20),
        Text('Poder selecionado: $_selectedPower', style: const TextStyle(fontSize: 16)),
        const SizedBox(height: 40),
        ElevatedButton(
          onPressed: _nextStep,
          child: const Text('Finalizar'),
        ),
      ],
    );
  }

  Widget _buildSummaryStep() {
    return Column(
      children: [
        const Text(
          'Resumo do Personagem',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        Text('Nome: ${_nameController.text.isEmpty ? 'Sem Nome' : _nameController.text}'),
        Text('Gênero: $_selectedGender'),
        Text('Poder: $_selectedPower'),
        const SizedBox(height: 40),
        ElevatedButton(
          onPressed: _saveCharacter,
          child: const Text('Salvar Personagem'),
        ),
      ],
    );
  }

  Widget _buildRoulette({
    required List<String> items,
    required StreamController<int> streamController,
    required Function(int) onSpin,
  }) {
    return Column(
      children: [
        SizedBox(
          height: 150,
          child: FortuneWheel(
            selected: streamController.stream,
            animateFirst: false,
            items: [
              for (var item in items) FortuneItem(child: Text(item)),
            ],
            onAnimationEnd: () {
              final selectedIndex = Fortune.randomInt(0, items.length);
              onSpin(selectedIndex);
            },
          ),
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            final randomIndex = Fortune.randomInt(0, items.length);
            streamController.add(randomIndex);
          },
          child: const Text('Girar Roleta'),
        ),
      ],
    );
  }
}