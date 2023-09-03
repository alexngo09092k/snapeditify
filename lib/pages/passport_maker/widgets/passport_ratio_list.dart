import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:snapeditify/common/constants.dart';
import 'package:snapeditify/providers/change_background/change_background_provider.dart';

class PassportRatioList extends StatelessWidget {
  const PassportRatioList({super.key});

  @override
  Widget build(BuildContext context) {
    final ratios = {
      "1x1": 1 / 1,
      "3x4": 3 / 4,
      "4x6": 4 / 6,
      "5x10": 5 / 10,
    };
    return SizedBox(
      height: 60,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: ratios.length,
        itemBuilder: (_, index) => Container(
          padding: EdgeInsets.only(left: AppDimensions.instance.padding),
          child: RatioItem(
            key: Key('$index'),
            label: ratios.keys.elementAt(index),
            ratio: ratios.values.elementAt(index),
          ),
        ),
      ),
    );
  }
}

class RatioItem extends StatelessWidget {
  const RatioItem({super.key, required this.label, required this.ratio});
  final String label;
  final double ratio;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppDimensions.instance.paddingX(0.5),
        vertical: AppDimensions.instance.padding,
      ),
      child: PropConsumer<IChangeBackgroundProvider, double>(
        select: (_) => _.state.ratio,
        builder: (_, __, p, c) {
          return GestureDetector(
            onTap: () => p.changeRatio(ratio),
            child: Container(
              padding: EdgeInsets.symmetric(
                vertical: AppDimensions.instance.paddingX(0.5),
                horizontal: AppDimensions.instance.padding,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(AppDimensions.instance.radiusX(2))),
                border: c == ratio
                    ? Border.all(color: Theme.of(context).primaryColor)
                    : null,
                color: c == ratio
                    ? Theme.of(context).primaryColor.withOpacity(0.1)
                    : Theme.of(context).disabledColor.withOpacity(0.1),
              ),
              child: Text(
                label,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
          );
        },
      ),
    );
  }
}
