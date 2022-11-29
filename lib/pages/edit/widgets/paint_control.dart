import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:fluttering_ads/fluttering_ads.dart';
import 'package:snapretouch/common/constants.dart';
import 'package:snapretouch/generated/l10n.dart';
import 'package:snapretouch/pages/edit/widgets/count_detected_object.dart';
import 'package:snapretouch/pages/edit/widgets/detail_detected_object.dart';
import 'package:snapretouch/pages/edit/widgets/stroke_width_slider.dart';
import 'package:snapretouch/providers/edit_provider/edit_provider.dart';
import 'package:snapretouch/widgets/ai_icon.dart';

class PaintControl extends StatefulWidget {
  const PaintControl({
    Key? key,
  }) : super(key: key);

  @override
  State<PaintControl> createState() => PaintControlState();
}

class PaintControlState extends ProviderState<PaintControl, EditProvider> {
  bool _showDetail = false;

  _toAI() {
    ManagerProvider.of<AwesomeAdvertisement>().showAd();
    provider.toAI(context);
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
              hideDetailDetectedObjects: hideDetail,
            ),
          if (!_showDetail) ...[
            Container(
              padding: EdgeInsets.all(AppDimensions.instance.paddingSizeDefault),
              child: PropConsumer<EditProvider, bool>(
                select: (p) => p.isAI,
                builder: (_, __, p, ___) => p.isAI
                    ? CountDetectedObject(
                        showDetailDetectedObject: showDetail,
                      )
                    : const StrokeWidthSlider(),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(AppDimensions.instance.paddingSizeDefault),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: _toAI,
                    child: PropConsumer<EditProvider, bool>(
                      select: (p) => p.isAI,
                      builder: (_, __, p, ___) => Column(
                        children: [
                          Image.asset(
                            AppImages.instance.icFaceIdNormalNormal3x,
                            width: 30,
                            color: p.isAI ? Theme.of(context).primaryColor : Theme.of(context).disabledColor,
                          ),
                          SizedBox(height: AppDimensions.instance.paddingSizeDefault),
                          Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                            Text(
                              S.of(context).auto,
                              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                    color: p.isAI ? Theme.of(context).primaryColor : Theme.of(context).disabledColor,
                                  ),
                            ),
                            SizedBox(width: AppDimensions.instance.paddingSizeExtraSmall),
                            const AIIcon()
                          ])
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: provider.toDraw,
                    child: PropConsumer<EditProvider, bool>(
                        select: (p) => p.isDraw,
                        builder: (_, __, p, ___) => Column(
                              children: [
                                Image.asset(
                                  AppImages.instance.icBrushNormalNormal3x,
                                  width: 30,
                                  color: p.isDraw ? Theme.of(context).primaryColor : Theme.of(context).disabledColor,
                                ),
                                SizedBox(height: AppDimensions.instance.paddingSizeDefault),
                                Text(
                                  S.of(context).brush,
                                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                        color: p.isDraw ? Theme.of(context).primaryColor : Theme.of(context).disabledColor,
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
