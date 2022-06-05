import 'package:flutter/material.dart';
import 'package:snapretouch/common/constants.dart';

class DetectedObjectTab extends StatefulWidget {
  DetectedObjectTab({Key? key, this.width = 150, this.onChangedTab, required this.controller})
      : super(key: key);
  final double width;
  PageController controller;
  Function(int)? onChangedTab;

  @override
  State<DetectedObjectTab> createState() => _DetectedObjectTabState();
}

class _DetectedObjectTabState extends State<DetectedObjectTab>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _x;
  int _indexTab = 0;

  @override
  void initState() {
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));
    _x = Tween<double>(begin: 0, end: widget.width / 2).animate(_controller);

    widget.controller.addListener(() {
      if (widget.controller.page == 1) {
        _controller.forward();
        setState(() {
          _indexTab = 1;
        });
      }
      if (widget.controller.page == 0) {
        _controller.reverse();
        setState(() {
          _indexTab = 0;
        });
      }
    });

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.forward) {
        _indexTab = 1;
      }
      if (status == AnimationStatus.reverse) {
        _indexTab = 0;
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          return Container(
            height: 40,
            width: widget.width,
            decoration: BoxDecoration(
                color: Theme.of(context).highlightColor,
                borderRadius: const BorderRadius.all(Radius.circular(20))),
            child: Stack(
              children: [
                Transform.translate(
                  offset: Offset(_x.value, 0),
                  child: Container(
                    height: 40,
                    width: widget.width / 2,
                    decoration:  BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      gradient: AppColors.gradient,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        _controller.reverse();
                        if (widget.onChangedTab != null) {
                          widget.onChangedTab!(0);
                        }
                      },
                      child: SizedBox(
                        height: 40,
                        width: widget.width / 2,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'People',
                              style: TextStyle(
                                color: _indexTab == 0
                                    ? AppColors.kWhite
                                    : Colors.black,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        _controller.forward();
                        if (widget.onChangedTab != null) {
                          widget.onChangedTab!(1);
                        }
                      },
                      child: SizedBox(
                        height: 40,
                        width: widget.width / 2,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Others',
                              style: TextStyle(
                                color: _indexTab == 1
                                    ? AppColors.kWhite
                                    : Colors.black,
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          );
        });
  }
}
