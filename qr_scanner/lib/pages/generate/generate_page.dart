import 'package:flutter/material.dart';
import 'package:qr_scanner/common/constants.dart';
import 'package:qr_scanner/models/qr_type.dart';
import 'package:qr_scanner/pages/generate/widgets/generate_item.dart';

class GeneratePage extends StatelessWidget {
  const GeneratePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Column(
          children: [
            Expanded(
              child: GridView.builder(
                padding: EdgeInsets.only(
                  bottom: 100,
                  left: AppDimensions.instance.padding,
                  right: AppDimensions.instance.padding,
                ),
                gridDelegate: AppDimensions.instance.gridDelegate,
                itemCount: QRType.values.length,
                itemBuilder: (_, __) => GenerateItem(type: QRType.values[__]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
