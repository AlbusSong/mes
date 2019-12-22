import 'package:flutter/material.dart';
import '../Tool/GlobalTool.dart';
import '../Const/Const.dart';

class MESSquareItemWidget extends StatefulWidget {
  MESSquareItemWidget(
    this.index,
    this.title,
    this.badgeValue,
    this.onClick,
  );

  final int index;
  final String title;
  final int badgeValue;

  //点击回调
  final void Function(int) onClick;

  _MESSquareItemWidgetState _itemState;

  void updateItem(int newBadgeValue) {
    _itemState.updateItem(newBadgeValue);
  }

  @override
  State<StatefulWidget> createState() {
    _itemState = _MESSquareItemWidgetState(
        this.index, this.title, this.badgeValue, this.onClick);
    return _itemState;
  }
}

class _MESSquareItemWidgetState extends State<MESSquareItemWidget> {
  _MESSquareItemWidgetState(
    this.index,
    this.title,
    this.badgeValue,
    this.onClick,
  );

  final int index;
  final String title;
  int badgeValue;

  //点击回调
  final void Function(int) onClick;

  void updateItem(int newBadgeValue) {
    this.badgeValue = newBadgeValue;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onClick(index),
      child: Container(
        // color: hexColor(MAIN_COLOR),
        decoration: BoxDecoration(
          color: hexColor(MAIN_COLOR),
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 0),
                  child: Text(
                    title,
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ),
                Container(
                  color: randomColor(),
                  height: 45,
                  width: 50,
                  // child: Image(
                  //   height: 50,
                  //   width: 45,
                  //   image: AssetImage("others/images/Home-CompanyLogo.jpeg"),
                  // ),
                )
              ],
            ),
            Positioned(
              right: 4,
              top: 8,
              child: Opacity(
                opacity: this.badgeValue > 0 ? 1 : 0,
                child: Container(
                height: 15,
                constraints: BoxConstraints(minWidth: 15),
                decoration: BoxDecoration(
                  color: hexColor("eb4d3d"),
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                ),
                child: Center(
                    child:  Text(
                  randomIntWithRange(1, 99).toString(),
                  style: TextStyle(color: Colors.white, fontSize: 9),
                ),
                ),
              ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}