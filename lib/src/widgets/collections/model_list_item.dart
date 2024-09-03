import 'package:flutter/material.dart';
import 'package:model_interfaces/model_interfaces.dart';

import '../../util/iterable.dart';
import '../layout/padding.dart';
import '../layout/spacing.dart';

class ModelListItem<T extends WithIdTitle<String>> extends StatelessWidget {
  final T model;
  final VoidCallback? onEditPressed;
  final bool pad;

  const ModelListItem(
    this.model, {
    super.key,
    this.onEditPressed,
    this.pad = false,
  });

  @override
  Widget build(BuildContext context) {
    Widget result = Row(
      children: [
        Expanded(child: Text(model.title)),
        if (onEditPressed != null)
        IconButton(onPressed: onEditPressed, icon: const Icon(Icons.edit)),
      ].intersperse(const QuickSpacing()).toList(growable: false),
    );

    if (pad) {
      result = QuickPadding(child: result);
    }

    return result;
  }
}
