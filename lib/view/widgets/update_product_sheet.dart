import 'package:flutter/material.dart';
import 'package:product/controller/product_controller.dart';
import 'package:product/controller/update_form_controller.dart';
import 'package:product/model/product.dart';
import 'package:product/view/widgets/form_label.dart';
import 'package:product/view/widgets/save_button.dart';
import 'package:product/view/widgets/sheet_handle.dart';
import 'package:product/view/widgets/sheet_header.dart';
import 'package:product/view/widgets/styled_field.dart';
import 'package:provider/provider.dart';


class UpdateProductSheet extends StatelessWidget {
  final Product product;

  const UpdateProductSheet({super.key, required this.product});


  static Future<void> show(BuildContext context, {required Product product}) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => ChangeNotifierProvider(
        create: (_) => UpdateFormController(product),
        child: UpdateProductSheet(product: product),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final formCtrl = context.watch<UpdateFormController>();
    final productCtrl = context.read<ProductController>();
    final isUpdating = context.watch<ProductController>().isUpdating;
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFFF5F0F8),
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      padding: EdgeInsets.fromLTRB(24, 20, 24, 24 + bottomInset),
      child: Form(
        key: formCtrl.formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           
            const SheetHandle(),

            const SizedBox(height: 20),

           
            SheetHeader(onClose: () => Navigator.pop(context)),

            const SizedBox(height: 24),

  
            const FormLabel(label: 'Title'),
            const SizedBox(height: 6),
            StyledField(
              controller: formCtrl.titleCtrl,
              hint: 'Product title',
              validator: (v) => (v == null || v.trim().isEmpty)
                  ? 'Title is required'
                  : null,
            ),

            const SizedBox(height: 16),

            
            const FormLabel(label: 'Price (USD)'),
            const SizedBox(height: 6),
            StyledField(
              controller: formCtrl.priceCtrl,
              hint: '0.00',
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              validator: (v) {
                if (v == null || v.trim().isEmpty) return 'Price is required';
                if (double.tryParse(v.trim()) == null) {
                  return 'Enter a valid number';
                }
                return null;
              },
            ),

            const SizedBox(height: 16),

           
            const FormLabel(label: 'Description'),
            const SizedBox(height: 6),
            StyledField(
              controller: formCtrl.descCtrl,
              hint: 'Product description',
              maxLines: 3,
              validator: (v) => (v == null || v.trim().isEmpty)
                  ? 'Description is required'
                  : null,
            ),

            const SizedBox(height: 28),

           
            SaveButton(
              isLoading: isUpdating,
              onPressed: () => formCtrl.submit(
                context: context,
                productId: product.id,
                productController: productCtrl,
              ),
            ),
          ],
        ),
      ),
    );
  }
}










