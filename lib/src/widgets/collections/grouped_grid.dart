import 'package:flutter/material.dart';
import 'package:model_interfaces/model_interfaces.dart';

import '../../notifiers/grouped_grid_controller.dart';
import '../../theme/extension.dart';
import '../layout/h2.dart';
import '../loading/small_circular_progress_indicator.dart';
import 'collections.dart';
import 'expand_collapse_button.dart';

class GroupedGridWidget<T extends WithIdTitle<String>> extends StatelessWidget {
  final SliverGridDelegate gridDelegate;
  final GroupedGridController<T> controller;
  final CollectionWidgetBuilder<T> itemBuilder;

  const GroupedGridWidget({
    required this.gridDelegate,
    required this.controller,
    required this.itemBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        if (!controller.isLoaded) {
          return const Center(
            child: SmallCircularProgressIndicator(),
          );
        }

        return Column(
          children: [
            for (final group in controller.groupedItems.keys)
              _GroupWidget(
                gridDelegate: gridDelegate,
                controller: controller,
                group: group,
                itemBuilder: itemBuilder,
              ),
          ],
        );
      },
    );
  }
}

class _GroupWidget<T extends WithIdTitle<String>> extends StatelessWidget {
  final SliverGridDelegate gridDelegate;
  final GroupedGridController<T> controller;
  final WithIdTitle<String> group;
  final CollectionWidgetBuilder<T> itemBuilder;

  const _GroupWidget({
    required this.gridDelegate,
    required this.controller,
    required this.group,
    required this.itemBuilder,
  });

  @override
  Widget build(BuildContext context) {
    final ext = Theme.of(context).extension<QuickThemeExtension>()!;
    final isExpanded = controller.isGroupExpanded(group.id);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            ExpandCollapseButton(
              isExpanded: isExpanded,
              setExpanded: (v) => controller.setGroupExpanded(group.id, v),
            ),
            H2Widget(group.title),
            const SizedBox(width: 30),
            Opacity(
              opacity: .5,
              child: Text(
                controller.groupedItems[group]?.length.toString() ?? '',
                style: ext.h2,
              ),
            ),
            const Expanded(
              child: SizedBox.shrink(),
            ),
          ],
        ),
        if (isExpanded)
          CollectionGroupContentWidget(
            gridDelegate: gridDelegate,
            itemBuilder: itemBuilder,
            items: controller.groupedItems[group]!,
          ),
      ],
    );
  }
}

class CollectionGroupContentWidget<T extends WithIdTitle<String>>
    extends StatelessWidget {
  final SliverGridDelegate gridDelegate;
  final CollectionWidgetBuilder<T> itemBuilder;
  final List<T> items;

  const CollectionGroupContentWidget({
    required this.gridDelegate,
    required this.itemBuilder,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: gridDelegate,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, i) {
        final item = items[i];
        return itemBuilder(context, item, i);
      },
      itemCount: items.length,
    );
  }
}
