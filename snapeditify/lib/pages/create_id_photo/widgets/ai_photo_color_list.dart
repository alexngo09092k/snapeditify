import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:fluttering/fluttering.dart';
import 'package:snapeditify/common/constants.dart';
import 'package:snapeditify/providers/create_id_photo/create_id_photo_provider.dart';
import 'package:snapeditify/widgets/base/custom_icon.dart';

class AIPhotoColorList extends StatefulWidget {
  const AIPhotoColorList({super.key});

  @override
  State<AIPhotoColorList> createState() => _AIPhotoColorListState();
}

class _AIPhotoColorListState extends ProviderStateful<AIPhotoColorList, CreateIDPhotoProvider> {
  Future _showColorPopup<T>(BuildContext context) {
    return AwesomeAppState.dialog<T>(
      builder: (_) => Dialog(
        backgroundColor: Theme.of(context).colorScheme.surface,
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(AppDimensions.instance.padding),
            child: ColorPicker(
              pickerColor: provider.state.color,
              paletteType: PaletteType.hueWheel,
              onColorChanged: _onChangeColor,
            ),
          ),
        ),
      ),
    );
  }

  void _onChangeColor(Color color) {
    provider.changeBackgroundColor(color);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () => _showColorPopup(context),
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [AppColors.instance.boxShadow],
            ),
            child: CustomIcon(
              AppAssets.instance.icColor,
              size: AppDimensions.instance.iconX(1.25),
              normal: true,
            ),
          ),
        ),
        SizedBox(width: AppDimensions.instance.padding),
        _ColorItem(
          color: Colors.white,
          onSelect: _onChangeColor,
        ),
        SizedBox(width: AppDimensions.instance.padding),
        _ColorItem(
          color: Colors.blue,
          onSelect: _onChangeColor,
        ),
        SizedBox(width: AppDimensions.instance.padding),
        _ColorItem(
          color: Colors.lightBlue,
          onSelect: _onChangeColor,
        ),
        SizedBox(width: AppDimensions.instance.padding),
        _ColorItem(
          color: Colors.grey,
          onSelect: _onChangeColor,
        ),
      ],
    );
  }
}

class _ColorItem extends StatelessWidget {
  const _ColorItem({required this.color, this.onSelect});

  final Color color;
  final Function(Color color)? onSelect;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSelect != null ? () => onSelect!(color) : null,
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [AppColors.instance.boxShadow],
        ),
        child: CustomIcon(
          Icons.circle,
          size: AppDimensions.instance.iconX(1.5),
          color: color,
        ),
      ),
    );
  }
}
