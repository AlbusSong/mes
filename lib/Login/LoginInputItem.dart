import 'package:flutter/material.dart';
import 'package:mes/Others/Tool/GlobalTool.dart';
import 'package:mes/Others/Const/Const.dart';

class LoginInputItem extends StatelessWidget {
  LoginInputItem(
    this.initialContent,
    this.placeholder,
    this.isObscureText,
    this.itemMargin,
    this.newTextBlock,
  );

  final String placeholder;
  final EdgeInsets itemMargin;
  final void Function (String newText) newTextBlock;
  final bool isObscureText;
  final String initialContent;

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }  

  Widget _buildBody() {
    return Container(
      margin: this.itemMargin,
      decoration: BoxDecoration(
          color: Colors.white,
          border: new Border.all(width: 1, color: hexColor(MAIN_COLOR)),
          borderRadius: new BorderRadius.all(Radius.circular(4)),
      ),
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            width: 40,
            height: 40,
            color: hexColor(MAIN_COLOR),
            child: Icon(Icons.portrait, size: 25, color: hexColor("ffffff"),),
          ),

          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: 3),
              height: 40,
              color: Colors.white,
              child: TextField(
                controller: TextEditingController(text: (initialContent ?? "")),
                maxLines: 1,
                obscureText: this.isObscureText,
                decoration: InputDecoration(hintText: this.placeholder, contentPadding: EdgeInsets.only(top: -12), border: InputBorder.none),
                onChanged: (text) {
                  print("text: $text");
                  if (newTextBlock != null) {
                    newTextBlock(text);
                  }
                },              
              ),
            ),
          ),
        ],
      ),
    );
  }
}