import 'package:flutter/material.dart';
class DetailTitleBlock extends StatelessWidget {
  final String title;
  final String category;

  const DetailTitleBlock({
    super.key,
    required this.title,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w800,
            color: Color(0xFF1A1A2E),
            height: 1.3,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: const Color(0xFF6B3FA0).withOpacity(0.10),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            category.toUpperCase(),
            style: const TextStyle(
              fontSize: 10,
              letterSpacing: 1.4,
              color: Color(0xFF6B3FA0),
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}