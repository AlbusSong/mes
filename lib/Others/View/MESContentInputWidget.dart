import 'package:flutter/material.dart';
import '../Tool/GlobalTool.dart';
import '../Const/Const.dart';


class MESContentInputWidget extends StatelessWidget {
  MESContentInputWidget({
    this.placeholder,
    this.contentChangedBlock,
  });

//   final String placeholder;
//   void Function (String newContent) contentChangedBlock;

//   _MESContentInputWidgetState _state;

//   void setContent(String c) {
//     _state.setContent(c);
//   }

//   @override
//   State<StatefulWidget> createState() {
//     if (_state == null) {
//       _state = _MESContentInputWidgetState(placeholder: this.placeholder, contentChangedBlock:this.contentChangedBlock);
//     }    
//     return _state;
//   }  
// }

// class _MESContentInputWidgetState extends State<MESContentInputWidget> {
//   _MESContentInputWidgetState({
//     this.placeholder,
//     this.contentChangedBlock,
//   });  

  final String placeholder;
  void Function (String newContent) contentChangedBlock;
  final TextEditingController _txtController = TextEditingController();

  void setContent(String c) {
    _txtController.text = c;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 140,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          border: new Border.all(width: 1, color: hexColor("999999")),
          borderRadius: new BorderRadius.all(Radius.circular(4)),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 0, horizontal: 15),
          child: TextField(
            controller: _txtController,
            enabled: true,
            style: TextStyle(fontSize: 17, color: hexColor(MAIN_COLOR_BLACK)),
            maxLines: 5,
            decoration:
                InputDecoration(hintText: this.placeholder, border: InputBorder.none),
            onChanged: (text) {
              print("contentChanged: $text");
              if (this.contentChangedBlock != null) {
                this.contentChangedBlock(text);
              }
            }
          ),
        ),
      ),
    );
  }
}