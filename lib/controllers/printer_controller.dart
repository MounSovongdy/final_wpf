
import 'package:flutter/services.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:universal_html/html.dart' as html;
import 'package:typed_data/typed_data.dart';


  // Future<Uint8List> generatePdf() async {
  //
  //   final ByteData fontData = await rootBundle.load('assets/fonts/Battambang-Regular.ttf');
  //   final pw.Font ttf = pw.Font.ttf(fontData.buffer.asUint8List() as ByteData);
  //
  //   final pdf = pw.Document();
  //   pdf.addPage(
  //     pw.Page(
  //       build: (pw.Context context) {
  //         return pw.Center(
  //           child: pw.Text(
  //             'សួស្តីពិភពលោក', // "Hello World" in Khmer
  //             style: pw.TextStyle(font: ttf, fontSize: 40),
  //           ),
  //         );
  //       },
  //     ),
  //   );
  //
  //     return await pdf.save();
  // }


void printPdf(Uint8List pdfData) {
  final blob = html.Blob([pdfData], 'application/pdf');
  final url = html.Url.createObjectUrlFromBlob(blob);
  final anchor = html.AnchorElement(href: url)
    ..target = 'blank'
    ..setAttribute('download', 'document.pdf')
    ..click();
  html.Url.revokeObjectUrl(url);
}