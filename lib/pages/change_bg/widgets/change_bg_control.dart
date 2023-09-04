import 'package:flutter/material.dart';

class ChangeBGControl extends StatefulWidget {
  const ChangeBGControl({super.key});

  @override
  State<ChangeBGControl> createState() => _ChangeBGControlState();
}

class _ChangeBGControlState extends State<ChangeBGControl>
    with SingleTickerProviderStateMixin {
  late TabController _controller;
  @override
  void initState() {
    _controller = TabController(length: 6, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Column(
        children: [
          TabBar(
              isScrollable: true,
              unselectedLabelColor: Colors.white.withOpacity(0.3),
              indicatorColor: Colors.white,
              controller: _controller,
              tabs: [
                Tab(
                  child: Text('Tab 1'),
                ),
                Tab(
                  child: Text('Investment'),
                ),
                Tab(
                  child: Text('Your Earning'),
                ),
                Tab(
                  child: Text('Current Balance'),
                ),
                Tab(
                  child: Text('Tab 5'),
                ),
                Tab(
                  child: Text('Tab 6'),
                )
              ]),
          Expanded(
            child: TabBarView(controller: _controller, children: [
              Container(
                child: Center(
                  child: Text('Tab 1'),
                ),
              ),
              Container(
                child: Center(
                  child: Text('Tab 2'),
                ),
              ),
              Container(
                child: Center(
                  child: Text('Tab 3'),
                ),
              ),
              Container(
                child: Center(
                  child: Text('Tab 4'),
                ),
              ),
              Container(
                child: Center(
                  child: Text('Tab 5'),
                ),
              ),
              Container(
                child: Center(
                  child: Text('Tab 6'),
                ),
              ),
            ]),
          )
        ],
      ),
    );
  }
}
