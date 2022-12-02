import 'package:flutter/material.dart';
import 'package:snapedit/common/configuration.dart';
import 'package:snapedit/common/constants.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({Key? key}) : super(key: key);

  void _pro(BuildContext context) => Navigator.pushNamed(context, "");
  void _setting(BuildContext context) => Navigator.pushNamed(context, "");

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppDimensions.instance.padding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            Configuration.instance.appConfig.appName,
            style: Theme.of(context).textTheme.headline6!.copyWith(fontWeight: FontWeight.bold),
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () => _pro(context),
                child: Container(
                  padding: EdgeInsets.all(AppDimensions.instance.paddingX(0.2)),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.all(Radius.circular(AppDimensions.instance.radiusX(2))),
                  ),
                  child: Row(
                    children: [
                      Image.asset(AppAssets.instance.icPro, width: AppDimensions.instance.iconX(1.2)),
                      SizedBox(width: AppDimensions.instance.paddingX(0.2)),
                      Text(
                        "PRO",
                        style: Theme.of(context).textTheme.headline6!.copyWith(color: Colors.white, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: AppDimensions.instance.padding),
              GestureDetector(
                onTap: () => _setting(context),
                child: Image.asset(AppAssets.instance.icMenu, width: AppDimensions.instance.iconX(2)),
              )
            ],
          ),
        ],
      ),
    );
  }
}
