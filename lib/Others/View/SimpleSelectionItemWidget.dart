import 'package:flutter/material.dart';
import 'package:mes/Others/Tool/GlobalTool.dart';

class SimpleSelectionItemWidget extends StatefulWidget {
  SimpleSelectionItemWidget(
    {this.height = 45,
    this.content = "-",
    this.selectionBlock,}
  );

  final double height;

  String content;
  void Function() selectionBlock;

  void setContent(String c) {
    this.content = c;
    _theState.setContent(c);
  }

  _SimpleSelectionItemWidgetState _theState;

  @override
  State<StatefulWidget> createState() {
    _theState = _SimpleSelectionItemWidgetState(this.height, this.content, this.selectionBlock);
    return _theState;
  }  
}

class _SimpleSelectionItemWidgetState extends State<SimpleSelectionItemWidget> {
  _SimpleSelectionItemWidgetState(
    this.height,
    this.content,
    this.selectionBlock,
  );

  final double height;

  String content;
  void Function() selectionBlock;

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
        height: this.height,
        decoration: BoxDecoration(
                color: Colors.white,
                border: new Border.all(
                    width: 1,
                    color: hexColor("999999")),
                borderRadius: new BorderRadius.all(Radius.circular(4)),
              ),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
          this.content,
          style: TextStyle(fontSize: 13, color: hexColor("999999")),
        ),
            ],
          ),
        ),
      ),
    );
  }
}
