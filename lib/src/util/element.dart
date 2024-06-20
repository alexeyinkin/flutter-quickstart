import 'package:flutter/widgets.dart';

extension ElementExtension on Element {
  void markNeedsBuildDescendants() {
    void mark(Element el) {
      el.markNeedsBuild();
      el.visitChildren(mark);
    }

    visitChildren(mark);
  }
}
