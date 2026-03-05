import 'package:flutter/material.dart';


class SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback onShowAll;

  const SectionHeader({
    super.key,
    required this.title,
    required this.onShowAll,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
         
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1A1A2E),
            ),
          ),

         
          GestureDetector(
            onTap: onShowAll,
            child: const Text(
              'Show All',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Color(0xFF6B3FA0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}