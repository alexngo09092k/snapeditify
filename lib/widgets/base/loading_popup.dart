import 'package:flutter/material.dart';
import 'package:snapeditify/common/constants.dart';
import 'package:snapeditify/utils/widget.dart';
import 'package:snapeditify/widgets/base/app_card.dart';
import 'package:snapeditify/widgets/base/jumping_dots.dart';

class LoadingPopup extends StatefulWidget {
  static final LoadingPopup _instance = LoadingPopup.internal();

  LoadingPopup.internal({super.key}) {
    _message = ValueNotifier("");
  }

  late final ValueNotifier<String> _message;

  static Future<T?> show<T>([String? message]) {
    if(message != null) setMessage(message);
    return WidgetUtils.instance.showDialog<T>(
      barrierDismissible: false,
      useSafeArea: false,
      builder: (BuildContext context) => _instance,
    );
  }

  static void hide() {
    try {
      WidgetUtils.instance.dismiss();
    } catch (_) {
      // Safe no-op if dialog is already dismissed / navigator locked
    }
  }

  static void setMessage(String newMessage) {
    if (_instance._message.value != newMessage) {
      _instance._message.value = newMessage;
    }
  }

  static void dispose() {
    _instance._message.dispose();
  }

  @override
  State<LoadingPopup> createState() => _LoadingPopupState();
}

class _LoadingPopupState extends State<LoadingPopup> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AppCard(
          constraints: const BoxConstraints(minHeight: 100, minWidth: 100),
          padding: EdgeInsets.all(AppDimensions.instance.padding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children:[JumpingDots(color: Theme.of(context).colorScheme.primary)],
              ),
              ValueListenableBuilder(
                valueListenable: widget._message,
                builder: (_, message, ___) => message.isNotEmpty? Column(
                  children: [
                    SizedBox(height: AppDimensions.instance.padding),
                    Text(
                      message,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                    )
                  ],
                ): const SizedBox(),
              )
            ],
          ),
        )
      ],
    );
  }
}
