import 'package:flutter/material.dart';
import 'package:product/controller/product_controller.dart';
import 'package:provider/provider.dart';

class DetailFetchTrigger extends StatefulWidget {
  final int id;
  const DetailFetchTrigger({required this.id});

  @override
  State<DetailFetchTrigger> createState() => _DetailFetchTriggerState();
}

class _DetailFetchTriggerState extends State<DetailFetchTrigger> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<ProductController>().fetchProductById(widget.id);
      }
    });
  }

  @override
  Widget build(BuildContext context) => const SizedBox.shrink();
}