import 'package:flutter/material.dart';


///
/// [textController] is owned by [ProductController] and disposed there.
/// The × clear button visibility is driven by [searchQuery] from the
/// controller, so the widget always reflects the true controller state
/// without needing [setState].
class ProductSearchBar extends StatelessWidget {
  final TextEditingController textController;
  final String searchQuery;
  final ValueChanged<String> onChanged;
  final VoidCallback onClear;
  final String hint;

  const ProductSearchBar({
    super.key,
    required this.textController,
    required this.searchQuery,
    required this.onChanged,
    required this.onClear,
    this.hint = 'Search products…',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: TextField(
        controller: textController,
        onChanged: onChanged,
        textAlignVertical: TextAlignVertical.center,
        style: const TextStyle(
          fontSize: 14,
          color: Color(0xFF1A1A2E),
        ),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(
            fontSize: 14,
            color: Color(0xFFBBBBBB),
          ),
          prefixIcon: const Icon(
            Icons.search_rounded,
            color: Color(0xFF6B3FA0),
            size: 22,
          ),
          
          suffixIcon: searchQuery.isNotEmpty
              ? GestureDetector(
                  onTap: onClear,
                  child: const Icon(
                    Icons.close_rounded,
                    color: Color(0xFFBBBBBB),
                    size: 20,
                  ),
                )
              : null,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 14),
        ),
      ),
    );
  }
}