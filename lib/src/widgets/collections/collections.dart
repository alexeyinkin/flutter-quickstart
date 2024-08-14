import 'package:flutter/widgets.dart';

typedef CollectionWidgetBuilder<T> = Widget Function(
  BuildContext context,
  T item,
  int index,
);
