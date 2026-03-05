import 'package:flutter/material.dart';

class SheetHeader extends StatelessWidget {
  final VoidCallback onClose;
  const SheetHeader({required this.onClose,super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Edit Product',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w800,
            color: Color(0xFF1A1A2E),
          ),
        ),
        GestureDetector(
          onTap: onClose,
          child: Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.close_rounded,
              size: 18,
              color: Color(0xFF9E9E9E),
            ),
          ),
        ),
      ],
    );
  }
}
