import 'package:flutter/widgets.dart';

class ClientName extends StatelessWidget {
  final String name;

  const ClientName({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Text(
      name,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
