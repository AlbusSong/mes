import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../../../Others/Tool/HudTool.dart';
import '../../../Others/Tool/GlobalTool.dart';

import 'ProjectReturnRepairmentLotPage.dart';
import 'ProjectReturnRepairmentNonLotPage.dart';

class ProjectReturnRepairmentPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProjectReturnRepairmentPageState();
  }
}

class _ProjectReturnRepairmentPageState
    extends State<ProjectReturnRepairmentPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  PageView _pageView;
  int selectedPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    _initSomeThings();

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: hexColor("f2f2f7"),
      appBar: AppBar(
        title: Text("返修"),
        centerTitle: true,
      ),
      body: _buildBody(),
    );
  }

  void _initSomeThings() {
    _pageView = PageView(
      controller: new PageController(),
      physics: const NeverScrollableScrollPhysics() ,
      children: <Widget>[
        ProjectReturnRepairmentNonLotPage(_scaffoldKey),
        ProjectReturnRepairmentLotPage(_scaffoldKey),
      ],
      onPageChanged: (currentIndex) {
        print("currentIndex: $currentIndex");
        // _segmentControl.setSelectedIndex(currentIndex);
      },
    );
  }

  Widget _buildBody() {
    return Container(
      color: hexColor("f2f2f7"),
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(horizontal: 0),
            // color: randomColor(),
            width: double.infinity,
            height: 50,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: CupertinoSegmentedControl(
                    children: {
                      0: Text("非Lot"),
                      1: Text("Lot"),
                    },
                    groupValue: selectedPageIndex,
                    onValueChanged: (value) {
                      print("onValueChanged: $value");                      
                      setState(() {
                        selectedPageIndex = value;
                        _pageView.controller.jumpToPage(selectedPageIndex);
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: _pageView,
          ),
        ],
      ),
    );
  }
}
