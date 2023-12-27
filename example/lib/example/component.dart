import 'package:flutter/material.dart';

class InputTextRectangle extends StatelessWidget {
  const InputTextRectangle({super.key});

  @override
  Widget build(BuildContext context) {
    return const TextField(
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide: BorderSide(
            color: Colors.pink,
          ),
        ),
      ),
    );
  }
}

class InputTextRounded extends StatelessWidget {
  const InputTextRounded({super.key});

  @override
  Widget build(BuildContext context) {
    return const TextField(
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
          borderSide: BorderSide(
            color: Colors.pink,
          ),
        ),
      ),
    );
  }
}
