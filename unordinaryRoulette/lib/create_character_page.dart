// Em: lib/create_character_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'dart:async';
import 'dart:math';
import 'package:unordinaryroulette/character.dart';
import 'package:unordinaryroulette/stat_painter.dart';

// Adicione esta classe no topo do seu arquivo
class ColorOption {
  final String name;
  final Color color;

  const ColorOption({required this.name, required this.color});
}

class OriginOption {
  final String name;
  final double value; // Usaremos double para valores como +1.5 e -0.5

  const OriginOption({required this.name, required this.value});
}

// MODIFICADO: Adicionando os novos passos
enum CharacterCreationStep {
  name,
  gender,
  hairColor,
  eyeColor,
  origin,
  strength, // NOVO
  speed,    // NOVO
  trick,    // NOVO
  recovery, // NOVO
  defense,  // NOVO
  power,
  summary
}

class CreateCharacterPage extends StatefulWidget {
  const CreateCharacterPage({super.key});

  @override
  State<CreateCharacterPage> createState() => _CreateCharacterPageState();
}

class _CreateCharacterPageState extends State<CreateCharacterPage> {
  // --- LÓGICA E ESTADO (CORRIGIDO) ---

  CharacterCreationStep _currentStep = CharacterCreationStep.name;

  final TextEditingController _nameController = TextEditingController();

  // Estados
  String _selectedGender = 'Girar Gênero';
  String _selectedPower = 'Girar Poder';
  ColorOption? _selectedHairColor;
  ColorOption? _selectedEyeColor;
  OriginOption? _selectedOrigin;
  double _originModifier = 0.0;
  double _strength = 0.0;
  double _speed = 0.0;
  double _trick = 0.0;
  double _recovery = 0.0;
  double _defense = 0.0;



  // Controllers
  final StreamController<int> _genderController = StreamController<int>();
  final StreamController<int> _powerController = StreamController<int>();
  final StreamController<int> _hairColorController = StreamController<int>();
  final StreamController<int> _eyeColorController = StreamController<int>();
  final StreamController<int> _originController = StreamController<int>();
  final StreamController<int> _strengthController = StreamController<int>();
  final StreamController<int> _speedController = StreamController<int>();
  final StreamController<int> _trickController = StreamController<int>();
  final StreamController<int> _recoveryController = StreamController<int>();
  final StreamController<int> _defenseController = StreamController<int>();

  // Índices de Resultado
  int _genderResultIndex = 0;
  int _powerResultIndex = 0;
  int _hairColorResultIndex = 0;
  int _eyeColorResultIndex = 0;
  int _originResultIndex = 0;
  int _strengthResultIndex = 0;
  int _speedResultIndex = 0;
  int _trickResultIndex = 0;
  int _recoveryResultIndex = 0;
  int _defenseResultIndex = 0;


