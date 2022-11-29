import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:snapretouch/common/constants.dart';
import 'package:snapretouch/generated/l10n.dart';
import 'package:snapretouch/models/detected_object.dart';
import 'package:snapretouch/pages/edit/widgets/detected_object_tab.dart';
import 'package:snapretouch/pages/edit/widgets/detected_object_tab_content.dart';
import 'package:snapretouch/providers/edit_provider/edit_provider.dart';

class DetailDetectedObject extends StatefulWidget {
  DetailDetectedObject({
    Key? key,
    required this.hideDetailDetectedObjects,
  }) : super(key: key);

  void Function() hideDetailDetectedObjects;

  @override
  State<DetailDetectedObject> createState() => _DetailDetectedObjectState();
}

class _DetailDetectedObjectState extends ProviderState<DetailDetectedObject, EditProvider> {
  int _indexTab = 0;

  DetectedObjectType get type => _indexTab == 0 ? DetectedObjectType.people : DetectedObjectType.other;

  late final PageController _pageController;

  final Map<DetectedObjectType, List<DetectedObject>> data = {
    DetectedObjectType.people: [],
    DetectedObjectType.other: [],
  };

  @override
  void initState() {
    super.initState();

    data[DetectedObjectType.people] = provider.state.getDetectedObjectsByType(DetectedObjectType.people);
    data[DetectedObjectType.other] = provider.state.getDetectedObjectsByType(DetectedObjectType.other);
    if ((data[DetectedObjectType.people]!.isEmpty) && data[DetectedObjectType.other]!.isNotEmpty) {
      _indexTab = 1;
    }
    _pageController = PageController(initialPage: _indexTab);
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
          padding:
              EdgeInsets.symmetric(horizontal: AppDimensions.instance.paddingSizeSmall).copyWith(top: AppDimensions.instance.paddingSizeExtraSmall),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: widget.hideDetailDetectedObjects,
                    child: Image.asset(AppImages.instance.icDeleteNormal3x, width: 25),
                  ),
                  SizedBox(width: AppDimensions.instance.paddingSizeExtraSmall),
                  PropConsumer<EditProvider, int>(
                    select: (p) => p.state.detectedObjects.values.length,
                    builder: (_, __, p, ___) => Text(
                      '${p.state.detectedObjects.values.length} ${S.of(context).objects}',
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
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
        SizedBox(height: AppDimensions.instance.paddingSizeDefault),
        SizedBox(
          height: MediaQuery.of(context).size.height * (0.5) / 3,
          child: PageView(
            controller: _pageController,
            children: [
              DetectedObjectTabContent(
                data: data[DetectedObjectType.people] ?? [],
              ),
              DetectedObjectTabContent(
                data: data[DetectedObjectType.other] ?? [],
              ),
            ],
          ),
        )
      ],
    );
  }
}
