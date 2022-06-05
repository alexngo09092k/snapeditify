import 'package:flutter/material.dart';
import 'package:snapretouch/common/constants.dart';
import 'package:snapretouch/controllers/edit/edit_controller.dart';
import 'package:snapretouch/generated/l10n.dart';
import 'package:snapretouch/models/detected_object.dart';
import 'package:snapretouch/pages/edit/widgets/detected_object_tab.dart';
import 'package:snapretouch/pages/edit/widgets/detected_object_tab_content.dart';

class DetailDetectedObject extends StatefulWidget {
  DetailDetectedObject({
    Key? key,
    required this.controller,
    required this.hideDetailDetectedObjects,
  }) : super(key: key);

  final EditController controller;
  void Function() hideDetailDetectedObjects;

  @override
  State<DetailDetectedObject> createState() => _DetailDetectedObjectState();
}

class _DetailDetectedObjectState extends State<DetailDetectedObject> {
  int _indexTab = 0;

  DetectedObjectType get type =>
      _indexTab == 0 ? DetectedObjectType.people : DetectedObjectType.other;

  late final PageController _pageController;

  final Map<DetectedObjectType, List<DetectedObject>> data = {
    DetectedObjectType.people: [],
    DetectedObjectType.other: [],
  };

  @override
  void initState() {
    data[DetectedObjectType.people] = widget.controller.state
        .getDetectedObjectsByType(DetectedObjectType.people);
    data[DetectedObjectType.other] = widget.controller.state
        .getDetectedObjectsByType(DetectedObjectType.other);
    if ((data[DetectedObjectType.people]!.isEmpty) &&
        data[DetectedObjectType.other]!.isNotEmpty) {
      _indexTab = 1;
    }
    _pageController = PageController(initialPage: _indexTab);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.paddingSizeSmall,
          ).copyWith(top: AppDimensions.paddingSizeSmall),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: widget.hideDetailDetectedObjects,
                    child: Image.asset(AppImages.icDeleteNormal3x, width: 25),
                  ),
                  const SizedBox(width: AppDimensions.paddingSizeExtraSmall),
                  Text(
                    '${widget.controller.state.detectedObjects.values.length} ${S.of(context).objects}',
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                ],
              ),
              const Expanded(flex: 1, child: SizedBox()),
              DetectedObjectTab(
                controller: _pageController,
                onChangedTab: (i) {
                  _pageController.animateToPage(
                    i,
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeInOut,
                  );
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: AppDimensions.paddingSizeDefault),
        SizedBox(
          height: MediaQuery.of(context).size.height * (0.5) / 3,
          child: PageView(
            controller: _pageController,
            children: [
              DetectedObjectTabContent(
                controller: widget.controller,
                data: data[DetectedObjectType.people] ?? [],
              ),
              DetectedObjectTabContent(
                controller: widget.controller,
                data: data[DetectedObjectType.other] ?? [],
              ),
            ],
          ),
        )
      ],
    );
  }
}
