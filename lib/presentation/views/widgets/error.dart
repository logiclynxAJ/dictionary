import 'package:dictionary/config/configs.dart';
import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          const Spacer(),
          const Icon(Icons.error_outline, size: 64, color: Colors.black),
          const SizedBox(height: 36),
          Text(
            AppConfigs.strings.noResultFoundError,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 18),
          ),
          const Spacer(flex: 2),
        ],
      ),
    );
  }
}
