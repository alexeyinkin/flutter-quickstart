import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:model_fetch/model_fetch.dart';
import 'package:model_fetch_firestore/model_fetch_firestore.dart';

import '../enums/collection.dart';
import '../models/global.dart';

const _collection = QuickCollection.Global;

class QuickGlobalFirestoreLoaderFactory
    extends AbstractFirestoreLoaderFactory<QuickGlobal, AbstractFilter> {
  static final instance = QuickGlobalFirestoreLoaderFactory();

  @override
  QueryBuilder<QuickGlobal, AbstractFilter> createQueryBuilder(
    AbstractFilter filter,
  ) {
    throw UnimplementedError();
  }

  @override
  Future<QuickGlobal> fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) async {
    return QuickGlobal.fromMap({'id': snapshot.id, ...?snapshot.data()});
  }

  @override
  String get defaultCollectionName => _collection.name;
}
