import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:epub_view/epub_view.dart';
import 'package:flutter/material.dart';
import 'package:qt_book_reader/model/book.dart';
import 'package:http/http.dart' as http;
import 'package:qt_book_reader/service/encrypter.dart';

import '../service/database.dart';

class EPubView extends StatefulWidget {
  final Book book;

  const EPubView({super.key, required this.book});

  @override
  State<EPubView> createState() => _EPubViewState();
}

class _EPubViewState extends State<EPubView> {
  late EpubController _epubController;
  bool _isLoading = true;

  FutureOr<Uint8List> loadInternetEPub({required String url}) async {
    final res = await http.get(Uri.parse(url));
    Database.instance.saveFile(book: widget.book, fileData: res.bodyBytes);
    return res.bodyBytes;
  }

  Future<void> loadFile() async {
    if (widget.book.filePath != null) {
      File file = File(widget.book.filePath!);
      List<int> decryptedData = EncryptService.instance
          .decryptBytes(encryptedBytes: await file.readAsBytes());

      _epubController = EpubController(
        document: EpubDocument.openData(Uint8List.fromList(decryptedData)),
        epubCfi: widget.book.progress,
      );
    } else {
      _epubController = EpubController(
        // Load document
        document: EpubDocument.openData(
          await loadInternetEPub(url: widget.book.downloadUrl),
        ),
      );
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    loadFile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Save here
        widget.book.progress = _epubController.generateEpubCfi();
        Database.instance.updateBook(book: widget.book);
        print('EPUB Progress');
        print(widget.book.progress);
        return true;
      },
      child: Scaffold(
        appBar: _isLoading
            ? null
            : AppBar(
                // Show actual chapter name
                title: EpubViewActualChapter(
                  controller: _epubController,
                  builder: (chapterValue) => Text(
                    'Chapter: ${chapterValue?.chapter?.Title?.replaceAll('\n', '').trim() ?? ''}',
                    textAlign: TextAlign.start,
                  ),
                ),
              ),
        // Show table of contents
        drawer: _isLoading
            ? null
            : Drawer(
                child: EpubViewTableOfContents(
                  controller: _epubController,
                ),
              ),
        // Show epub document
        body: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : EpubView(
                controller: _epubController,
                builders: EpubViewBuilders<DefaultBuilderOptions>(
                  options: const DefaultBuilderOptions(),
                  loaderBuilder: (_) =>
                      const Center(child: CircularProgressIndicator()),
                ),
              ),
      ),
    );
  }
}
