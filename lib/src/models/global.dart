import 'package:model_interfaces/model_interfaces.dart';

import 'versions.dart';

class QuickGlobal implements WithId<String> {
  @override
  String get id => singleId;

  final Versions versions;

  const QuickGlobal({
    required this.versions,
  });

  static const singleId = 'Global';

  factory QuickGlobal.fromMap(Map<String, dynamic> map) {
    return QuickGlobal(
      versions: Versions.fromMap(map['versions']),
    );
  }
}
