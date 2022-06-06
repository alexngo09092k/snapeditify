import 'package:flutter/material.dart';
import 'package:snapretouch/common/constants.dart';
import 'package:snapretouch/common/logs.dart';
import 'package:snapretouch/generated/l10n.dart';
import 'package:snapretouch/modules/advertisement/app_lifecycle/app_lifecycle_handler.dart';
import 'package:snapretouch/modules/advertisement/app_lifecycle/app_lifecycle_reactor.dart';
import 'package:snapretouch/widgets/custom_dialog.dart';

class NoPermissonPopup extends StatefulWidget {
  const NoPermissonPopup({
    Key? key,
    required this.message,
    required this.manualSetupTitle,
    required this.onManualSetup,
    this.onBackApp,
  }) : super(key: key);

  final String message;
  final String manualSetupTitle;
  final Function(BuildContext) onManualSetup;
  final Function()? onBackApp;

  @override
  State<NoPermissonPopup> createState() => _NoPermissonPopupState();
}

class _NoPermissonPopupState extends State<NoPermissonPopup>
    implements AppLifeCycleHandler {
  late final AppLifecycleReactor _appLifecycleReactor;

  @override
  void initState() {
    _appLifecycleReactor = AppLifecycleReactor(handler: this);
    _appLifecycleReactor.listenToAppStateChanges();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      height: 140,
      message: Text(
        widget.message,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.bodyText1,
      ),
      buttons: [
        CustomDialogButton(
          title: S.of(context).cancel,
          action: Navigator.of(context).pop,
          color: Theme.of(context).highlightColor,
          titleColor: Theme.of(context).textTheme.bodyText1!.color,
        ),
        CustomDialogButton(
          title: widget.manualSetupTitle,
          action: () => widget.onManualSetup(context),
          gradient: AppColors.gradient,
        ),
      ],
    );
  }

  @override
  void onBackground() {
    printLog('NoPermissonPopup => background');
  }

  @override
  void onForeground() {
    printLog('NoPermissonPopup => foreground');
    if (widget.onBackApp != null) {
      widget.onBackApp!();
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