  // Listas de Opções
  final List<OriginOption> _origins = [
    const OriginOption(name: 'Cripple(-1.5)', value: -1.5),
    const OriginOption(name: 'Low-Tier(-1.0)', value: -1.0),
    const OriginOption(name: 'Poor(-0.5)', value: -0.5),
    const OriginOption(name: 'Mid-Tier(+0.0)', value: 0.0),
    const OriginOption(name: 'Rich(+0.5)', value: 0.5),
    const OriginOption(name: 'High-Tier(+1.0)', value: 1.0),
    const OriginOption(name: 'God-Tier(+1.5)', value: 1.5),
  ];
  final List<String> _genders = ['Masculino', 'Feminino'];
  final List<double> _statValues = List.generate(91, (index) => 1.0 + index * 0.1);
  final List<String> _powers = [
    'Afterimage',
    'Arachnid',
    'Arcane Shot',
    'Archer',
    'Armor Suit',
    'Aura Manipulation',
    'Barrage',
    'Barrier',
    'Blademaster',
    'Botanist',
    'Catalyst Ray',
    'Catch Up',
    'Channel Master',
    'Charge',
    'Charge Shot',
    'Clairvoyance',
    'Clobber',
    'Conjure: Disks',
    'Conjure: Vines',
    'Crescent Slash',
    'Cripple',
    'Demolition',
    'Demon Blade',
    'Demon Claw',
    'Dizzy Punch',
    'Dominion',
    'Duplication',
    'Energy Discharge',
    'Explosion',
    'Fast Travel',
    'Flame Claw',
    'Flash Forward',
    'Fortify',
    'Gravity Manipulation',
    'Grenadier',
    'Ground Pound',
    'Hair Growth',
    'Hand Blade',
    'Healing',
    'Heal Link',
    'Heat Palm',
    'Heavy-hitter',
    'Hunter',
    'Hydrofreeze',
    'Hypnosis',
    'Illumination',
    'Impact',
    'Invisibility',
    'Landscaping',
    'Lazor',
    'Lie Detection',
    'Lightning',
    'Medium',
    'Memory Recall',
    'Mind Reading',
    'Minefield',
    'Missiles',
    'Needles',
    'Nightmare',
    'Particles',
    'Phantom Fist',
    'Phantom Push',
    'Phase Shift',
    'Portal',
    'Psychopomp',
    'Quick Strike',
    'Regeneration',
    'Repulsion',
    'Rock Arm',
    'Sensory Control',
    'Shadow Flame',
    'Shockwave',
    'Sleep Touch',
    'Spectral Claw',
    'Speed',
    'Spikes',
    'Stone Skin',
    'Strength',
    'Strong Kick',
    'Strong Punch',
    'Superhuman',
    'Super Strength',
    'Telekinesis',
    'Telepathy',
    'Teleportation',
    'Time Manipulation',
    'Tremor',
    'Vigor',
    'Whirlwind',
    'X-Ray Vision',
  ];
  final List<ColorOption> _hairColors = [
    const ColorOption(name: 'Roxo Profundo', color: Color(0xFF5C2A7F)),
    const ColorOption(name: 'Lilás Claro', color: Color(0xFFB57EDC)),
    const ColorOption(name: 'Violeta Neon', color: Color(0xFF9B30FF)),
    const ColorOption(name: 'Azul Elétrico', color: Color(0xFF1F3B73)),
    const ColorOption(name: 'Azul Neon', color: Color(0xFF00BFFF)),
    const ColorOption(name: 'Azul Pastel', color: Color(0xFFA3D5FF)),
    const ColorOption(name: 'Verde Limão', color: Color(0xFF39FF14)),
    const ColorOption(name: 'Verde Menta', color: Color(0xFF98FF98)),
    const ColorOption(name: 'Verde Esmeralda', color: Color(0xFF50C878)),
    const ColorOption(name: 'Rosa Choque', color: Color(0xFFFF1493)),
    const ColorOption(name: 'Algodão Doce', color: Color(0xFFFADADD)),
    const ColorOption(name: 'Vermelho Cereja', color: Color(0xFFC41E3A)),
    const ColorOption(name: 'Laranja Neon', color: Color(0xFFFF6F00)),
    const ColorOption(name: 'Amarelo Elétrico', color: Color(0xFFFFD700)),
    const ColorOption(name: 'Branco Prateado', color: Color(0xFFF0F0F0)),
    const ColorOption(name: 'Cinza Gelo', color: Color(0xFFD3D3D3)),
    const ColorOption(name: 'Ciano Claro', color: Color(0xFF00FFFF)),
    const ColorOption(name: 'Magenta Digital', color: Color(0xFFFF00FF)),
  ];

