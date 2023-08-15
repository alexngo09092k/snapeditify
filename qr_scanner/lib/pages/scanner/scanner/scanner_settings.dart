// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_scanner/common/constants.dart';
import 'package:qr_scanner/providers/scanner_provider.dart';
import 'package:qr_scanner/widgets/base/custom_icon.dart';

class ScannerSettings extends ProviderStateless<ScannerProvider> {
  ScannerSettings({super.key, required this.width});

  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Column(
        children: [
          /// ZOOM
          _ZooomSlider(provider.controller.zoomScaleState, provider.onZoom),

          SizedBox(height: AppDimensions.instance.padding),

          /// SETTINGS
          Container(
            decoration: BoxDecoration(
              color: AppColors.instance.black.withOpacity(0.3),
              borderRadius: BorderRadius.all(
                Radius.circular(AppDimensions.instance.radius),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _SettingButton(
                  'Gallery',
                  icon: AppAssets.instance.icGallery,
                  onPressed: provider.onGallery,
                ),
                ValueListenableBuilder(
                  valueListenable: provider.controller.torchState,
                  builder: (_, state, __) => _SettingButton(
                    'Flashlight',
                    icon: AppAssets.instance.icFlashOn,
                    onPressed: provider.onFlashlight,
                    active: state == TorchState.on,
                  ),
                ),
                ValueListenableBuilder(
                  valueListenable: provider.controller.cameraFacingState,
                  builder: (_, state, __) => _SettingButton(
                    'Camera',
                    icon: AppAssets.instance.icFlipCamera,
                    onPressed: provider.onCameraFacing,
                    active: state == CameraFacing.front,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _ZooomSlider extends StatelessWidget {
  const _ZooomSlider(this.zoomState, this.onZoom);

  final Function(double) onZoom;
  final ValueNotifier<double> zoomState;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomIcon(
          AppAssets.instance.icZoomIn,
          color: AppColors.instance.white,
        ),
        ValueListenableBuilder(
          valueListenable: zoomState,
          builder: (_, state, __) => SliderTheme(
            data: SliderThemeData(
              thumbColor: Theme.of(context).colorScheme.primary,
              activeTrackColor: Theme.of(context).colorScheme.primary,
              trackHeight: 2,
              thumbShape: RoundSliderThumbShape(
                enabledThumbRadius: AppDimensions.instance.radiusX(0.5),
              ),
              trackShape: CustomTrackShape(),
            ),
            child: Slider(
              value: state * 100,
              min: 0,
              max: 100,
              divisions: 100,
              onChanged: (_) => onZoom(_ / 100),
            ),
          ),
        ),
        CustomIcon(
          AppAssets.instance.icZoomOut,
          color: AppColors.instance.white,
        ),
      ],
    );
  }
}

class CustomTrackShape extends RoundedRectSliderTrackShape {
  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double trackHeight = sliderTheme.trackHeight!;
    final double trackLeft = offset.dx;
    final double trackTop =
        offset.dy + (parentBox.size.height - trackHeight) / 2;
    final double trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}

class _SettingButton extends StatelessWidget {
  const _SettingButton(
    this.title, {
    required this.icon,
    required this.onPressed,
    this.active = false,
  });
  final String title;
  final dynamic icon;
  final Function() onPressed;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          padding: EdgeInsets.symmetric(
              vertical: AppDimensions.instance.paddingX(0.5)),
          child: Column(
            children: [
              CustomIcon(
                icon,
                color: active
                    ? Theme.of(context).colorScheme.primary
                    : AppColors.instance.white,
              ),
              SizedBox(height: AppDimensions.instance.paddingX(0.5)),
              Text(
                title,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: active
                          ? Theme.of(context).colorScheme.primary
                          : AppColors.instance.white,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
