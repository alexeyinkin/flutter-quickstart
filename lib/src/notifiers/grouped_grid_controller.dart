import 'dart:async';

import 'package:common_macros/common_macros.dart';
import 'package:flutter/foundation.dart';
import 'package:model_interfaces/model_interfaces.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/groupers/model_grouper.dart';

const _collapsedIdsKey = 'collapsedIds';

class GroupedGridController<T extends WithIdTitle<String>>
    extends ChangeNotifier {
  final String name;

  List<T> _items = const [];
  bool _itemsLoaded = false;

  List<WithIdTitle<String>> _groups = const [];
  bool _groupsLoaded = false;

  @Getter()
  Map<WithIdTitle<String>, List<T>> _groupedItems = const {};

  Set<String> _collapsedGroupIds = const {};
  bool _collapsedGroupIdsLoaded = false;

  @Getter()
  ModelGrouper<T, dynamic, WithIdTitle<String>> _grouper;

  GroupedGridController({
    required ModelGrouper<T, dynamic, WithIdTitle<String>> grouper,
    required this.name,
  }) : _grouper = grouper {
    unawaited(_loadExpansionState());
  }

  set items(List<T> value) {
    _items = value;
    _itemsLoaded = true;
    _onChanged();
  }

  set groups(List<WithIdTitle<String>> value) {
    _groups = value;
    _groupsLoaded = true;
    _onChanged();
  }

  void _onChanged() {
    if (!isLoaded) return;
    _group();
    notifyListeners();
  }

  void _group() {
    _groupedItems = _grouper.groupByAll(
      _items,
      groups: _groups,
    );
  }

  bool get isLoaded => _itemsLoaded && _groupsLoaded;

  bool isGroupExpanded(String id) => !_collapsedGroupIds.contains(id);

  Future<void> setGroupExpanded(String id, bool newValue) async {
    if (newValue) {
      await expandGroup(id);
    } else {
      await collapseGroup(id);
    }
  }

  Future<void> expandGroup(String id) async {
    _collapsedGroupIds.remove(id);
    notifyListeners();
    await _saveExpansionState();
  }

  Future<void> collapseGroup(String id) async {
    _collapsedGroupIds.add(id);
    notifyListeners();
    await _saveExpansionState();
  }

  Future<void> _loadExpansionState() async {
    final prefs = await SharedPreferences.getInstance();
    final idsString = prefs.getString(_getCollapsedIdsKey()) ?? '';

    _collapsedGroupIds =
        idsString.split(',').where((s) => s.isNotEmpty).toSet();

    _collapsedGroupIdsLoaded = true;
    notifyListeners();
  }

  Future<void> _saveExpansionState() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_getCollapsedIdsKey(), _collapsedGroupIds.join(','));
  }

  String _getCollapsedIdsKey() => '$_collapsedIdsKey.$name';
}
