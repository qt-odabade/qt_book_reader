import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';
import 'package:http/http.dart' as http;
import 'package:qt_book_reader/model/book.dart';

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
    return res.bodyBytes;
  }

  @override
  void initState() {
    _pdfController = PdfController(
        document: PdfDocument.openData(
            loadInternetPdf(url: widget.book.downloadUrl)));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }
}
