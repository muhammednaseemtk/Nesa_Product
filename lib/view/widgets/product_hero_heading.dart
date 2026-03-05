import 'package:flutter/material.dart';


class ProductHeroHeading extends StatelessWidget {
  final String title;
  final String subtitle;

  const ProductHeroHeading({
    super.key,
    this.title = 'Discover our\nexclusive products',
    this.subtitle =
        'In this marketplace, you will find various\ntechnics in the cheapest price',
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w800,
              color: Color(0xFF1A1A2E),
              height: 1.25,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            style: const TextStyle(
              fontSize: 13,
              color: Color(0xFF9E9E9E),
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}