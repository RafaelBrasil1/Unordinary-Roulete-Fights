import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'dart:async';
import 'dart:math';

class SpinningWheelPage extends StatefulWidget {
  const SpinningWheelPage({Key? key}) : super(key: key);

  @override
  State<SpinningWheelPage> createState() => _SpinningWheelPageState();
}

class _SpinningWheelPageState extends State<SpinningWheelPage> {
  final List<String> items = ['Opção 1', 'Opção 2', 'Opção 3', 'Opção 4', 'Opção 5', 'Opção 6'];
  final StreamController<int> _controller = StreamController<int>();
  int _selectedItem = 0; // Armazena o índice do item selecionado

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Roleta da Sorte'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 300,
              child: FortuneWheel(
                selected: _controller.stream,
                animateFirst: false,
                items: [
                  for (var item in items)
                    FortuneItem(
                      child: Text(
                        item,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                ],
                onAnimationEnd: () {
                  // Agora usamos o índice que a roleta parou para pegar o item correto.
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('O resultado é: ${items[_selectedItem]}'),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 50),
            ElevatedButton(
              onPressed: () {
                // Ao pressionar o botão, um índice aleatório é gerado e armazenado.
                _selectedItem = Fortune.randomInt(0, items.length);
                // Esse índice é adicionado ao stream, fazendo a roleta girar e parar nele.
                _controller.add(_selectedItem);
              },
              child: const Text('Girar Roleta'),
            ),
          ],
        ),
      ),
    );
  }
}