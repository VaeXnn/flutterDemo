import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../base/message_dialog.dart';

GlobalKey<_SettingTextFieldPageState> textPageKey = GlobalKey();

class SettingTextFieldPage extends StatefulWidget {
  SettingTextFieldPage(Key key) : super(key: key);

  @override
  _SettingTextFieldPageState createState() => _SettingTextFieldPageState();
}

class _SettingTextFieldPageState extends State<SettingTextFieldPage>
    with AutomaticKeepAliveClientMixin {
  GlobalKey<_TextFieldDemoViewState> fieldKey = GlobalKey();
  void dissmissKeyboard() {
    fieldKey.currentState.disFoucus();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: TextFieldDemoView(fieldKey),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class TextFieldDemoView extends StatefulWidget {
  final String content;
  TextFieldDemoView(Key key, {this.content}) : super(key: key);
  @override
  _TextFieldDemoViewState createState() => _TextFieldDemoViewState();
}

class _TextFieldDemoViewState extends State<TextFieldDemoView>
    with WidgetsBindingObserver {
  TextEditingController _editingController;
  FocusNode _focusNode;
  RegExp _regExp;
  int _limitLength;

  void disFoucus() {
    _focusNode.unfocus();
  }

  @override
  void initState() {
    _limitLength = 20;
    _focusNode = FocusNode();
    _editingController = TextEditingController.fromValue(TextEditingValue(
      text: widget?.content ?? '',
      selection: TextSelection.fromPosition(TextPosition(
          offset: (widget?.content ?? '').length,
          affinity: TextAffinity.downstream)),
    ));
    _editingController.addListener(() {
      print(_editingController.text);
    });
    _regExp = RegExp(
        "[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]");
    super.initState();
    Future.delayed(Duration(milliseconds: 500), () {
      if (context != null) {
        FocusScope.of(context).requestFocus(_focusNode);
      }
    });
    WidgetsBinding.instance.addObserver(this);
    print('initState');
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print(state.toString());
    super.didChangeAppLifecycleState(state);
  }

  @override
  void didChangeDependencies() {
    print('didChangeDependencies');
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(TextFieldDemoView oldWidget) {
    print('didUpdateWidget');
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _focusNode?.dispose();
    _editingController?.dispose();
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
    print('dispose');
  }

  @override
  Widget build(BuildContext context) {
    print('build');
    return SingleChildScrollView(
      child: Center(
        child: SizedBox(
          width: 300,
          height: 400,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
            child: Container(
              color: Colors.red,
              child: TextField(
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                cursorColor: Colors.white,
                style: TextStyle(
                  color: Colors.white,
                ),
                focusNode: _focusNode,
                controller: _editingController,
                inputFormatters: <TextInputFormatter>[
                  LengthLimitingTextInputFormatter(_limitLength),
                  BlacklistingTextInputFormatter(_regExp),
                ],
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(8.0),
                  border: InputBorder.none,
                  hintText: '请输入文本',
                  hintStyle: TextStyle(
                    color: Colors.white,
                  ),
                ),
                maxLines: 10,
                onChanged: (String value) {
                  print(value);
                  if (_editingController.text.length >= _limitLength) {
                    showMessage(
                      title: '提示',
                      content: '内容不能超过${_limitLength?.toString()}个字',
                      callBackEvent: (MessageCallBackState state) {
                        print(
                            state == MessageCallBackState.MessageCallBackConfirm
                                ? '点击了确定'
                                : '点击了取消');
                      },
                    );
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void reassemble() {
    print('reassemble');
    super.reassemble();
  }

  @override
  void deactivate() {
    print('deactivate');
    super.deactivate();
  }
}