  final List<ColorOption> _eyeColors = [
    const ColorOption(name: 'Preto Intenso', color: Color(0xFF000000)),
    const ColorOption(name: 'Castanho Escuro', color: Color(0xFF3B2F2F)),
    const ColorOption(name: 'Castanho Mel', color: Color(0xFFA9743D)),
    const ColorOption(name: 'Âmbar', color: Color(0xFFFFBF00)),
    const ColorOption(name: 'Verde Esmeralda', color: Color(0xFF50C878)),
    const ColorOption(name: 'Verde Neon', color: Color(0xFF39FF14)),
    const ColorOption(name: 'Verde Gelo', color: Color(0xFFB2FBA5)),
    const ColorOption(name: 'Azul Claro', color: Color(0xFFADD8E6)),
    const ColorOption(name: 'Azul Céu', color: Color(0xFF87CEEB)),
    const ColorOption(name: 'Azul Intenso', color: Color(0xFF0047AB)),
    const ColorOption(name: 'Ciano Brilhante', color: Color(0xFF00FFFF)),
    const ColorOption(name: 'Lilás Claro', color: Color(0xFFE6CCFF)),
    const ColorOption(name: 'Roxo Místico', color: Color(0xFF8A2BE2)),
    const ColorOption(name: 'Vermelho Sangue', color: Color(0xFF8B0000)),
    const ColorOption(name: 'Rosa Neon', color: Color(0xFFFF69B4)),
    const ColorOption(name: 'Dourado Metálico', color: Color(0xFFFFD700)),
    const ColorOption(name: 'Prateado', color: Color(0xFFC0C0C0)),
    const ColorOption(name: 'Branco Fantasma', color: Color(0xFFF8F8FF)),
  ];


  String get _characterImage {
    if (_selectedGender == 'Masculino') {
      return 'assets/images/male_character.png';
    } else {
      return 'assets/images/female_character.png';
    }
  }

  int _getWeightedRandomIndex(List<int> weights) {
    // 1. Soma todos os pesos para saber o "tamanho" total do nosso dado.
    // Ex: [60, 30, 10] -> total = 100
    final totalWeight = weights.reduce((value, element) => value + element);

    // 2. Sorteia um número aleatório entre 0 e o total.
    // Ex: um número entre 0 e 99
    final randomNumber = Random().nextInt(totalWeight);

    // 3. Itera pelos pesos para ver em qual "faixa" o número sorteado caiu.
    int cumulativeWeight = 0;
    for (int i = 0; i < weights.length; i++) {
      cumulativeWeight += weights[i];
      if (randomNumber < cumulativeWeight) {
        // Se o número sorteado for menor que o peso acumulado,
        // então encontramos nosso índice.
        return i;
      }
    }

    // Como segurança, caso algo dê errado (não deve acontecer)
    return 0;
  }

  int _getStatRollIndex() {
    // 1. Gera uma lista de pesos base dinamicamente, criando uma curva de sino.
    final int itemCount = _statValues.length; // Agora 91
    final List<double> baseWeights = List.generate(itemCount, (index) {
      // Esta fórmula cria uma curva onde o meio tem o maior peso.
      double halfway = (itemCount - 1) / 2.0;
      double weight = halfway - (index - halfway).abs();
      return weight + 1; // Garante que o peso mínimo seja 1
    });

    // 2. Aplica o modificador de origem para "deslocar" os pesos
    final modifiedWeights = List<int>.generate(baseWeights.length, (index) {
      final multiplier = 1.0 + (_originModifier * (index / baseWeights.length));
      final newWeight = baseWeights[index] * multiplier;
      return newWeight.round().clamp(1, 1000); // Garante que o peso seja pelo menos 1
    });

    // 3. Usa a nossa função de sorteio ponderado já existente
    return _getWeightedRandomIndex(modifiedWeights);
  }


  @override
  void dispose() {
    _nameController.dispose();
    _genderController.close();
    _powerController.close();
    _hairColorController.close();
    _eyeColorController.close();
    _originController.close();
    _strengthController.close();
    _speedController.close();
    _trickController.close();
    _recoveryController.close();
    _defenseController.close();
    super.dispose();
  }

  void _randomizeName() {
    final names = ['Alex', 'Morgan', 'Taylor', 'Jordan', 'Casey'];
    _nameController.text = names[Random().nextInt(names.length)];
  }

