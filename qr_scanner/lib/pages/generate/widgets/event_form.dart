import 'package:flutter/material.dart';
import 'package:qr_scanner/common/constants.dart';
import 'package:qr_scanner/models/qr_forms/qr_event_form.dart';
import 'package:qr_scanner/models/qr_type.dart';
import 'package:qr_scanner/pages/generate/widgets/base_form.dart';
import 'package:qr_scanner/pages/generate/widgets/base_form_state.dart';
import 'package:qr_scanner/pages/generate/widgets/pefix_icon.dart';
import 'package:qr_scanner/widgets/app_use/input.dart';

enum _EventField {
  title,
  location,
  start,
  end,
}

class EventForm extends StatefulWidget {
  const EventForm({super.key});

  @override
  State<EventForm> createState() => _EventFormState();
}

class _EventFormState extends BaseFormState<EventForm, QREventForm> {
  @override
  void initState() {
    form = QREventForm(start: DateTime.now(), end: DateTime.now());
    super.initState();
  }

  void _onChanged(_EventField field, dynamic _) {
    switch (field) {
      case _EventField.title:
        form.title = _;
        break;
      case _EventField.location:
        form.location = _;
        break;
      case _EventField.start:
        form.start = _;
        break;
      case _EventField.end:
        form.end = _;
        break;
      default:
        break;
    }
    checkDisabled();
  }

  @override
  Widget build(BuildContext context) {
    return BaseForm(
      onData: onData,
      qrType: QRType.event,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Input(
            prefixIcon: PrefixIcon(icon: AppAssets.instance.gText),
            hintText: "Event Title",
            onChanged: (_) => _onChanged(_EventField.title, _),
          ),
          SizedBox(height: AppDimensions.instance.padding),
          Input(
            prefixIcon: PrefixIcon(icon: AppAssets.instance.gMaps),
            hintText: "Event Location",
            onChanged: (_) => _onChanged(_EventField.location, _),
          ),
          SizedBox(height: AppDimensions.instance.padding),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Input(
                  prefixIcon: PrefixIcon(icon: AppAssets.instance.gText),
                  hintText: "Start time",
                  onChanged: (_) => _onChanged(_EventField.start, _),
                ),
              ),
              SizedBox(width: AppDimensions.instance.padding),
              Expanded(
                child: Input(
                  prefixIcon: PrefixIcon(icon: AppAssets.instance.gText),
                  hintText: "End time",
                  onChanged: (_) => _onChanged(_EventField.end, _),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
