// GENERATED CODE - DO NOT MODIFY BY HAND
// This code was generated by ObjectBox. To update it run the generator again:
// With a Flutter package, run `flutter pub run build_runner build`.
// With a Dart package, run `dart run build_runner build`.
// See also https://docs.objectbox.io/getting-started#generate-objectbox-code

// ignore_for_file: camel_case_types
// coverage:ignore-file

import 'dart:typed_data';

import 'package:flat_buffers/flat_buffers.dart' as fb;
import 'package:objectbox/internal.dart'; // generated code can access "internal" functionality
import 'package:objectbox/objectbox.dart';
import 'package:objectbox_flutter_libs/objectbox_flutter_libs.dart';

import 'model/book.dart';

export 'package:objectbox/objectbox.dart'; // so that callers only have to import this file

final _entities = <ModelEntity>[
  ModelEntity(
      id: const IdUid(1, 1730194067676730272),
      name: 'Book',
      lastPropertyId: const IdUid(5, 7714666264139268214),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 3707806820285290476),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 7618923579078009658),
            name: 'title',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 1071213168887326632),
            name: 'downloadUrl',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(4, 3019605642124934581),
            name: 'filePath',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(5, 7714666264139268214),
            name: 'thumbnail',
            type: 9,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[])
];

/// Open an ObjectBox store with the model declared in this file.
Future<Store> openStore(
        {String? directory,
        int? maxDBSizeInKB,
        int? fileMode,
        int? maxReaders,
        bool queriesCaseSensitiveDefault = true,
        String? macosApplicationGroup}) async =>
    Store(getObjectBoxModel(),
        directory: directory ?? (await defaultStoreDirectory()).path,
        maxDBSizeInKB: maxDBSizeInKB,
        fileMode: fileMode,
        maxReaders: maxReaders,
        queriesCaseSensitiveDefault: queriesCaseSensitiveDefault,
        macosApplicationGroup: macosApplicationGroup);

/// ObjectBox model definition, pass it to [Store] - Store(getObjectBoxModel())
ModelDefinition getObjectBoxModel() {
  final model = ModelInfo(
      entities: _entities,
      lastEntityId: const IdUid(1, 1730194067676730272),
      lastIndexId: const IdUid(0, 0),
      lastRelationId: const IdUid(0, 0),
      lastSequenceId: const IdUid(0, 0),
      retiredEntityUids: const [],
      retiredIndexUids: const [],
      retiredPropertyUids: const [],
      retiredRelationUids: const [],
      modelVersion: 5,
      modelVersionParserMinimum: 5,
      version: 1);

  final bindings = <Type, EntityDefinition>{
    Book: EntityDefinition<Book>(
        model: _entities[0],
        toOneRelations: (Book object) => [],
        toManyRelations: (Book object) => {},
        getId: (Book object) => object.id,
        setId: (Book object, int id) {
          object.id = id;
        },
        objectToFB: (Book object, fb.Builder fbb) {
          final titleOffset = fbb.writeString(object.title);
          final downloadUrlOffset = fbb.writeString(object.downloadUrl);
          final filePathOffset = object.filePath == null
              ? null
              : fbb.writeString(object.filePath!);
          final thumbnailOffset = object.thumbnail == null
              ? null
              : fbb.writeString(object.thumbnail!);
          fbb.startTable(6);
          fbb.addInt64(0, object.id);
          fbb.addOffset(1, titleOffset);
          fbb.addOffset(2, downloadUrlOffset);
          fbb.addOffset(3, filePathOffset);
          fbb.addOffset(4, thumbnailOffset);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = Book(
              id: const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0),
              title: const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 6, ''),
              downloadUrl: const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 8, ''),
              filePath: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 10),
              thumbnail: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 12));

          return object;
        })
  };

  return ModelDefinition(model, bindings);
}

/// [Book] entity fields to define ObjectBox queries.
class Book_ {
  /// see [Book.id]
  static final id = QueryIntegerProperty<Book>(_entities[0].properties[0]);

  /// see [Book.title]
  static final title = QueryStringProperty<Book>(_entities[0].properties[1]);

  /// see [Book.downloadUrl]
  static final downloadUrl =
      QueryStringProperty<Book>(_entities[0].properties[2]);

  /// see [Book.filePath]
  static final filePath = QueryStringProperty<Book>(_entities[0].properties[3]);

  /// see [Book.thumbnail]
  static final thumbnail =
      QueryStringProperty<Book>(_entities[0].properties[4]);
}