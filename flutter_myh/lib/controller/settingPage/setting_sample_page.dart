import 'package:flutter/material.dart';

import '../demo/simple_widget_demo.dart';

class SettingSampleDemoPage extends StatefulWidget {
  @override
  _SettingSampleDemoPageState createState() => _SettingSampleDemoPageState();
}

class _SettingSampleDemoPageState extends State<SettingSampleDemoPage>
    with AutomaticKeepAliveClientMixin {
  List<String> _list;
  @override
  void initState() {
    _list = ['ConstrainedBox 运用'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      padding: EdgeInsets.only(
        left: 15,
        right: 15,
        top: 10,
      ),
      child: Center(
        child: ListView.builder(
            itemCount: _list.length,
            itemBuilder: (context, int row) {
              return GestureDetector(
                onTap: () {
                  if (row == 0) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return SampleWidgetDemoPage();
                      }),
                    );
                  }
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          _list[row],
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      color: Color(0xffaaaaaa),
                      height: 0.5,
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
