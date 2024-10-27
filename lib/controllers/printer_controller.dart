import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';


class PrintController extends GetxController{
  final GlobalKey globalKey = GlobalKey();
  String textToPrint = "Default Text";

  Future<Uint8List> _captureTextAsImage() async {
    await Future.delayed(const Duration(milliseconds: 100));
    final RenderRepaintBoundary? boundary =
    globalKey.currentContext?.findRenderObject() as RenderRepaintBoundary?;

    if (boundary == null) {
      throw Exception("RenderRepaintBoundary is not available");
    }

    final ui.Image image = await boundary.toImage(pixelRatio: 3.0);
    final ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    return byteData!.buffer.asUint8List();
  }

  Future<Uint8List> _generatePdfWithImage(Uint8List imageBytes) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Image(
              pw.MemoryImage(imageBytes),
              width: 200,
              height: 100,
            ),
          );
        },
      ),
    );

    return pdf.save();
  }
  Future<void> printPdf(String text) async {
    textToPrint = text;  // Update the text to display in the widget

    try {
      // Capture the updated text as an image
      Uint8List imageBytes = await _captureTextAsImage();

      // Generate a PDF with the image
      Uint8List pdfData = await _generatePdfWithImage(imageBytes);

      // Print the PDF
      await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => pdfData,
      );
    } catch (e) {
      debugPrint("Error generating PDF: $e");
    }
  }
}