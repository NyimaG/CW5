import 'dart:math';
import 'package:flutter/material.dart';

class Fish {
  Color color;
  double speed; // Speed of the fish
  Offset position; // Current position of the fish
  double direction; // Current direction of movement

  Fish({required this.color, required this.speed})
      : position =
            Offset(Random().nextDouble() * 300, Random().nextDouble() * 300),
        direction = Random().nextDouble() * 2 * pi; // Random initial direction

  void updatePosition(double containerWidth, double containerHeight) {
    // Update the position based on speed and direction
    position = Offset(
      position.dx + cos(direction) * speed,
      position.dy + sin(direction) * speed,
    );
    if (position.dx < 0) {
      position = Offset(0, position.dy); // Reset position to edge
      direction = pi - direction; // Reverse direction on x-axis
    }
    if (position.dx > containerWidth) {
      position = Offset(containerWidth, position.dy); // Reset position to edge
      direction = pi - direction; // Reverse direction on x-axis
    }
    if (position.dy < 0) {
      position = Offset(position.dx, 0); // Reset position to edge
      direction = -direction; // Reverse direction on y-axis
    }
    if (position.dy > containerHeight) {
      position = Offset(position.dx, containerHeight); // Reset position to edge
      direction = -direction; // Reverse direction on y-axis
    }
    // Check for collision with edges
    /*if (position.dx < 0 || position.dx > containerWidth) {
      position = Offset(0, position.dy); // Reset position to edge
      direction = pi - direction; // Reverse direction on x-axis
    }
    if (position.dy < 0 || position.dy > containerHeight) {
      direction = -direction; // Reverse direction on y-axis
    }
    */
  }

  void setSpeed(double newSpeed) {
    speed = newSpeed; // Update the speed
  }
}
