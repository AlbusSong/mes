import 'package:flutter/material.dart';
import '../../Others/Tool/GlobalTool.dart';
import '../../Others/Const/Const.dart';
import '../../Others/View/SearchBarWithFunction.dart';
import '../../Others/View/MESSelectionItemWidget.dart';

class MoldInPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MoldInPageState();  
  }
}

class _MoldInPageState extends State<MoldInPage> {

  final SearchBarWithFunction _sBar = SearchBarWithFunction(hintText: "模具编码",);

  @override
  void initState() {
    super.initState();

    _sBar.functionBlock = () {
      print("functionBlock");
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: hexColor("f2f2f7"),
      appBar: AppBar(
        title: Text("模具入库"),
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
        Container(
            height: 50,
            width: double.infinity,
            // color: randomColor(),
            child: FlatButton(
              textColor: Colors.white,
              color: hexColor(MAIN_COLOR),
              child: Text("入库"),
              onPressed: () {
                _btnConfirmClicked();
              },
            ),
          ),
      ],
    );
  }

  Widget _buildListView() {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: <Widget>[
        _buildSelectionItem(0),
        _buildSelectionItem(1),
        _buildSelectionItem(2),
        _buildSelectionItem(3),
        _buildSelectionItem(4),
      ],
    );
  }

  Widget _buildSelectionItem(int index) {
    bool enabled = false;
    String title = "";
    String content = "";
    if (index == 0) {
      enabled = false;
      title = "模号";
    } else if (index == 1) {
      enabled = false;
      title = "模具名称";
    } else if (index == 2) {
      enabled = false;
      title = "状态";
    } else if (index == 3) {
      enabled = false;
      title = "锁定状态";
    } else if (index == 4) {
      enabled = true;
      title = "锁定代码";
    }

    void Function () selectionBlock = () {
      _hasSelectedItem(index);
    };

    MESSelectionItemWidget item = MESSelectionItemWidget(enabled: enabled, title: title, selectionBlock: selectionBlock,);
    return item;
  }

  void _hasSelectedItem(int index) {
    print("_hasSelectedItem: $index");
  }

  void _btnConfirmClicked() {

  }
}