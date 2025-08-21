// Em: lib/create_character_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'dart:async';
import 'dart:math';
import 'package:unordinaryroulette/character.dart';

// Adicione esta classe no topo do seu arquivo
class ColorOption {
  final String name;
  final Color color;

  const ColorOption({required this.name, required this.color});
}


// MODIFICADO: Adicionando os novos passos
enum CharacterCreationStep { name, gender, hairColor, eyeColor, power, summary }

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

  // Controllers
  final StreamController<int> _genderController = StreamController<int>();
  final StreamController<int> _powerController = StreamController<int>();
  final StreamController<int> _hairColorController = StreamController<int>();
  final StreamController<int> _eyeColorController = StreamController<int>();

  // Índices de Resultado
  int _genderResultIndex = 0;
  int _powerResultIndex = 0;
  int _hairColorResultIndex = 0;
  int _eyeColorResultIndex = 0;

  // Listas de Opções
  final List<String> _genders = ['Masculino', 'Feminino'];
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

  @override
  void dispose() {
    _nameController.dispose();
    _genderController.close();
    _powerController.close();
    _hairColorController.close();
    _eyeColorController.close();
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
          _currentStep = CharacterCreationStep.power;
          break;
        case CharacterCreationStep.power:
          if (_selectedPower == 'Girar Poder') {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Por favor, gire a roleta do Poder.')),
            );
            return;
          }
          _currentStep = CharacterCreationStep.summary;
          break;
        case CharacterCreationStep.summary:
          break;
      }
    });
  }

  void _saveCharacter() {
    // O '!' é seguro aqui porque a lógica do _nextStep impede que cheguemos aqui com valores nulos.
    final newCharacter = Character(
      name: _nameController.text.isEmpty ? 'Sem Nome' : _nameController.text,
      gender: _selectedGender,
      hairColor: _selectedHairColor!.name, // Salva apenas o nome da cor
      eyeColor: _selectedEyeColor!.name,   // Salva apenas o nome da cor
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
    Color colorToShow = _selectedHairColor?.color ?? Colors.white;
    Color colorToShow2 = _selectedEyeColor?.color ?? Colors.white;

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
              height: 300, // Altura da sua imagem base
              child: Stack(
                  // O alinhamento do Stack continua no centro para a imagem de base
                alignment: Alignment.center,
                children: [
                  Align(
                   alignment: Alignment(-0.2, 0),
                   child:Container(
                     width: 150,   // 200 pixels de largura
                     height: 150,  // 100 pixels de altura
                     color: colorToShow,


                   )
                  ),
                  Align(
                    // A mágica acontece aqui
                    alignment: _selectedGender == 'Masculino'
                        ? Alignment(-0.22,-0.10)   // Se a condição for VERDADEIRA (gênero é Masculino)
                        : Alignment(-0.176,-0.22), // Se a condição for FALSA (qualquer outra coisa, como Feminino)
                    child: Container(
                      width: 15,
                      height: 15,
                      color: colorToShow2,
                    ),
                  ),
                  Align(
                    // A mágica acontece aqui
                    alignment: _selectedGender == 'Masculino'
                        ? Alignment(-0.155,-0.17)   // Se a condição for VERDADEIRA (gênero é Masculino)
                        : Alignment(-0.135,-0.17), // Se a condição for FALSA (qualquer outra coisa, como Feminino)
                    child: Container(
                      width: 15,
                      height: 15,
                      color: colorToShow2,
                    ),
                  ),
                  // CONDIÇÃO ATUALIZADA com os novos widgets
                  if (_selectedGender == 'Masculino' || _selectedGender == 'Feminino')
                    Align(
                      // 1. POSICIONAMENTO:
                      //    -0.2 move o widget 10% para a esquerda do centro.
                      //    Valores vão de -1.0 (extrema esquerda) a 1.0 (extrema direita).
                      alignment: const Alignment(-0.216, 0.0),
                      child: Transform.scale(
                        // 2. TAMANHO:
                        //    0.8 torna o widget 20% menor (80% do tamanho original).
                        //    1.0 é o tamanho normal.
                        scale: 0.61,
                        child: Image.asset(_characterImage),
                      ),
                    ),
                  Image.asset('assets/images/character_base.png'),
                  if (_nameController.text.isNotEmpty)
                    Align(
                      // Alinha o texto na parte de baixo e centralizado
                      alignment: const Alignment(-0.14, 0.56),
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
                  if (_selectedPower != 'Girar Poder')
                  Align(
                    alignment: Alignment(-0.14, 0.61),
                    child:Text(
                      _selectedPower,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                      ),
                    )
                  )
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