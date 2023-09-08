import 'package:colorfilter_generator/colorfilter_generator.dart';
import 'package:colorfilter_generator/presets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as img;
import 'package:screenshot/screenshot.dart';
import 'package:image_editor/image_editor.dart' as image_editor;
import 'package:snapeditify/common/constants.dart';
import 'package:snapeditify/widgets/app_use/base_image_editor.dart';
import 'package:snapeditify/widgets/app_use/image_editor/single_image_editor.dart';
import 'package:snapeditify/widgets/base/app_card.dart';
import 'package:snapeditify/widgets/base/custom_icon.dart';

class ImageFilters extends StatefulWidget {
  final Uint8List image;
  final bool useCache;

  const ImageFilters({
    super.key,
    required this.image,
    this.useCache = true,
  });

  @override
  createState() => _ImageFiltersState();
}

class _ImageFiltersState extends State<ImageFilters> {
  late img.Image decodedImage;
  ColorFilterGenerator selectedFilter = PresetFilters.none;
  Uint8List resizedImage = Uint8List.fromList([]);
  double filterOpacity = 1;
  Uint8List filterAppliedImage = Uint8List.fromList([]);
  ScreenshotController screenshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: Navigator.of(context).pop,
          child: Container(
            padding: EdgeInsets.only(
              right: AppDimensions.instance.padding,
              left: AppDimensions.instance.padding,
            ),
            color: Colors.transparent,
            child: const CustomIcon(Icons.clear),
          ),
        ),
        elevation: 0,
        actions: [
          FeatureButton(
            icon: Icons.check,
            onTap: () async {
              var data = await screenshotController.capture();
              if (mounted) Navigator.pop(context, data);
            },
          ),
          SizedBox(width: AppDimensions.instance.paddingX(0.5)),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            BaseImageEditor(builder: (_, __) {
              return Center(
                child: Screenshot(
                  controller: screenshotController,
                  child: Stack(
                    children: [
                      Image.memory(
                        widget.image,
                        fit: BoxFit.cover,
                      ),
                      FilterAppliedImage(
                        image: widget.image,
                        filter: selectedFilter,
                        fit: BoxFit.cover,
                        opacity: filterOpacity,
                        onProcess: (img) {
                          // print('processing done');
                          filterAppliedImage = img;
                        },
                      ),
                    ],
                  ),
                ),
              );
            }),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 160 + MediaQuery.of(context).padding.bottom,
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          shape: BoxShape.rectangle,
        ),
        child: Column(
          children: [
            SizedBox(height: AppDimensions.instance.padding),
            selectedFilter == PresetFilters.none
                ? const SizedBox()
                : selectedFilter.build(
                    Slider(
                      min: 0,
                      max: 1,
                      divisions: 100,
                      value: filterOpacity,
                      onChanged: (value) {
                        filterOpacity = value;
                        setState(() {});
                      },
                    ),
                  ),
            SizedBox(height: AppDimensions.instance.padding),
            Expanded(
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  for (int i = 0; i < presetFiltersList.length; i++)
                    filterPreviewButton(
                      filter: presetFiltersList[i],
                      name: presetFiltersList[i].name,
                      isStart: i == 0,
                      isEnd: i + 1 == presetFiltersList.length,
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget filterPreviewButton({
    required filter,
    required String name,
    bool isStart = false,
    bool isEnd = false,
  }) {
    return GestureDetector(
      onTap: () {
        selectedFilter = filter;
        setState(() {});
      },
      child: LayoutBuilder(builder: (_, constraints) {
        return AppCard(
          margin: EdgeInsets.symmetric(
            horizontal: AppDimensions.instance.paddingX(0.5),
          ).copyWith(
            bottom: AppDimensions.instance.padding,
            left: isStart ? AppDimensions.instance.padding : null,
            right: isEnd ? AppDimensions.instance.padding : null,
          ),
          width: constraints.maxHeight - AppDimensions.instance.padding,
          child: ClipRRect(
            borderRadius: BorderRadius.all(
              Radius.circular(AppDimensions.instance.radius),
            ),
            child: FilterAppliedImage(
              image: widget.image,
              filter: filter,
              fit: BoxFit.fill,
            ),
          ),
        );
      }),
    );
  }
}

class FilterAppliedImage extends StatelessWidget {
  final Uint8List image;
  final ColorFilterGenerator filter;
  final BoxFit? fit;
  final Function(Uint8List)? onProcess;
  final double opacity;

  FilterAppliedImage({
    super.key,
    required this.image,
    required this.filter,
    this.fit,
    this.onProcess,
    this.opacity = 1,
  }) {
    if (onProcess != null) {
      if (filter.filters.isEmpty) {
        onProcess!(image);
        return;
      }

      final image_editor.ImageEditorOption option =
          image_editor.ImageEditorOption();

      option.addOption(image_editor.ColorOption(matrix: filter.matrix));

      image_editor.ImageEditor.editImage(
        image: image,
        imageEditorOption: option,
      ).then((result) {
        if (result != null) {
          onProcess!(result);
        }
      }).catchError((err, stack) {});
    }
  }

  @override
  Widget build(BuildContext context) {
    if (filter.filters.isEmpty) return Image.memory(image, fit: fit);

    return Opacity(
      opacity: opacity,
      child: filter.build(
        Image.memory(image, fit: fit),
      ),
    );
  }
}
