import 'package:model_interfaces/model_interfaces.dart';

/// Groups items using a strategy defined in subclasses.
abstract class ModelGrouper<
//
    T extends WithIdTitle<String>,
    GI,
    G extends WithIdTitle<String>
//
    > {
  const ModelGrouper();

  /// Groups [items] by each item's primary group.
  ///
  /// Each item gets to a single group only.
  Map<G, List<T>> groupByPrimary(
    Iterable<T> items, {
    required Iterable<G> groups,
  }) {
    final groupsMap = mapGroupsByIds(groups);
    final result = {
      for (final group in groups) group: <T>[],
    };

    for (final item in items) {
      final groupId = getPrimaryGroupId(item);
      final group = groupsMap[groupId];
      if (group == null) continue;
      result[group] ??= [];
      result[group]!.add(item);
    }

    return result;
  }

  /// Groups [items] by every group of each item.
  ///
  /// Each item potentially gets to many groups.
  Map<G, List<T>> groupByAll(
    Iterable<T> items, {
    required Iterable<G> groups,
  }) {
    final groupsMap = mapGroupsByIds(groups);
    final result = <G, List<T>>{};

    for (final item in items) {
      final groupIds = getGroupIds(item);

      for (final groupId in groupIds) {
        final group = groupsMap[groupId]!;
        result[group] ??= [];
        result[group]!.add(item);
      }
    }

    return result;
  }

  /// Returns a map from group IDs to groups.
  Map<GI, G> mapGroupsByIds(Iterable<G> groups);

  /// Returns IDs of all groups of the [item].
  Iterable<GI> getGroupIds(T item);

  /// Returns the ID of the primary group of the [item].
  GI? getPrimaryGroupId(T item) => getGroupIds(item).first;
}
