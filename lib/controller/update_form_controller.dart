import 'package:flutter/material.dart';
import '../model/product.dart';
import 'product_controller.dart';
class UpdateFormController extends ChangeNotifier {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late final TextEditingController titleCtrl;
  late final TextEditingController priceCtrl;
  late final TextEditingController descCtrl;

  UpdateFormController(Product product) {
    titleCtrl = TextEditingController(text: product.title);
    priceCtrl = TextEditingController(
        text: product.price.toStringAsFixed(2));
    descCtrl = TextEditingController(text: product.description);
  }

  @override
  void dispose() {
    titleCtrl.dispose();
    priceCtrl.dispose();
    descCtrl.dispose();
    super.dispose();
  }


  Future<void> submit({
    required BuildContext context,
    required int productId,
    required ProductController productController,
  }) async {
    if (!formKey.currentState!.validate()) return;

    final data = {
      'title': titleCtrl.text.trim(),
      'price': double.parse(priceCtrl.text.trim()),
      'description': descCtrl.text.trim(),
    };

    final success =
        await productController.updateProduct(productId, data);

    if (!context.mounted) return;

    Navigator.pop(context);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          success
              ? 'Product updated successfully!'
              : 'Update failed. Try again.',
        ),
        backgroundColor:
            success ? const Color(0xFF6B3FA0) : Colors.redAccent,
        behavior: SnackBarBehavior.floating,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}