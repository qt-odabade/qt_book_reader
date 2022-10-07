import 'package:flutter/material.dart';
import 'package:qt_book_reader/view/library/internet_files.dart';
import 'package:qt_book_reader/view/library/offline_files.dart';

class LibraryView extends StatefulWidget {
  const LibraryView({super.key});

  @override
  State<LibraryView> createState() => _LibraryViewState();
}

class _LibraryViewState extends State<LibraryView> {
  final List<Widget> _pages = [
    const InternetFiles(),
    const OfflineFiles(),
  ];
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages.elementAt(_currentIndex),
      bottomNavigationBar: BottomNavigationBar(
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
        ],
      ),
    );
  }
}
