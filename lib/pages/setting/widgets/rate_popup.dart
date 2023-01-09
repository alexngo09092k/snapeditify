import 'package:flutter/material.dart';
import 'package:phosart/common/constants.dart';
import 'package:phosart/widgets/lottie_viewer.dart';

class RatePopup extends StatelessWidget {
  const RatePopup({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: AppDimensions.instance.popup,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(AppDimensions.instance.radius),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: AppDimensions.instance.padding),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppDimensions.instance.padding),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Are you happy with\nSnapEdit?',
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(fontWeight: FontWeight.bold),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Image.asset(
                        AppAssets.instance.icClose,
                        width: AppDimensions.instance.icon,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: AppDimensions.instance.padding),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppDimensions.instance.padding),
                child: Text(
                  'Your feedback of the app and provide a better experience',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
              SizedBox(height: AppDimensions.instance.padding),
              const _Rate(),
            ],
          ),
        ),
      ],
    );
  }
}

class _Rate extends StatefulWidget {
  const _Rate();

  @override
  State<_Rate> createState() => _RateState();
}

class _RateState extends State<_Rate> {
  ValueNotifier<int> rate = ValueNotifier(0);

  _onRate(_) => rate.value = _;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Image.asset(
              AppAssets.instance.icArrowRating,
              height: AppDimensions.instance.icon,
            ),
            SizedBox(width: AppDimensions.instance.paddingX(0.5)),
            Image.asset(
              AppAssets.instance.icBling,
              height: AppDimensions.instance.icon,
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: AppDimensions.instance.padding),
          child: AnimatedBuilder(
            animation: rate,
            builder: (_, __) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _Star(rate: rate.value, value: 1, onRate: _onRate),
                  _Star(rate: rate.value, value: 2, onRate: _onRate),
                  _Star(rate: rate.value, value: 3, onRate: _onRate),
                  _Star(rate: rate.value, value: 4, onRate: _onRate),
                  _Star(rate: rate.value, value: 5, onRate: _onRate),
                ],
              );
            },
          ),
        ),
        SizedBox(height: AppDimensions.instance.padding),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: AppDimensions.instance.padding),
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(AppDimensions.instance.padding),
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.all(
                Radius.circular(AppDimensions.instance.radiusX(2)),
              ),
            ),
            child: Text(
              'Rate',
              style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.white),
            ),
          ),
        ),
        SizedBox(height: AppDimensions.instance.padding),
      ],
    );
  }
}

class _Star extends StatelessWidget {
  const _Star({required this.rate, required this.value, required this.onRate});
  final int rate;
  final int value;
  final Function(int) onRate;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onRate(value),
      child: value == 5 && rate + 1 < value
          ? LottieViewer(
              lottie: AppAssets.instance.animRatingStar,
              width: AppDimensions.instance.iconX(1),
            )
          : Image.asset(
              rate + 1 > value ? AppAssets.instance.icStarHighlight : AppAssets.instance.icStarNormal,
              width: AppDimensions.instance.iconX(1),
            ),
    );
  }
}
