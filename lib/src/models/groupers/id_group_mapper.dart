import 'package:model_interfaces/model_interfaces.dart';

import 'model_grouper.dart';

/// A group mapper for [ModelGrouper] that uses the `id` field of each group.
mixin IdGroupMapper<T extends WithIdTitle<String>,
    G extends WithIdTitle<String>> on ModelGrouper<T, String, G> {
  @override
  Map<String, G> mapGroupsByIds(Iterable<G> groups) {
    return {
      for (final group in groups) group.id: group,
    };
  }
}
