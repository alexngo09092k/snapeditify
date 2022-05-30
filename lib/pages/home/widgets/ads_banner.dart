import 'package:flutter/material.dart';
import 'package:snapedit/common/constants.dart';
import 'package:snapedit/controllers/home/home_controller.dart';

class AdsBanner extends StatelessWidget {
  const AdsBanner({Key? key, required this.controller}) : super(key: key);
  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(AppDimensions.paddingSizeDefault),
      height: MediaQuery.of(context).size.height * 1 / 4,
      color: AppColors.disable,
      child: const Center(
        child: Text('Ads banner'),
      ),
    );
  }
}
