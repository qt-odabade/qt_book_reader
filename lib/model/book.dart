import 'package:objectbox/objectbox.dart';

enum BookType { pdf, epub }

@Entity()
class Book {
  int id;

  final String title;
  final String downloadUrl;
  String? filePath;
  final String? thumbnail;

  Book({
    this.id = 0,
    required this.title,
    required this.downloadUrl,
    this.filePath,
    this.thumbnail,
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
