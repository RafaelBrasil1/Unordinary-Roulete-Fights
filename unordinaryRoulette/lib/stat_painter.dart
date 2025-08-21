// Em: lib/stat_painter.dart

import 'package:flutter/material.dart';
import 'dart:math' as math;

class StatPainter extends CustomPainter {
  final double power;
  final double speed;
  final double trick;
  final double recovery;
  final double defense;
  // NOVAS PROPRIEDADES para customização
  final double sizeMultiplier; // Controla o tamanho (ex: 0.8 = 80%)
  final Offset centerOffset;   // Controla o deslocamento (ex: Offset(10, 0) = 10 pixels para a direita)
  final Color fillColor;

  StatPainter({
    required this.power,
    required this.speed,
    required this.trick,
    required this.recovery,
    required this.defense,
    required this.fillColor,
    this.sizeMultiplier = 0.8, // Valor padrão de 80% do tamanho
    this.centerOffset = Offset.zero, // Valor padrão sem deslocamento
  });

  @override
  void paint(Canvas canvas, Size size) {
    // APLICA O DESLOCAMENTO ao centro
    final centerX = (size.width / 2) + centerOffset.dx;
    final centerY = (size.height / 2) + centerOffset.dy;

    // APLICA O MULTIPLICADOR DE TAMANHO ao raio
    final radius = math.min(size.width / 2, size.height / 2) * sizeMultiplier;

    final paint = Paint()
      ..color = fillColor.withOpacity(0.7)
      ..style = PaintingStyle.fill;

    final path = Path();
    final stats = [power, speed, trick, recovery, defense];
    const statMaxValue = 10.0;
    const minimumStatValue = 0.1;

    for (int i = 0; i < stats.length; i++) {
      final angle = (math.pi / -2) + (i * 2 * math.pi / 5);
      final statToDraw = math.max(stats[i], minimumStatValue);
      final statRadius = radius * (statToDraw / statMaxValue);

      final x = centerX + statRadius * math.cos(angle);
      final y = centerY + statRadius * math.sin(angle);
      final point = Offset(x, y);

      if (i == 0) {
        path.moveTo(point.dx, point.dy);
      } else {
        path.lineTo(point.dx, point.dy);
      }
    }

    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant StatPainter oldDelegate) {
    return oldDelegate.power != power ||
        oldDelegate.speed != speed ||
        oldDelegate.trick != trick ||
        oldDelegate.recovery != recovery ||
        oldDelegate.defense != defense ||
        oldDelegate.sizeMultiplier != sizeMultiplier || // Repinta se o tamanho mudar
        oldDelegate.centerOffset != centerOffset;     // Repinta se a posição mudar
  }
}