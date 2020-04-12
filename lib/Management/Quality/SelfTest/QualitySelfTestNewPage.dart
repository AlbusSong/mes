import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:mes/Others/Tool/GlobalTool.dart';
import 'package:mes/Others/Const/Const.dart';
import '../../../Others/View/SelectionBar.dart';

class QualitySelfTestNewPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _QualitySelfTestNewPageState();
  }  
}

class _QualitySelfTestNewPageState extends State<QualitySelfTestNewPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final SelectionBar _sBar = SelectionBar();


  List arrOfData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: hexColor("f2f2f7"),
      appBar: AppBar(
        title: Text("自检工单"),
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
            child: Text("解锁"),
            onPressed: () {
              // _btnConfirmClicked();
            },
          ),
        ),
      ],
    );
  }

  Widget _buildListView() {
    return ListView.builder(
        // itemCount: listLength(this.arrOfData),
        itemCount: 10,
        itemBuilder: (context, index) {
          return _buildListItem(index);
        });
  }

  Widget _buildListItem(int index) {
    // GroupCheckDetailItemModel itemData = this.arrOfData[index];
    return _buildUncheckedListItem(index);
  }

  Widget _buildUncheckedListItem(int index) {
    return Container(
      color: Colors.white,
      // height: 250,
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(10, 15 + 3.0, 10, 3),
            // color: randomColor(),
            child: Text(
              "活塞线：MECWC201923232",
              style: TextStyle(color: hexColor("333333"), fontSize: 17),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            color: hexColor("f1f1f7"),
            height: 1,
          ),
          Container(
            margin: EdgeInsets.fromLTRB(10, 10 + 3.0, 10, 3),
            // color: randomColor(),
            child: Text(
              "工序：精磨外圆",
              style: TextStyle(color: hexColor("999999"), fontSize: 15),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(10, 3.0, 10, 3),
            // color: randomColor(),
            child: Text(
              "项目：1",
              style: TextStyle(color: hexColor("999999"), fontSize: 15),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
            // color: randomColor(),
            child: Text(
              "工具：1",
              style: TextStyle(color: hexColor("999999"), fontSize: 15),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
            // color: randomColor(),
            child: Text(
              "工单类型：定期自检",
              style: TextStyle(color: hexColor("999999"), fontSize: 15),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
            // color: randomColor(),
            child: Text(
              "机型：12230292",
              style: TextStyle(color: hexColor("999999"), fontSize: 15),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
            // color: randomColor(),
            child: Text(
              "基准：1",
              style: TextStyle(color: hexColor("999999"), fontSize: 15),
            ),
          ),
          Row(
            children: <Widget>[
              Spacer(),
              _buildCorrespondingWidget(index),
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            height: 1,
            color: hexColor("dddddd"),
          ),
        ],
      ),
    );
  }
  
  // Widget _buildCheckedOrAbnormalListItem(dynamic itemData) {
  //   return Container(
  //     color: Colors.white,
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //       children: <Widget>[
  //         Expanded(
  //           child: Container(
  //             color: Colors.white,
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: <Widget>[
  //                 Container(
  //                   margin: EdgeInsets.fromLTRB(10, 10, 0, 5),
  //                   color: Colors.white,
  //                   child: Text(
  //                     "点检项目：{itemData.Project}",
  //                     style: TextStyle(
  //                         color: hexColor("999999"),
  //                         fontSize: 15,
  //                         fontWeight: FontWeight.normal),
  //                   ),
  //                 ),
  //                 Container(
  //                   color: Colors.white,
  //                   margin: EdgeInsets.fromLTRB(10, 5, 0, 5),
  //                   child: Text("判断类型：：{itemData.JudgeType}",
  //                       style:
  //                       TextStyle(color: hexColor("999999"), fontSize: 15)),
  //                 ),

  //                 Container(
  //                   color: Colors.white,
  //                   margin: EdgeInsets.fromLTRB(10, 5, 0, 5),
  //                   child: Text("方法工具：{itemData.MethodTool}",
  //                       style:
  //                       TextStyle(color: hexColor("999999"), fontSize: 15)),
  //                 ),
  //                 Container(
  //                   color: Colors.white,
  //                   margin: EdgeInsets.fromLTRB(10, 5, 0, 10),
  //                   child: Row(
  //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                     children: <Widget>[
  //                       Text("结果：s",
  //                           style: TextStyle(
  //                               color: hexColor("999999"), fontSize: 15)),
  //                       Offstage(
  //                         // offstage: (this.groupCheckType == GroupCheckType.Checked),
  //                         offstage: false,
  //                         child: Text("处理进度：d",
  //                             style: TextStyle(
  //                                 color: hexColor("999999"), fontSize: 15)),
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //                 Container(
  //                   color: hexColor("dddddd"),
  //                   height: 1,
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //         SizedBox(width: 5),
  //         Container(
  //           margin: EdgeInsets.only(right: 8),
  //           color: Colors.white,
  //           child: Icon(
  //             Icons.arrow_forward_ios,
  //             color: hexColor("dddddd"),
  //             size: 20,
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget _buildCorrespondingWidget(int index) {
    // bool isTextFeild = (isAvailable(itemData.JudgeType) && (itemData.JudgeType == "数值判断"));
    bool isTextFeild = (index % 3 > 0);
    if (isTextFeild) {
      return Container(
        margin: EdgeInsets.fromLTRB(10, 5, 10, 3),
        color: hexColor("f1f1f1"),
        width: 100,
        height: 30,
        child: TextField(
          style: TextStyle(fontSize: 18, color: hexColor(MAIN_COLOR_BLACK)),
          textAlignVertical: TextAlignVertical.center,
          controller: TextEditingController(text: "实际值"),
          decoration: InputDecoration(
              hintText: "请输入数值",
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(bottom: 9)
          ),
          onChanged: (text) {
            print("text: $text");
            // itemData.Actual = text;
          },
        ),
      );
    } else {
      return Container(
        margin: EdgeInsets.fromLTRB(10, 5, 0, 3),
        // color: randomColor(),
        width: 150,
        height: 30,
        child: Row(
          children: <Widget>[
            Expanded(
              child: CupertinoSegmentedControl(
                children: {
                  0: Text("OK"),
                  1: Text("NG"),
                },
                // groupValue: (isAvailable(itemData.Actual) ? (int.parse(itemData.Actual) == 1 ? 0 : 1) : 0),
                groupValue: 0,
                onValueChanged: (value) {
                  print("onValueChanged: $value");
                  setState(() {
                    // itemData.Actual = (value == 0 ? "1" : "0");
                  });
                },
              ),
            ),
          ],
        ),
      );
    }
  }
}