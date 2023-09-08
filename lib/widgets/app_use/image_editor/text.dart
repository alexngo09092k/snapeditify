import 'package:flutter/material.dart';
import 'package:snapeditify/common/constants.dart';
import 'package:snapeditify/generated/l10n.dart';
import 'package:snapeditify/widgets/app_use/image_editor/single_image_editor.dart';
import 'package:snapeditify/widgets/base/app_card.dart';
import 'package:snapeditify/widgets/base/custom_icon.dart';
import 'data/layer.dart';

import 'colors_picker.dart';

class TextEditorImage extends StatefulWidget {
  const TextEditorImage({super.key});

  @override
  createState() => _TextEditorImageState();
}

class _TextEditorImageState extends State<TextEditorImage> {
  TextEditingController name = TextEditingController();
  Color currentColor = AppColors.instance.darkPrimary;
  double slider = 32.0;
  TextAlign align = TextAlign.left;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: Navigator.of(context).pop,
          child: Container(
            padding: EdgeInsets.only(
              right: AppDimensions.instance.padding,
              left: AppDimensions.instance.padding,
            ),
            color: Colors.transparent,
            child: const CustomIcon(Icons.clear),
          ),
        ),
        actions: <Widget>[
          FeatureButton(
            icon: Icons.align_horizontal_left,
            color: align == TextAlign.left
                ? Theme.of(context).colorScheme.primary
                : null,
            onTap: () {
              setState(() {
                align = TextAlign.left;
              });
            },
          ),
          FeatureButton(
            icon: Icons.align_horizontal_center,
            color: align == TextAlign.center
                ? Theme.of(context).colorScheme.primary
                : null,
            onTap: () {
              setState(() {
                align = TextAlign.center;
              });
            },
          ),
          FeatureButton(
            icon: Icons.align_horizontal_right,
            color: align == TextAlign.right
                ? Theme.of(context).colorScheme.primary
                : null,
            onTap: () {
              setState(() {
                align = TextAlign.right;
              });
            },
          ),
          FeatureButton(
            icon: Icons.check,
            onTap: () {
              Navigator.pop(
                context,
                TextLayerData(
                  background: Colors.transparent,
                  text: name.text,
                  color: currentColor,
                  size: slider.toDouble(),
                  align: align,
                ),
              );
            },
          ),
          SizedBox(width: AppDimensions.instance.paddingX(0.5)),
        ],
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              AppCard(
                margin: EdgeInsets.all(AppDimensions.instance.padding),
                padding: EdgeInsets.all(AppDimensions.instance.padding),
                child: TextField(
                  controller: name,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Insert Your Message',
                  ),
                  scrollPadding: EdgeInsets.all(AppDimensions.instance.padding),
                  keyboardType: TextInputType.multiline,
                  minLines: 5,
                  maxLines: 99999,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: currentColor,
                      ),
                  autofocus: true,
                ),
              ),
              SizedBox(height: AppDimensions.instance.paddingX(2)),
              AppCard(
                margin: EdgeInsets.all(AppDimensions.instance.padding),
                padding: EdgeInsets.all(AppDimensions.instance.padding),
                child: Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 80,
                          child: Text(
                            S.of(context).color,
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(fontWeight: FontWeight.w700),
                          ),
                        ),
                        Expanded(
                          child: LayoutBuilder(builder: (_, constraints) {
                            return BarColorPicker(
                              width: constraints.maxWidth -
                                  AppDimensions.instance.paddingX(2),
                              thumbColor: Theme.of(context).colorScheme.primary,
                              cornerRadius: AppDimensions.instance.radius,
                              pickMode: PickMode.color,
                              colorListener: (int value) {
                                setState(() {
                                  currentColor = Color(value);
                                });
                              },
                            );
                          }),
                        ),
                      ],
                    ),
                    SizedBox(height: AppDimensions.instance.paddingX(2)),
                    Row(
                      children: [
                        SizedBox(
                          width: 80,
                          child: Text(
                            S.of(context).blackColor,
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(fontWeight: FontWeight.w700),
                          ),
                        ),
                        Expanded(
                          child: LayoutBuilder(
                            builder: (_, constraints) {
                              return BarColorPicker(
                                width: constraints.maxWidth -
                                    AppDimensions.instance.paddingX(2),
                                thumbColor:
                                    Theme.of(context).colorScheme.primary,
                                cornerRadius: 10,
                                pickMode: PickMode.grey,
                                colorListener: (int value) {
                                  setState(() {
                                    currentColor = Color(value);
                                  });
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: AppDimensions.instance.padding),
                    Row(
                      children: [
                        SizedBox(
                          width: 65,
                          child: Text(
                            S.of(context).textSize,
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(fontWeight: FontWeight.w700),
                          ),
                        ),
                        Expanded(
                          child: Slider(
                            value: slider,
                            min: 0.0,
                            max: 100.0,
                            onChangeEnd: (v) {
                              setState(() {
                                slider = v;
                              });
                            },
                            onChanged: (v) {
                              setState(() {
                                slider = v;
                              });
                            },
                          ),
                        ),
                        SizedBox(width: AppDimensions.instance.paddingX(0.5)),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
