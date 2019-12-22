import 'package:flutter/material.dart';
import '../../Others/Tool/GlobalTool.dart';
import '../../Others/Const/Const.dart';
import '../../Others/View/SearchBarWithFunction.dart';

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

  void _btnConfirmClicked() {

  }
}