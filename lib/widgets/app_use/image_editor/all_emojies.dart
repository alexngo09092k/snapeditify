import 'package:flutter/material.dart';
import 'package:snapeditify/common/constants.dart';
import 'package:snapeditify/generated/l10n.dart';
import 'data/data.dart';
import 'data/layer.dart';

class Emojies extends StatelessWidget {
  const Emojies({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(AppDimensions.instance.padding),
        height: 400,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(AppDimensions.instance.radius),
            topLeft: Radius.circular(AppDimensions.instance.radius),
          ),
        ),
        child: Column(
          children: [
            Center(
              child: Text(
                S.of(context).selectEmoji.toUpperCase(),
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
              ),
            ),
            SizedBox(height: AppDimensions.instance.paddingX(2)),
            Expanded(
              child: GridView(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                scrollDirection: Axis.vertical,
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  mainAxisSpacing: 0.0,
                  maxCrossAxisExtent: 60.0,
                ),
                children: emojis.map(
                  (String emoji) {
                    return GridTile(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(
                            context,
                            EmojiLayerData(
                              text: emoji,
                              size: AppDimensions.instance.icon,
                            ),
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.zero,
                          child: Text(
                            emoji,
                            style: TextStyle(
                              fontSize: AppDimensions.instance.icon,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ).toList(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
