import 'package:flutter/material.dart';
import 'package:snapeditify/common/constants.dart';
import 'package:snapeditify/providers/gallery/gallery_provider.dart';
import 'package:snapeditify/widgets/base/app_card.dart';

class HomeBaseTools extends StatelessWidget {
  const HomeBaseTools({super.key, required this.editImageTypes});
  final List<EditImageType> editImageTypes;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.all(AppDimensions.instance.padding),
        itemBuilder: (_, __) => HomeBaseTool(editImageType: editImageTypes[__]),
        itemCount: editImageTypes.length,
      ),
    );
  }
}

class HomeBaseTool extends StatelessWidget {
  const HomeBaseTool({super.key, required this.editImageType});
  final EditImageType editImageType;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppAssets.instance.placeholder),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
