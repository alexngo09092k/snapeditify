import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:snapedit/common/constants.dart';
import 'package:snapedit/controllers/edit/edit_controller.dart';
import 'package:snapedit/generated/l10n.dart';
import 'package:snapedit/models/detected_object.dart';
import 'package:snapedit/pages/edit/widgets/detected_object_row.dart';

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
  DetectedObjectType type = DetectedObjectType.people;

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
      type = DetectedObjectType.other;
    }

    super.initState();
  }

  void onChangeType(value) {
    type = value!;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.paddingSizeSmall)
              .copyWith(top: AppDimensions.paddingSizeSmall),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: widget.hideDetailDetectedObjects,
                    child: Image.asset(AppImages.icDeleteNormal3x, width: 20),
                  ),
                  const SizedBox(width: AppDimensions.paddingSizeExtraSmall),
                  Text(
                    '${widget.controller.state.detectedObjects.values.length} ${S.of(context).objects}',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ],
              ),
              const Expanded(flex: 1, child: SizedBox()),
              Expanded(
                flex: 1,
                child: CupertinoSlidingSegmentedControl<DetectedObjectType>(
                  backgroundColor: Theme.of(context).highlightColor,
                  thumbColor: Theme.of(context).backgroundColor,
                  groupValue: type,
                  children: {
                    DetectedObjectType.people: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      child: Text(
                        DetectedObjectType.people.name,
                      ),
                    ),
                    DetectedObjectType.other: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      child: Text(
                        DetectedObjectType.other.name,
                      ),
                    ),
                  },
                  onValueChanged: onChangeType,
                ),
              ),
            ],
          ),
        ),
        const Divider(),
        SizedBox(
          height: 160,
          child: data[type]!.isNotEmpty
              ? ListView.builder(
                  itemCount: data[type]!.length,
                  itemBuilder: (_, index) => DetectedObjectRow(
                    controller: widget.controller,
                    maskId: data[type]!.elementAt(index).maskId,
                  ),
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      AppImages.imgNoObjectsNormal3x,
                      width: 80,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(height: AppDimensions.paddingSizeDefault),
                    Text(
                      S.of(context).noPotentialObjectHasBeenDetected,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(color: Theme.of(context).disabledColor),
                    )
                  ],
                ),
        )
      ],
    );
  }
}
