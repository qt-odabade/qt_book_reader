import 'package:flutter/material.dart';
import 'package:qt_book_reader/view/library/library_view.dart';

import 'database/database.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Database.instance.init();

  runApp(const BookReader());
}

class BookReader extends StatelessWidget {
  const BookReader({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Book Reader',
      home: LibraryView(),
    );
  }
}
