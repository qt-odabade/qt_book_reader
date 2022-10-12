import 'package:flutter/material.dart';
import 'package:qt_book_reader/view/library/internet_files.dart';
import 'package:qt_book_reader/view/library/offline_files.dart';
import 'package:qt_book_reader/view/native_doc_view.dart';
import 'package:qt_book_reader/view/widget_doc_view.dart';

class LibraryView extends StatefulWidget {
  const LibraryView({super.key});

  @override
  State<LibraryView> createState() => _LibraryViewState();
}

class _LibraryViewState extends State<LibraryView> {
  final List<Widget> _pages = [
    const InternetFiles(),
    const OfflineFiles(),
    const NativeDocView(),
    const WidgetDocView(),
  ];
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages.elementAt(_currentIndex),
      bottomNavigationBar: BottomNavigationBar(
        // selectedIconTheme: IconThemeData(color: Colors.blue),
        selectedItemColor: Colors.blue,
        // unselectedIconTheme: IconThemeData(color: Colors.grey),
        unselectedItemColor: Colors.grey,
        currentIndex: _currentIndex,
        onTap: (value) {
          setState(() {
            _currentIndex = value;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.book_rounded),
            label: 'Library',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.download_done_rounded),
            label: 'Offline',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.android_rounded),
            label: 'Native Docx',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.flutter_dash_rounded),
            label: 'Flutter Docx',
          ),
        ],
      ),
    );
  }
}
