import 'package:flutter/material.dart';
import '../Tool/GlobalTool.dart';

class SelectionBar extends StatefulWidget {
  SelectionBar(
    {this.content = "选择"}
  );
  
  final String content;  

  _SelectionBarState _theState = _SelectionBarState("选择产线");

  void setContent(String c) {
    _theState.setContent(c);
  }

  void setSelectionBlock(Function () b) {
    _theState.selectionBlock = b;
  }

  @override
  State<StatefulWidget> createState() {
    if (_theState == null) {
      _theState = _SelectionBarState(this.content);
    }
    return _theState;
  }
}

class _SelectionBarState extends State<SelectionBar> {
  _SelectionBarState(
    this.content
  );

  String content = "";
  void Function () selectionBlock;

  void setContent(String c) {    
    setState(() {
      this.content = c;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (this.selectionBlock != null) {
          this.selectionBlock();
        }
      },
      child: Container(
      color: Colors.white,
      height: 45,
      child: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              height: 20,
              margin: EdgeInsets.symmetric(
                  horizontal: 18, vertical: (45 - 32) / 2.0),
              // color: randomColor(),
              decoration: BoxDecoration(
                color: hexColor("f1f1f1"),
                // border: Border.all(width: 1, color: hexColor("f1f1f1")),
                borderRadius: BorderRadius.all(Radius.circular(6)),
              ),
              child: Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    // color: Colors.white,
                    width: 20,
                    child: Center(
                      child: Icon(Icons.search,
                          size: 20, color: hexColor("999999")),
                    ),
                  ),
                  SizedBox(width: 5),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(right: 5),
                      // color: randomColor(),
                      width: double.infinity,
                      child: Container(
                        // color: hexColor("ffff00"),                        
                        height: 45,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(isAvailable(this.content) ? this.content : "", style: TextStyle(color: hexColor("333333"), fontSize: 15),),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(height: 1, color: hexColor("F4F3F8")),
        ],
      ),
    ),
    );
  }
}

