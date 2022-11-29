import 'package:flutter/material.dart';
import 'package:fluttering/widgets/alert.dart';

class NoPermissionPopup extends StatefulWidget {
  const NoPermissionPopup({
    Key? key,
    required this.message,
    required this.manualSetupTitle,
    required this.onManualSetup,
    this.onBackApp,
  }) : super(key: key);

  final String message;
  final String manualSetupTitle;
  final Function(BuildContext) onManualSetup;
  final Function(BuildContext)? onBackApp;

  @override
  State<NoPermissionPopup> createState() => _NoPermissionPopupState();
}

class _NoPermissionPopupState extends State<NoPermissionPopup> with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      if (widget.onBackApp != null) widget.onBackApp!(context);
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    return AwesomeAlert(
      buttons: [
        AwesomeAlertButton(
          name: "Cancel",
          action: Navigator.of(context).pop,
          color: Theme.of(context).primaryColor,
        ),
        AwesomeAlertButton(
          name: widget.manualSetupTitle,
          action: widget.onManualSetup,
          color: Theme.of(context).primaryColor,
        ),
      ],
      title: 'No permission',
      content: const Text('Make sure you are connected internet to Wifi or your cellcular network'),
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
