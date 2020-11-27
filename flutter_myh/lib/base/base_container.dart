import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'custom_app_bar.dart';
import 'base_widget.dart';
import 'base_scroll_behavior.dart';

class BaseContainer<T extends ChangeNotifier> extends StatelessWidget {
  final String title;
  final Color titleColor;
  final Widget titleView;
  final Widget leading;
  final Widget tailing;
  final bool showNav;
  final Color backgroundColor;
  final Color navColor;
  final Widget body;
  final T model;
  final VoidCallback callback;
  final SystemUiOverlayStyle overlayStyle;

  BaseContainer({
    this.title,
    this.titleColor,
    this.titleView,
    this.leading,
    this.tailing,
    this.showNav = true,
    this.backgroundColor = Colors.white,
    this.navColor,
    this.overlayStyle,
    @required this.body,
    @required this.model,
    this.callback,
  });
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: overlayStyle ?? SystemUiOverlayStyle.light,
      child: Scaffold(
        appBar: CustomAppBar(
          leading: leading,
          tailing: tailing,
          callBack: callback,
          navColor: navColor,
          title: titleView != null
              ? titleView
              : Text(
                  title ?? '',
                  style: TextStyle(
                    color: titleColor ?? Colors.white,
                    fontSize: 16,
                  ),
                ),
        ),
        body: ScrollConfiguration(
          behavior: BaseScrollBehavior(),
          child: BaseWidget<T>(
            child: body,
            model: model,
          ),
        ),
      ),
    );
  }
}

class BaseNormalContainer extends StatelessWidget {
  final String title;
  final Color titleColor;
  final Widget titleView;
  final Widget leading;
  final Widget tailing;
  final bool showNav;
  final Color backgroundColor;
  final Color navColor;
  final Widget body;
  final VoidCallback callback;
  final SystemUiOverlayStyle overlayStyle;

  BaseNormalContainer({
    this.title,
    this.titleColor,
    this.titleView,
    this.leading,
    this.tailing,
    this.showNav = true,
    this.backgroundColor = Colors.white,
    this.navColor,
    this.overlayStyle,
    @required this.body,
    this.callback,
  });
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: overlayStyle ?? SystemUiOverlayStyle.light,
      child: Scaffold(
        appBar: CustomAppBar(
          leading: leading,
          tailing: tailing,
          callBack: callback,
          navColor: navColor,
          title: titleView != null
              ? titleView
              : Text(
                  title ?? '',
                  style: TextStyle(
                    color: titleColor ?? Colors.white,
                    fontSize: 16,
                  ),
                ),
        ),
        body: ScrollConfiguration(
          behavior: BaseScrollBehavior(),
          child: body,
        ),
      ),
    );
  }
}