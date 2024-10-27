import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:universal_html/html.dart' as html;

import '../constants/constants.dart';

Future<Uint8List> generatePdf() async {
  final pdf = pw.Document();
  final ByteData fontData = await rootBundle.load('assets/fonts/KhmerOS.ttf');
  final pw.Font khmerFont = pw.Font.ttf(fontData);

  // Add a page to the PDF document
  pdf.addPage(
    pw.Page(
      build: (pw.Context context) => pw.Column(
        children: [
          pw.Center(
            child: pw.Column(
              children: [
                pw.Container(
                  height: 1,
                  color:
                      invoiceText, // Ensure invoiceText is defined in your constants
                ),
                pw.Text(
                  'ទិញលក់ និង បង់រំលស់ម៉ូតូគ្រប់ប្រភេទ', // Khmer text
                  style: pw.TextStyle(font: khmerFont, color: invoiceText),
                ),
                pw.SizedBox(height: 30),
                pw.Row(
                  children: [
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text('096 888 3369',
                            style: pw.TextStyle(
                                font: khmerFont, color: invoiceText)),
                        pw.Text('097 888 3369',
                            style: pw.TextStyle(
                                font: khmerFont, color: invoiceText)),
                        pw.Text('012 888 795',
                            style: pw.TextStyle(
                                font: khmerFont, color: invoiceText)),
                      ],
                    ),
                    pw.Spacer(),
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Row(
                          children: [
                            pw.Text('វិក្កយបត្រលេខ : ',
                                style: pw.TextStyle(
                                    font: khmerFont, color: invoiceText)),
                            pw.Text('00001',
                                style: pw.TextStyle(
                                    font: khmerFont, color: invoiceText)),
                          ],
                        ),
                        pw.Row(
                          children: [
                            pw.Text('កាលបរិច្ឆទ : ',
                                style: pw.TextStyle(
                                    font: khmerFont, color: invoiceText)),
                            pw.Text('25 - 10 - 2024',
                                style: pw.TextStyle(
                                    font: khmerFont, color: invoiceText)),
                          ],
                        ),
                        pw.Row(
                          children: [
                            pw.Text('ពន្ធ/ស្លាកលេខ : ',
                                style: pw.TextStyle(
                                    font: khmerFont, color: invoiceText)),
                            pw.Text('0001',
                                style: pw.TextStyle(
                                    font: khmerFont, color: invoiceText)),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );

  // Return the generated PDF document as a byte array
  return pdf.save();
}

void printPdf(Uint8List pdfData) {
  if (pdfData.isEmpty) {
    debugPrint("Error: PDF data is null or empty.");
    return; // Exit if no valid PDF data
  }

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
