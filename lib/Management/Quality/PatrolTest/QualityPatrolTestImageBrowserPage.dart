import 'package:flutter/material.dart';
import 'package:mes/Others/Tool/GlobalTool.dart';

import 'package:flutter_drag_scale/flutter_drag_scale.dart';

class QualityPatrolTestImageBrowserPage extends StatelessWidget {
  QualityPatrolTestImageBrowserPage(
    this.imageBase64String,
  );

  final String imageBase64String;

  @override
  Widget build(BuildContext context) {   
    return Scaffold(
      backgroundColor: hexColor("f2f2f7"),
      appBar: AppBar(
        title: Text("查看图片"),
        centerTitle: true,
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Container(
      // color: randomColor(),
      child: Center(
        child: DragScaleContainer(
          doubleTapStillScale: true,
          child: convertToImageByBase64String(this.imageBase64String),
          // child: Image(
          //   image: NetworkImage("https://upload.wikimedia.org/wikipedia/commons/d/d9/191125_Taylor_Swift_at_the_2019_American_Music_Awards.png"),
          // ),
        ),
      ),
    );
  }
}