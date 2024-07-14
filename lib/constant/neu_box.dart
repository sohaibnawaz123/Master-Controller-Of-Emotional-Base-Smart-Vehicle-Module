import 'package:flutter/material.dart';

class NeuBox extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final thechild;
  const NeuBox(
      {super.key, required this.thechild});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(color: Colors.grey[300],
      borderRadius: BorderRadius.circular(12),
       boxShadow: [
        BoxShadow(
            color: Colors.grey.shade500,
            blurRadius: 15,
            offset: const Offset(5, 5)),
        const BoxShadow(
            color: Colors.white, blurRadius: 15, offset: Offset(-5, -5))
      ]),
      child: Center(child: thechild),
    );
  }
}
