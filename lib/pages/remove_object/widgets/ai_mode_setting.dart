import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:snapedit/common/constants.dart';
import 'package:snapedit/generated/l10n.dart';
import 'package:snapedit/models/ai_detection_handler.dart';
import 'package:snapedit/providers/remove_object/remove_object_provider.dart';
import 'package:snapedit/services/snap_edit/snap_edit.dart';
import 'package:snapedit/widgets/base/sliding_control.dart';
import 'package:snapedit/widgets/base/tile_row.dart';

class AIModeSetting extends StatefulWidget {
  const AIModeSetting({Key? key, required this.provider}) : super(key: key);
  final RemoveObjectProvider provider;

  @override
  State<AIModeSetting> createState() => _AIModeSettingState();
}

class _AIModeSettingState extends ProviderState<AIModeSetting, RemoveObjectProvider> {
  int _indexTab = 0;

  late final PageController _controller;

  @override
  void initState() {
    _controller = PageController(initialPage: _indexTab);
    super.initState();
  }

  _onChangedTab(DetectedObjectType type) {
    switch (type) {
      case DetectedObjectType.person:
        _indexTab = 0;
        break;
      case DetectedObjectType.other:
        _indexTab = 1;
        break;
      default:
    }
    _controller.animateToPage(
      0,
      duration: const Duration(),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: AppDimensions.instance.paddingX(1)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () => provider.toBrush(context),
                    child: Image.asset(AppAssets.instance.icAdd, width: 25),
                  ),
                  SizedBox(width: AppDimensions.instance.paddingX(1)),
                  BasePropConsumer<RemoveObjectProvider, int>(
                    listenable: provider,
                    select: (p) => p.state.detectedObjects.values.length,
                    builder: (_, __, p, ___) => Text(
                      '${p.state.detectedObjects.values.length} ${S.of(context).objects}',
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                  ),
                ],
              ),
              const Expanded(flex: 1, child: SizedBox()),
              SlidingControl<DetectedObjectType>.defaultStyle(
                context,
                value: DetectedObjectType.person,
                data: DetectedObjectType.values.asMap().map((_, type) => MapEntry(type, type.label)),
                onValueChanged: _onChangedTab,
              ),
            ],
          ),
        ),
        SizedBox(height: AppDimensions.instance.padding),
        SizedBox(
          height: MediaQuery.of(context).size.height * (0.5) / 3,
          child: PageView(
            controller: _controller,
            children: DetectedObjectType.values
                .map<Widget>((type) => _TabContent(
                      type: type,
                      provider: provider,
                    ))
                .toList(),
          ),
        )
      ],
    );
  }
}

class _TabContent extends StatelessWidget {
  const _TabContent({Key? key, required this.type, required this.provider}) : super(key: key);

  final DetectedObjectType type;
  final RemoveObjectProvider provider;

  @override
  Widget build(BuildContext context) {
    return BasePropConsumer<RemoveObjectProvider, int>(
        listenable: provider,
        select: (p) => p.state.detectedObjects.values.where((detectedObject) => detectedObject.objectType == type).length,
        builder: (_, __, p, ___) {
          final data = p.state.detectedObjects.values.where((detectedObject) => detectedObject.objectType == type);
          return data.isNotEmpty
              ? ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (_, index) => _DetectedObjectRow(
                    key: ValueKey(index),
                    detectedObject: data.elementAt(index),
                    provider: provider,
                  ),
                )
              : SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        AppAssets.instance.icAdd,
                        width: 70,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(height: AppDimensions.instance.padding),
                      Text(
                        S.of(context).noPotentialObjectHasBeenDetected,
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(color: Theme.of(context).disabledColor),
                      )
                    ],
                  ),
                );
        });
  }
}

class _DetectedObjectRow extends StatelessWidget {
  const _DetectedObjectRow({Key? key, required this.detectedObject, required this.provider}) : super(key: key);
  final DetectedObjectHandler detectedObject;
  final RemoveObjectProvider provider;

  @override
  Widget build(BuildContext context) {
    final imageWidget = ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(5)),
      child: SizedBox(
        width: 60,
        height: 60,
        child: Center(
          child: detectedObject.image != null
              ? Image.memory(
                  base64.decode(detectedObject.image!),
                )
              : const SizedBox(),
        ),
      ),
    );
    final actionWidget = BasePropConsumer<RemoveObjectProvider, bool>(
      listenable: provider,
      select: (p) => p.state.detectedObjects[detectedObject.maskId]!.isSelected,
      builder: (_, __, p, ___) {
        return Container(
          alignment: Alignment.center,
          child: Image.asset(
            detectedObject.isSelected ? AppAssets.instance.icCheckboxSelected : AppAssets.instance.icCheckbox,
            width: 30,
          ),
        );
      },
    );
    final subTitle = Text(
      '${(int.parse(detectedObject.accuracy) * 100).toStringAsFixed(2)} ${S.of(context).accurate}',
      style: Theme.of(context).textTheme.bodyText2!,
    );
    final title = Text(
      detectedObject.objectDescription,
      style: Theme.of(context).textTheme.subtitle1,
    );
    final removeText = Container(
      padding: EdgeInsets.all(AppDimensions.instance.paddingX(1)),
      decoration: BoxDecoration(
        color: Colors.red.withOpacity(0.1),
        borderRadius: const BorderRadius.all(Radius.circular(5)),
      ),
      child: Text(
        S.of(context).removed,
        style: Theme.of(context).textTheme.bodyText2!.copyWith(
              color: Colors.red,
            ),
      ),
    );
    return BasePropConsumer<RemoveObjectProvider, bool>(
      listenable: provider,
      select: (p) => p.state.detectedObjects[detectedObject.maskId]?.isRemoved ?? false,
      builder: (_, __, p, ___) => TileRow(
        leading: imageWidget,
        main: Column(
          children: [
            Row(children: [title, if (p.state.detectedObjects[detectedObject.maskId]?.isRemoved ?? false) removeText]),
            subTitle
          ],
        ),
        action: actionWidget,
      ),
    );
  }
}