  void _nextStep() {
    setState(() {
      switch (_currentStep) {
        case CharacterCreationStep.name:
          _currentStep = CharacterCreationStep.gender;
          break;
        case CharacterCreationStep.gender:
          if (_selectedGender == 'Girar Gênero') {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Por favor, gire a roleta do Gênero.')),
            );
            return;
          }
          _currentStep = CharacterCreationStep.hairColor;
          break;
        case CharacterCreationStep.hairColor:
          if (_selectedHairColor == null) { // MODIFICADO
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Por favor, gire a roleta da Cor do Cabelo.')),
            );
            return;
          }
          _currentStep = CharacterCreationStep.eyeColor;
          break;
        case CharacterCreationStep.eyeColor:
          if (_selectedEyeColor == null) { // MODIFICADO
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Por favor, gire a roleta da Cor do Olho.')),
            );
            return;
          }
          _currentStep = CharacterCreationStep.origin;
        case CharacterCreationStep.origin:
          if (_selectedOrigin == null) { /* ... */ return; }
          _currentStep = CharacterCreationStep.strength;
          break;
      // NOVOS PASSOS
        case CharacterCreationStep.strength:
          if (_strength == 0.0) { /* ... snackbar ... */ return; }
          _currentStep = CharacterCreationStep.speed;
          break;
        case CharacterCreationStep.speed:
          if (_speed == 0.0) { /* ... snackbar ... */ return; }
          _currentStep = CharacterCreationStep.trick;
          break;
        case CharacterCreationStep.trick:
          if (_trick == 0.0) { /* ... snackbar ... */ return; }
          _currentStep = CharacterCreationStep.recovery;
          break;
        case CharacterCreationStep.recovery:
          if (_recovery == 0.0) { /* ... snackbar ... */ return; }
          _currentStep = CharacterCreationStep.defense;
          break;
        case CharacterCreationStep.defense:
          if (_defense == 0.0) { /* ... snackbar ... */ return; }
          _currentStep = CharacterCreationStep.power;
          break;
        case CharacterCreationStep.power:
          if (_selectedPower == 'Girar Poder') { /* ... */ return; }
          _currentStep = CharacterCreationStep.summary;
          break;
        case CharacterCreationStep.summary:
          break;
      }
    });
  }

  void _saveCharacter() {
    final double finalLevel = (_strength + _speed + _trick + _recovery + _defense) / 5;
    // O '!' é seguro aqui porque a lógica do _nextStep impede que cheguemos aqui com valores nulos.
    final newCharacter = Character(
      name: _nameController.text.isEmpty ? 'Sem Nome' : _nameController.text,
      gender: _selectedGender,
      hairColor: _selectedHairColor!.name,
      eyeColor: _selectedEyeColor!.name,
      origin: _selectedOrigin!.name,
      originModifier: _originModifier,
      strength: _strength,
      speed: _speed,
      trick: _trick,
      recovery: _recovery,
      defense: _defense,
      power: _selectedPower,
      finalLevel: finalLevel,
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
    // Usar Colors.transparent faz com que os quadrados não apareçam
    // até que uma cor seja de fato selecionada.
    Color colorToShow = _selectedHairColor?.color ?? Colors.white;
    Color colorToShow2 = _selectedEyeColor?.color ?? Colors.white;
    final double finalLevel = (_strength + _speed + _trick + _recovery + _defense) / 5;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Criar Novo Personagem'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // --- ÁREA DE CRIAÇÃO RESPONSIVA ---
            SizedBox(
              height: 450,
              child: FittedBox(
                fit: BoxFit.contain,
                child: SizedBox(
                  // Nossa "Tela de Desenho" com tamanho fixo
                  width: 400,
                  height: 400,
                  child: Stack(
                    // A ordem dos children aqui é a MESMA que a sua original
                    children: [
                      // 1. Cabelo (ficará no fundo)
                      Align(
                        alignment: const Alignment(-0.7, -0.5),
                        child: Container(
                          width: 150,
                          height: 150,
                          color: colorToShow,
                        ),
                      ),

                      // 2. Olho Esquerdo
                      Align(
                        alignment: _selectedGender == 'Masculino'
                            ? const Alignment(-0.63, -0.37)
                            : const Alignment(-0.38, -0.4),
                        child: Container(
                          width: 15,
                          height: 15,
                          color: colorToShow2,
                        ),
                      ),

                      // 3. Olho Direito
                      Align(
                        alignment: _selectedGender == 'Masculino'
                            ? const Alignment(-0.415, -0.42)
                            : const Alignment(-0.5, -0.46),
                        child: Container(
                          width: 15,
                          height: 15,
                          color: colorToShow2,
                        ),
                      ),

                      // 4. Imagem do personagem (masculino/feminino)
                      if (_selectedGender == 'Masculino' || _selectedGender == 'Feminino')
                        Align(
                          alignment: const Alignment(-1.25, -0.75),
                          child: Transform.scale(
                            scale: 0.61,
                            child: Image.asset(_characterImage),
                          ),
                        ),
                      //-1,034 , -0.75
                      // 5. IMAGEM DE BASE (por cima de tudo que veio antes)
                      Image.asset('assets/images/character_base.png'),
                      CustomPaint(
                        size: Size.infinite,
                        painter: StatPainter(
                          fillColor: _selectedHairColor?.color ?? const Color(0xFF00BFFF),
                          power: _strength,
                          speed: _speed,
                          trick: _trick,
                          recovery: _recovery,
                          defense: _defense,
                          // EXEMPLO: Pentágono com 55% do tamanho e deslocado para a direita
                          sizeMultiplier: 0.38,
                          centerOffset: const Offset(84.5, -41), // (X, Y) -> 105 pixels para a direita, 0 para baixo
                        ),
                      ),

                      // 6. Nome do Personagem
                      if (_nameController.text.isNotEmpty)
                        Align(
                          alignment: const Alignment(-0.4, 0.045),
                          child: Padding(
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

                      // 7. Poder do Personagem
                      if (_selectedPower != 'Girar Poder')
                        Align(
                            alignment: const Alignment(-0.4, 0.09),
                            child: Text(
                              _selectedPower,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                              ),
                            )),
                      if (_currentStep == CharacterCreationStep.summary)
                        Align(
                            alignment: const Alignment(-0.4, 0.18),
                            child: Text(
                              finalLevel.toStringAsFixed(1),
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                              ),
                            )),
                      if (_strength > 0.0)
                        Align(
                          alignment: const Alignment(0.45, -0.75),
                          child: Text(
                            "(${_strength.toStringAsFixed(1)})",
                            style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 14),
                          ),
                        ),

                      // Velocidade (Speed) - Ponta Direita-Superior
                      if (_speed > 0.0)
                        Align(
                          alignment: const Alignment(0.94, -0.29),
                          child: Text(
                            "(${_speed.toStringAsFixed(1)})",
                            style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 14),
                          ),
                        ),

                      // Trick - Ponta Direita-Inferior
                      if (_trick > 0.0)
                        Align(
                          alignment: const Alignment(0.74, 0.23),
                          child: Text(
                            "(${_trick.toStringAsFixed(1)})",
                            style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 14),
                          ),
                        ),

                      // Recovery - Ponta Esquerda-Inferior
                      if (_recovery > 0.0)
                        Align(
                          alignment: const Alignment(0.2, 0.23),
                          child: Text(
                            "(${_recovery.toStringAsFixed(1)})",
                            style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 14),
                          ),
                        ),

                      // Defesa (Defense) - Ponta Esquerda-Superior
                      if (_defense > 0.0)
                        Align(
                          alignment: const Alignment(-0.03, -0.3),
                          child: Text(
                            "(${_defense.toStringAsFixed(1)})",
                            style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 14),
                          ),
                        ),
                    ],
                  ),
                ),
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


  // --- MÉTODOS DE CONSTRUÇÃO DOS PASSOS (CORRIGIDOS) ---

  Widget _buildCurrentStepWidget() {
    switch (_currentStep) {
      case CharacterCreationStep.name:
        return _buildNameStep();
      case CharacterCreationStep.gender:
        return _buildGenderStep();
      case CharacterCreationStep.hairColor:
        return _buildHairColorStep();
      case CharacterCreationStep.eyeColor:
        return _buildEyeColorStep();
      case CharacterCreationStep.origin:
        return _buildOriginStep();
    // NOVOS PASSOS usando o widget reutilizável
      case CharacterCreationStep.strength:
        return _buildStatStep(
          title: 'Passo 6: Força',
          selectedValue: _strength,
          controller: _strengthController,
          onResultIndex: (index) => setState(() {
            _strengthResultIndex = index;
            _strength = _statValues[index];
          }),
        );
      case CharacterCreationStep.speed:
        return _buildStatStep(
          title: 'Passo 7: Velocidade',
          selectedValue: _speed,
          controller: _speedController,
          onResultIndex: (index) => setState(() {
            _speedResultIndex = index;
            _speed = _statValues[index];
          }),
        );
      case CharacterCreationStep.trick:
        return _buildStatStep(
          title: 'Passo 8: Trick',
          selectedValue: _trick,
          controller: _trickController,
          onResultIndex: (index) => setState(() {
            _trickResultIndex = index;
            _trick = _statValues[index];
          }),
        );
      case CharacterCreationStep.recovery:
        return _buildStatStep(
          title: 'Passo 9: Recovery',
          selectedValue: _recovery,
          controller: _recoveryController,
          onResultIndex: (index) => setState(() {
            _recoveryResultIndex = index;
            _recovery = _statValues[index];
          }),
        );
      case CharacterCreationStep.defense:
        return _buildStatStep(
          title: 'Passo 10: Defesa',
          selectedValue: _defense,
          controller: _defenseController,
          onResultIndex: (index) => setState(() {
            _defenseResultIndex = index;
            _defense = _statValues[index];
          }),
        );
      case CharacterCreationStep.power:
        return _buildPowerStep();
      case CharacterCreationStep.summary:
        return _buildSummaryStep();
    }
  }

  Widget _buildNameStep() {
    return Column(
      children: [
        const Text('Passo 1: Nome', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _nameController,
                decoration: const InputDecoration(border: OutlineInputBorder(), labelText: 'Nome do Personagem'),
                onChanged: (text) => setState(() {}),
              ),
            ),
            const SizedBox(width: 8),
            ElevatedButton(onPressed: _randomizeName, child: const Text('Sortear')),
          ],
        ),
        const SizedBox(height: 40),
        ElevatedButton(onPressed: _nextStep, child: const Text('Próximo Passo')),
      ],
    );
  }

  Widget _buildGenderStep() {
    return Column(
      key: const ValueKey('gender_step'),
      children: [
        const Text('Passo 2: Gênero', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 20),
        SizedBox(
          height: 150,
          child: FortuneWheel(
            selected: _genderController.stream,
            animateFirst: false,
            items: [for (var gender in _genders) FortuneItem(child: Text(gender))],
            onAnimationEnd: () {
              setState(() {
                _selectedGender = _genders[_genderResultIndex];
              });
            },
          ),
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            _genderResultIndex = Fortune.randomInt(0, _genders.length);
            _genderController.add(_genderResultIndex);
          },
          child: const Text('Girar Roleta'),
        ),
        const SizedBox(height: 20),
        Text('Gênero selecionado: $_selectedGender', style: const TextStyle(fontSize: 16)),
        const SizedBox(height: 40),
        ElevatedButton(onPressed: _nextStep, child: const Text('Próximo Passo')),
      ],
    );
  }

  Widget _buildHairColorStep() {
    return Column(
      key: const ValueKey('hair_color_step'),
      children: [
        const Text('Passo 3: Cor do Cabelo', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 20),
        SizedBox(
          height: 150,
          child: FortuneWheel(
            selected: _hairColorController.stream,
            animateFirst: false,
            // MODIFICADO: Itens agora mostram cor e texto
            items: [
              for (var option in _hairColors)
                FortuneItem(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          color: option.color,
                          border: Border.all(color: Colors.black26, width: 1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Flexible( // 1. Envolva o Text com Flexible
                        child: Text(
                          option.name,
                          overflow: TextOverflow.ellipsis, // 2. Adicione overflow para cortar texto muito longo com "..."
                          softWrap: false, // 3. Impede que o texto quebre a linha
                        ),
                      ),
                    ],
                  ),
                ),
            ],
            onAnimationEnd: () => setState(() => _selectedHairColor = _hairColors[_hairColorResultIndex]),
          ),
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            _hairColorResultIndex = Fortune.randomInt(0, _hairColors.length);
            _hairColorController.add(_hairColorResultIndex);
          },
          child: const Text('Girar Roleta'),
        ),
        const SizedBox(height: 20),
        // MODIFICADO: Exibe o nome da cor selecionada, tratando o caso inicial nulo
        Text(
            'Cor do Cabelo: ${_selectedHairColor?.name ?? 'Gire a roleta'}',
            style: const TextStyle(fontSize: 16)
        ),
        const SizedBox(height: 40),
        ElevatedButton(onPressed: _nextStep, child: const Text('Próximo Passo')),
      ],
    );
  }

  Widget _buildEyeColorStep() {
    return Column(
      key: const ValueKey('eye_color_step'),
      children: [
        const Text('Passo 4: Cor dos Olhos', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 20),
        SizedBox(
          height: 150,
          child: FortuneWheel(
            selected: _eyeColorController.stream,
            animateFirst: false,
            // MODIFICADO: Itens agora mostram cor e texto
            items: [
              for (var option in _eyeColors)
                FortuneItem(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          color: option.color,
                          border: Border.all(color: Colors.black26, width: 1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Flexible( // 1. Envolva o Text com Flexible
                        child: Text(
                          option.name,
                          overflow: TextOverflow.ellipsis, // 2. Adicione overflow para cortar texto muito longo com "..."
                          softWrap: false, // 3. Impede que o texto quebre a linha
                        ),
                      ),
                    ],
                  ),
                ),
            ],
            onAnimationEnd: () => setState(() => _selectedEyeColor = _eyeColors[_eyeColorResultIndex]),
          ),
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            _eyeColorResultIndex = Fortune.randomInt(0, _eyeColors.length);
            _eyeColorController.add(_eyeColorResultIndex);
          },
          child: const Text('Girar Roleta'),
        ),
        const SizedBox(height: 20),
        // MODIFICADO: Exibe o nome da cor selecionada, tratando o caso inicial nulo
        Text(
            'Cor dos Olhos: ${_selectedEyeColor?.name ?? 'Gire a roleta'}',
            style: const TextStyle(fontSize: 16)
        ),
        const SizedBox(height: 40),
        ElevatedButton(onPressed: _nextStep, child: const Text('Próximo Passo')),
      ],
    );
  }

  Widget _buildPowerStep() {
    return Column(
      key: const ValueKey('power_step'),
      children: [
        const Text('Passo 5: Poder', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 20),
        SizedBox(
          height: 150,
          child: FortuneWheel(
            selected: _powerController.stream,
            animateFirst: false,
            items: [for (var power in _powers) FortuneItem(child: Text(power))],
            onAnimationEnd: () => setState(() => _selectedPower = _powers[_powerResultIndex]),
          ),
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            _powerResultIndex = Fortune.randomInt(0, _powers.length);
            _powerController.add(_powerResultIndex);
          },
          child: const Text('Girar Roleta'),
        ),
        const SizedBox(height: 20),
        Text('Poder selecionado: $_selectedPower', style: const TextStyle(fontSize: 16)),
        const SizedBox(height: 40),
        ElevatedButton(onPressed: _nextStep, child: const Text('Finalizar')),
      ],
    );
  }

  Widget _buildOriginStep() {
    return Column(
      key: const ValueKey('origin_step'),
      children: [
        const Text('Passo 5: Origem da Família', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 20),
        SizedBox(
          height: 150,
          child: FortuneWheel(
            selected: _originController.stream,
            animateFirst: false,
            // MODIFICADO: O item da roleta agora exibe a propriedade .name
            items: [for (var origin in _origins) FortuneItem(child: Text(origin.name))],

            // MODIFICADO: onAnimationEnd agora atualiza as duas variáveis
            onAnimationEnd: () {
              setState(() {
                _selectedOrigin = _origins[_originResultIndex];
                _originModifier = _selectedOrigin!.value;
              });
            },
          ),
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            final List<int> weights = [5, 10, 15, 40, 15, 10, 5];
            _originResultIndex = _getWeightedRandomIndex(weights);
            _originController.add(_originResultIndex);
          },
          child: const Text('Girar Roleta'),
        ),
        const SizedBox(height: 20),
        // MODIFICADO: Exibe o nome da origem selecionada
        Text(
            'Origem selecionada: ${_selectedOrigin?.name ?? 'Gire a roleta'}',
            style: const TextStyle(fontSize: 16)
        ),
        const SizedBox(height: 40),
        ElevatedButton(onPressed: _nextStep, child: const Text('Próximo Passo')),
      ],
    );
  }

  Widget _buildStatStep({
    required String title,
    required double selectedValue,
    required StreamController<int> controller,
    required void Function(int) onResultIndex, // Esta função agora será chamada no final
  }) {
    int tempResultIndex = 0; // Variável temporária para guardar o índice

    return Column(
      key: ValueKey(title),
      children: [
        Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 20),
        SizedBox(
          height: 150,
          child: FortuneWheel(
            selected: controller.stream,
            animateFirst: false,
            items: [for (var value in _statValues) FortuneItem(child: Text(value.toStringAsFixed(1)))],

            // --- CORREÇÃO PRINCIPAL AQUI ---
            // Agora, a atualização do valor acontece QUANDO A ANIMAÇÃO TERMINA.
            onAnimationEnd: () {
              onResultIndex(tempResultIndex);
            },
          ),
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            // 1. Sorteia o índice e o guarda temporariamente.
            tempResultIndex = _getStatRollIndex();
            // 2. Apenas manda a roleta girar. A atualização do valor ocorrerá no onAnimationEnd.
            controller.add(tempResultIndex);
          },
          child: const Text('Girar Roleta'),
        ),
        const SizedBox(height: 20),
        if (selectedValue > 0.0)
          Text(
            'Valor Sorteado: ${selectedValue.toStringAsFixed(1)}',
            style: const TextStyle(fontSize: 16),
          ),
        const SizedBox(height: 40),
        ElevatedButton(onPressed: _nextStep, child: const Text('Próximo Passo')),
      ],
    );
  }

  Widget _buildSummaryStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Resumo do Personagem', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 20),
        Text('Nome: ${_nameController.text.isEmpty ? 'Sem Nome' : _nameController.text}', style: const TextStyle(fontSize: 16)),
        Text('Gênero: $_selectedGender', style: const TextStyle(fontSize: 16)),
        Text('Cor do Cabelo: ${_selectedHairColor?.name ?? 'Não definida'}', style: const TextStyle(fontSize: 16)),
        Text('Cor dos Olhos: ${_selectedEyeColor?.name ?? 'Não definida'}', style: const TextStyle(fontSize: 16)),
        Text('Poder: $_selectedPower', style: const TextStyle(fontSize: 16)),
        const SizedBox(height: 40),
        Center(
          child: ElevatedButton(
            onPressed: _saveCharacter,
            child: const Text('Salvar Personagem'),
          ),
        ),
      ],
    );
  }
}