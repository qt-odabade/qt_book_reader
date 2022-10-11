import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';
import 'package:http/http.dart' as http;
import 'package:qt_book_reader/service/database.dart';
import 'package:qt_book_reader/model/book.dart';

import '../service/encrypter.dart';

class PDFView extends StatefulWidget {
  final Book book;

  const PDFView({super.key, required this.book});

  @override
  State<PDFView> createState() => _PDFViewState();
}

class _PDFViewState extends State<PDFView> {
  late PdfController _pdfController;

  FutureOr<Uint8List> loadInternetPdf({required String url}) async {
    final res = await http.get(Uri.parse(url));
    Database.instance.saveFile(book: widget.book, fileData: res.bodyBytes);
    return res.bodyBytes;
  }

  Future<Uint8List> decryptFile(String filePath) async {
    File file = File(filePath);
    List<int> decryptedData = EncryptService.instance
        .decryptBytes(encryptedBytes: await file.readAsBytes());

    return Uint8List.fromList(decryptedData);
  }

  @override
  void initState() {
    if (widget.book.filePath != null) {
      _pdfController = PdfController(
        document: PdfDocument.openData(decryptFile(widget.book.filePath!)),
        initialPage: int.tryParse(widget.book.progress ?? '') != null
            ? int.parse(widget.book.progress!)
            : 1,
      );
    } else {
      _pdfController = PdfController(
        document:
            PdfDocument.openData(loadInternetPdf(url: widget.book.downloadUrl)),
      );
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        widget.book.progress = _pdfController.page.toString();
        Database.instance.updateBook(book: widget.book);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.book.title),
        ),
        body: PdfView(
          controller: _pdfController,
          builders: PdfViewBuilders<DefaultBuilderOptions>(
            options: const DefaultBuilderOptions(),
            documentLoaderBuilder: (_) =>
                const Center(child: CircularProgressIndicator()),
            pageLoaderBuilder: (_) =>
                const Center(child: CircularProgressIndicator()),
          ),
        ),
      ),
    );
  }
}
