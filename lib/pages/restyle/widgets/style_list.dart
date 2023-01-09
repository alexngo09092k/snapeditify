import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:phosart/pages/restyle/widgets/style_item.dart';
import 'package:phosart/providers/restyle/restyle_provider.dart';
import 'package:phosart/services/snap_edit/src/models/response/styles_response.dart';

class StyleList extends StatelessWidget {
  const StyleList({super.key, required this.provider});
  final RestyleProvider provider;

  _onStyle(Style style) {
    provider.restyleImage(style.styleId);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AwesomeAppState.screen.height * 1 / 5,
      child: BasePropConsumer<RestyleProvider, int>(
        listenable: provider,
        select: (_) => _.styles.length,
        builder: (_, __, p, ___) => ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: p.styles.length,
          itemBuilder: (_, index) => StyleItem(
            key: Key('$index'),
            provider: provider,
            style: p.styles[index],
            onStyle: _onStyle,
          ),
        ),
      ),
    );
  }
}
