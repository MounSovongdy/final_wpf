import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor/constants/firebase.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:typed_data';
import 'package:universal_html/html.dart' as html;

class InvoiceController extends GetxController {
  var search = TextEditingController().obs;
  var filteredUsers = [].obs;

  void filterUserData() {
    String query = search.value.text.toLowerCase();

    filteredUsers.value = byUser.where((data) {
      return data.id.toString().contains(query) ||
          data.name.toLowerCase().contains(query) ||
          data.role.toLowerCase().contains(query);
    }).toList();
  }

  Future<Uint8List> generatePdf(
    PdfPageFormat format,
    String text,
  ) async {
    final pdf = pw.Document();
    final fontData = await rootBundle.load('assets/fonts/Inter-Bold.ttf');
    final ttf = pw.Font.ttf(fontData.buffer.asByteData());

    pdf.addPage(
      pw.Page(
        pageFormat: format,
        build: (pw.Context context) => pw.Center(
          child: pw.Text(
            text,
            style: pw.TextStyle(font: ttf, fontSize: 24),
          ),
        ),
      ),
    );
    return pdf.save();
  }

  void printPdf(Uint8List pdfData) {
    final blob = html.Blob([pdfData], 'application/pdf');
    final url = html.Url.createObjectUrlFromBlob(blob);

    html.AnchorElement(href: url)
      ..setAttribute('target', '_blank')
      ..click();

    Future.delayed(
      const Duration(seconds: 1),
      () => html.Url.revokeObjectUrl(url),
    );
  }
}
