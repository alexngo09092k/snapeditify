import 'package:flutter/material.dart';
import 'package:snapretouch/common/app_routes.dart';
import 'package:snapretouch/common/constants.dart';
import 'package:snapretouch/controllers/edit/edit_controller.dart';
import 'package:snapretouch/generated/l10n.dart';
import 'package:snapretouch/modules/advertisement/models/advertisement_view.dart';
import 'package:snapretouch/pages/edit/widgets/count_detected_object.dart';
import 'package:snapretouch/pages/edit/widgets/detail_detected_object.dart';
import 'package:snapretouch/pages/edit/widgets/stroke_width_slider.dart';
import 'package:snapretouch/services/services.dart';

class PaintControl extends StatefulWidget {
  const PaintControl({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final EditController controller;

  @override
  State<PaintControl> createState() => PaintControlState();
}

class PaintControlState extends State<PaintControl> {
  bool _showDetail = false;

  _toAI() {
    Services().advertisement.loadAd(
          type: AdvertisementViewType.handle,
          onAd: (handleAd) {
            if (handleAd != null) {
              handleAd.show();
            }
          },
          screenName: AppRoutes.edit
        );
    widget.controller.toAI();
  }

  hideDetail() {
    setState(() {
      _showDetail = false;
    });
  }

  showDetail() {
    setState(() {
      _showDetail = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          if (_showDetail)
            DetailDetectedObject(
              controller: widget.controller,
              hideDetailDetectedObjects: hideDetail,
            ),
          if (!_showDetail) ...[
            Container(
              padding: const EdgeInsets.all(AppDimensions.paddingSizeDefault),
              child: ValueListenableBuilder(
                valueListenable: widget.controller,
                builder: (context, _, __) => widget.controller.isAI
                    ? CountDetectedObject(
                        controller: widget.controller,
                        showDetailDetectedObject: showDetail,
                      )
                    : StrokeWidthSlider(
                        controller: widget.controller,
                      ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppDimensions.paddingSizeDefault),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: _toAI,
                    child: ValueListenableBuilder(
                      valueListenable: widget.controller,
                      builder: (_, __, ___) => Column(
                        children: [
                          Image.asset(
                            AppImages.icFaceIdNormalNormal3x,
                            width: 30,
                            color: widget.controller.isAI
                                ? Theme.of(context).primaryColor
                                : Theme.of(context).disabledColor,
                          ),
                          const SizedBox(
                              height: AppDimensions.paddingSizeDefault),
                          Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  S.of(context).auto,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                        color: widget.controller.isAI
                                            ? Theme.of(context).primaryColor
                                            : Theme.of(context).disabledColor,
                                      ),
                                ),
                                const SizedBox(
                                    width: AppDimensions.paddingSizeExtraSmall),
                                Image.asset(
                                  AppImages.icAINormal3x,
                                  width: 15,
                                )
                              ])
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: widget.controller.toDraw,
                    child: ValueListenableBuilder(
                        valueListenable: widget.controller,
                        builder: (_, __, ___) => Column(
                              children: [
                                Image.asset(
                                  AppImages.icBrushNormalNormal3x,
                                  width: 30,
                                  color: widget.controller.isDraw
                                      ? Theme.of(context).primaryColor
                                      : Theme.of(context).disabledColor,
                                ),
                                const SizedBox(
                                    height: AppDimensions.paddingSizeDefault),
                                Text(
                                  S.of(context).brush,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                        color: widget.controller.isDraw
                                            ? Theme.of(context).primaryColor
                                            : Theme.of(context).disabledColor,
                                      ),
                                )
                              ],
                            )),
                  )
                ],
              ),
            )
          ]
        ],
      ),
    );
  }
}
