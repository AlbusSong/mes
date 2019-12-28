import 'package:flutter/material.dart';
import '../../Others/Network/HttpDigger.dart';
import 'package:mes/Others/Tool/HudTool.dart';
import '../../Others/Tool/GlobalTool.dart';
import '../../Others/Const/Const.dart';
import '../../Others/View/SelectionBar.dart';

class ProjectRepairmentListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProjectRepairmentListPageState();
  }
}

class _ProjectRepairmentListPageState extends State<ProjectRepairmentListPage> {
  final List<String> bottomFunctionTitleList = ["一维码", "二维码"];
  final SelectionBar _sBar = SelectionBar();
  String lotNo;

  @override
  void initState() {
    super.initState();

    _sBar.setSelectionBlock(() {
      print("setSelectionBlock");
    });
  }

  void _getDataFromServer() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: hexColor("f2f2f7"),
      appBar: AppBar(
        title: Text("Lot查询"),
        centerTitle: true,
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Column(
      children: <Widget>[
        _sBar,
        Expanded(
          child: Container(
            color: hexColor("f2f2f7"),
            child: _buildListView(),
          ),
        ),
      ],
    );
  }

  Widget _buildListView() {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: <Widget>[
      ],
    );
  }
}
