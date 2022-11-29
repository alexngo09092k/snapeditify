import 'package:fluttering/fluttering.dart';
import 'package:flutter/material.dart';

class NoInternetPoup extends StatelessWidget {
  const NoInternetPoup({super.key, this.retry, this.onCancel});
  final Function(BuildContext context)? retry;
  final Function(BuildContext context)? onCancel;

  @override
  Widget build(BuildContext context) {
    return AwesomeAlert(
      buttons: [
        AwesomeAlertButton(
          name: "Cancel",
          action: (_) {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
            if (onCancel != null) onCancel!(context);
          },
          color: Theme.of(context).primaryColor,
        ),
        if (retry != null)
          AwesomeAlertButton(
            name: "Retry",
            action: (_) {
              if (Navigator.canPop(context)) {
                Navigator.pop(context);
              }
              retry!(context);
            },
            color: Theme.of(context).primaryColor,
          ),
      ],
      title: 'No internet connection',
      content: const Text('Make sure you are connected internet to Wifi or your cellcular network'),
    );
  }
}
