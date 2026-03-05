import 'package:flutter/material.dart';


class DetailDescriptionSection extends StatelessWidget {
  final String description;

  const DetailDescriptionSection({super.key, required this.description});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Description',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Color(0xFF1A1A2E),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          description,
          style: const TextStyle(
            fontSize: 14,
            color: Color(0xFF9E9E9E),
            height: 1.65,
          ),
        ),
      ],
    );
  }
}