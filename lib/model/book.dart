import 'package:hive/hive.dart';

part 'book.g.dart';

@HiveType(typeId: 0)
class Book extends HiveObject {
  @HiveField(0)
  final int id;

  /// Title of file with extension
  @HiveField(1)
  final String title;

  @HiveField(2)
  final String downloadUrl;

  @HiveField(3)
  String? filePath;

  @HiveField(4)
  String? thumbnail;

  /// PDF: Page no(`int`)
  ///
  /// TXT: scroll position(`double`)
  ///
  /// EPUB: epubcfi(/6/6[chapter-2]!/4/2/1612)(`String`)
  @HiveField(5)
  String? progress;

  bool get isPDF => downloadUrl.endsWith('.pdf');
  bool get isEPub => downloadUrl.endsWith('.epub');
  bool get isTxt => downloadUrl.endsWith('.txt');

  String get fileExtension => downloadUrl.split('.').last;

  Book({
    required this.id,
    required this.title,
    required this.downloadUrl,
    this.filePath,
    this.thumbnail,
    this.progress,
  });

  @override
  int get hashCode => Object.hash(id, title, downloadUrl, filePath, thumbnail);

  @override
  bool operator ==(Object other) {
    return other is Book &&
        other.id == id &&
        other.title == title &&
        other.thumbnail == thumbnail &&
        other.downloadUrl == downloadUrl &&
        other.filePath == filePath;
  }
}
