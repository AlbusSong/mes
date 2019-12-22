import 'package:flutter/material.dart';
import '../Tool/GlobalTool.dart';

class SearchBarWithFunction extends StatelessWidget {
  SearchBarWithFunction(
    {this.hintText = "输入",}
  );

  final String hintText;

  void Function () functionBlock;
  void Function (String newContent) contentChangeBlock;
  void Function (String content) keyboardReturnBlock;

  @override
  Widget build(BuildContext context) {
    return Container(
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
                      child: Container(
                        // color: hexColor("ffff00"),
                        height: 45,
                        child: TextField(
                          style: TextStyle(
                              fontSize: 15, color: hexColor("333333")),
                          // maxLines: 1,
                          decoration: InputDecoration(
                              hintText: this.hintText,
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(top: -17)),
                          onChanged: (text) {
                            print(("newText: $text"));
                            if (contentChangeBlock != null) {
                              contentChangeBlock(text);
                            }
                          },
                          onSubmitted: (text) {
                            print("onSubmitted: $text");
                            if (this.keyboardReturnBlock != null) {
                              keyboardReturnBlock(text);
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    child: Container(
                    width: 45,
                    // color: randomColor(),
                    child: Center(
                      // child: Icon(Icons.scanner, size: 30, color: hexColor("999999"),),
                      child: Image.asset("Others/Images/scan_barcode_icon.png", width: 25, height: 25),
                    ),
                  ),
                  onTap: () {
                    print("functionClicked");
                    _functionBtnClicked();
                  },
                  ),
                ],
              ),
            ),
          ),
          Container(height: 1, color: hexColor("F4F3F8")),
        ],
      ),
    );
  }

  void _functionBtnClicked() {
    if (this.functionBlock != null) {
      this.functionBlock();
    }
  }
}
