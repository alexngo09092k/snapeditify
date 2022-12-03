import 'package:flutter/material.dart';
import 'package:snapedit/common/constants.dart';

class AllPhotos extends StatelessWidget {
  const AllPhotos({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(AppDimensions.instance.padding),
          child: Row(
            children: [
              Text('All photos', style: Theme.of(context).textTheme.bodyText1),
              SizedBox(width: AppDimensions.instance.paddingX(0.2)),
              Container(
                padding: EdgeInsets.all(AppDimensions.instance.paddingX(0.2)),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.all(
                    Radius.circular(AppDimensions.instance.radiusX(0.5)),
                  ),
                ),
                child: Text(
                  "23",
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.white),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
