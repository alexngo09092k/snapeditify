import 'package:flutter/material.dart';
import 'package:snapretouch/common/constants.dart';

enum SnackBarType {
  info,
  error,
  success,
}

void showSnackBar(BuildContext context, {required SnackBarType type, required String message}) {
  switch (type) {
    case SnackBarType.error:
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            message,
            style: Theme.of(context).textTheme.bodyText2,
          ),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: AppColors.kColorRed.withOpacity(0.1), width: 1),
            borderRadius: BorderRadius.circular(24),
          ),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        ),
      );
      break;
    case SnackBarType.success:
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            message,
            style: Theme.of(context).textTheme.bodyText2,
          ),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: AppColors.topicColor.withOpacity(0.1), width: 1),
            borderRadius: BorderRadius.circular(24),
          ),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        ),
      );
      break;
    case SnackBarType.info:
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            message,
            style: Theme.of(context).textTheme.bodyText2,
          ),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: AppColors.topicColor.withOpacity(0.1), width: 1),
            borderRadius: BorderRadius.circular(24),
          ),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        ),
      );
      break;
    default:
  }
}
