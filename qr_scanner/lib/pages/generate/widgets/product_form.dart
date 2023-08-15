import 'package:flutter/material.dart';
import 'package:qr_scanner/common/constants.dart';
import 'package:qr_scanner/models/qr_forms/qr_product_form.dart';
import 'package:qr_scanner/models/qr_type.dart';
import 'package:qr_scanner/pages/generate/widgets/base_form.dart';
import 'package:qr_scanner/pages/generate/widgets/base_form_state.dart';
import 'package:qr_scanner/pages/generate/widgets/prefix_icon.dart';
import 'package:qr_scanner/widgets/app_use/input.dart';

class ProductForm extends StatefulWidget {
  const ProductForm({super.key});

  @override
  State<ProductForm> createState() => _ProductFormState();
}

class _ProductFormState extends BaseFormState<ProductForm, QRProductForm> {
  @override
  void initState() {
    form = QRProductForm();
    super.initState();
  }

  void _onChanged(String _) {
    form.product = _;
    checkDisabled();
  }

  @override
  Widget build(BuildContext context) {
    return BaseForm(
      onData: onData,
      onQRFormat: onQRFormat,
      qrType: QRType.product,
      isDisabled: isDisabled,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Input(
            prefixIcon: PrefixIcon(icon: AppAssets.instance.gProduct),
            hintText: "What's about your product?",
            onChanged: _onChanged,
          ),
        ],
      ),
    );
  }
}
