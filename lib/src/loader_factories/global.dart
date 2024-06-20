import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:model_fetch/model_fetch.dart';
import 'package:model_fetch_firestore/model_fetch_firestore.dart';

import '../enums/collection.dart';
import '../models/global.dart';
import 'firestore.dart';

const _collection = QuickCollection.Global;

final quickGlobalFirestoreLoaderFactory = QuickGlobalFirestoreLoaderFactory();

class QuickGlobalFirestoreLoaderFactory
    extends QuickFirestoreLoaderFactory<QuickGlobal, AbstractFilter> {
  @override
  CollectionReference<Map<String, dynamic>> getCollection() {
    return FirebaseFirestore.instance.collection(_collection.name);
  }

  @override
  QueryBuilder<QuickGlobal> createQueryBuilder(AbstractFilter filter) {
    throw UnimplementedError();
  }

  @override
  QuickGlobal fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    return QuickGlobal.fromMap({'id': snapshot.id, ...?snapshot.data()});
  }
}
