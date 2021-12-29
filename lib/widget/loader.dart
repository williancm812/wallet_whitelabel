

import 'package:flutter/material.dart';

isLoading(BuildContext context, {bool canPop = false}) {
  () async {
    showDialog(
      context: context,
      builder: (context) => WillPopScope(
        onWillPop: () async => true,
        // onWillPop: () async => canPop,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(alignment: Alignment.center, children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: Color.fromRGBO(0, 0, 0, 0.3),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Stack(children: <Widget>[
                  Center(
                    child: CircularProgressIndicator(),
                  )
                ]),
              ],
            ),
          ]),
        ),
      ),
    );
  }();
}
