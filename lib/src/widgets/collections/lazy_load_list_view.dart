import 'package:flutter/widgets.dart';
import 'package:model_fetch/model_fetch.dart';
import 'package:model_fetch_flutter/model_fetch_flutter.dart';
import 'package:model_interfaces/model_interfaces.dart';

import 'model_list_item.dart';

class LazyLoadListView<T extends WithIdTitle<String>> extends StatelessWidget {
  final Widget leading;
  final LazyLoadBloc<T> loader;
  final ValueSetter<T>? onEditPressed;

  const LazyLoadListView({
    super.key,
    required this.loader,
    this.leading = const SizedBox.shrink(),
    this.onEditPressed,
  });

  @override
  Widget build(BuildContext context) {
    return CollectionBlocBuilder(
      bloc: loader,
      builder: (context, state) {
        return ListView.builder(
          itemCount: state.items.length + 2,
          itemBuilder: (BuildContext context, int index) {
            if (index == 0) return leading;

            final itemIndex = index - 1;
            if (itemIndex < state.items.length) {
              final item = state.items[itemIndex];
              return ModelListItem(
                item,
                onEditPressed:
                    onEditPressed == null ? null : () => onEditPressed!(item),
              );
            }

            return BlocAutoLoadMoreWidget(bloc: loader);
          },
        );
      },
    );
  }
}
