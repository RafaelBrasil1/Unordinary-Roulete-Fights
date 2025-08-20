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

  int _genderResultIndex = 0;
  int _powerResultIndex = 0;

  final List<String> _genders = ['Masculino', 'Feminino'];
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
    } else {
      // Se não for Masculino, só pode ser Feminino
      return 'assets/images/female_character.png';
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
            // O alinhamento do Stack continua no centro para a imagem de base
            alignment: Alignment.center,
            children: [

              // CONDIÇÃO ATUALIZADA com os novos widgets
              if (_selectedGender == 'Masculino' || _selectedGender == 'Feminino')
                Align(
                  // 1. POSICIONAMENTO:
                  //    -0.2 move o widget 10% para a esquerda do centro.
                  //    Valores vão de -1.0 (extrema esquerda) a 1.0 (extrema direita).
                  alignment: const Alignment(-0.138, 0.0),
                  child: Transform.scale(
                    // 2. TAMANHO:
                    //    0.8 torna o widget 20% menor (80% do tamanho original).
                    //    1.0 é o tamanho normal.
                    scale: 0.5,
                    child: Image.asset(_characterImage),
                  ),
                 ),
              Image.asset('assets/images/character_base.png'),
              if (_nameController.text.isNotEmpty)
                Align(
                  // Alinha o texto na parte de baixo e centralizado
                  alignment: const Alignment(-0.1, 0.6),
                  child: Padding(
                    // Adiciona um respiro na parte de baixo
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: Text(
                      _nameController.text,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ),
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
        SizedBox(
          height: 150,
          child: FortuneWheel(
            selected: _genderController.stream,
            animateFirst: false,
            items: [
              for (var gender in _genders) FortuneItem(child: Text(gender)),
            ],
            // A MÁGICA ACONTECE AQUI!
            onAnimationEnd: () {
              setState(() {
                // Atualiza o texto APENAS quando a roleta para.
                _selectedGender = _genders[_genderResultIndex];
              });
            },
          ),
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            // Sorteia e guarda o índice secretamente.
            _genderResultIndex = Fortune.randomInt(0, _genders.length);
            // Manda a roleta girar até o índice sorteado.
            _genderController.add(_genderResultIndex);
          },
          child: const Text('Girar Roleta'),
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

  // Em _CreateCharacterPageState

  Widget _buildPowerStep() {
    return Column(
      children: [
        const Text(
          'Passo 3: Poder do Personagem',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        SizedBox(
          height: 150,
          child: FortuneWheel(
            selected: _powerController.stream,
            animateFirst: false,
            items: [
              for (var power in _powers) FortuneItem(child: Text(power)),
            ],
            // A mesma lógica da roleta de gênero
            onAnimationEnd: () {
              setState(() {
                _selectedPower = _powers[_powerResultIndex];
              });
            },
          ),
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            // Sorteia e guarda o índice do poder secretamente.
            _powerResultIndex = Fortune.randomInt(0, _powers.length);
            // Manda a roleta girar até ele.
            _powerController.add(_powerResultIndex);
          },
          child: const Text('Girar Roleta'),
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
            // onAnimationEnd não é mais necessário para a lógica principal
          ),
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            // 1. Sorteia o índice do resultado
            final randomIndex = Fortune.randomInt(0, items.length);

            // 2. Chama a função para atualizar o estado da página (ex: _selectedGender)
            onSpin(randomIndex);

            // 3. Adiciona o índice ao controller para a roleta girar ATÉ esse resultado
            streamController.add(randomIndex);
          },
          child: const Text('Girar Roleta'),
        ),
      ],
    );
  }
}