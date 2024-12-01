import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' as excel;

class ReportController extends GetxController{
  Future<void> downloadExcel({
    required String fileName,
    required List<String> headers,
    required List<List<dynamic>> data,
  }) async {
    final excel.Workbook workbook = excel.Workbook();
    final excel.Worksheet sheet = workbook.worksheets[0];

    final excel.Style headerStyle = workbook.styles.add('HeaderStyle');
    headerStyle.fontName = 'Khmer OS';
    headerStyle.bold = true;
    headerStyle.hAlign = excel.HAlignType.center;
    headerStyle.borders.all.lineStyle = excel.LineStyle.thin;

    for (int i = 0; i < headers.length; i++) {
      final excel.Range cell = sheet.getRangeByIndex(2, i + 1);
      cell.setValue(headers[i]);
      cell.cellStyle = headerStyle;
    }

    final excel.Style dataStyle = workbook.styles.add('DataStyle');
    dataStyle.fontName = 'Khmer OS';
    dataStyle.hAlign = excel.HAlignType.center;
    dataStyle.borders.all.lineStyle = excel.LineStyle.thin;
    
    for (int i = 0; i < data.length; i++) {
      final row = data[i];
      for (int j = 0; j < row.length; j++) {
        final excel.Range cell = sheet.getRangeByIndex(i + 3, j + 1);
        cell.setText(row[j].toString());
        cell.cellStyle = dataStyle;
      }
    }

    final List<int> bytes;
    try {
      bytes = workbook.saveAsStream();
    } catch (e) {
      debugPrint("Error while saving workbook: $e");
      workbook.dispose();
      return;
    }
    workbook.dispose();

    if (kIsWeb) {
      final blob = html.Blob([bytes],
          'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');
      final url = html.Url.createObjectUrlFromBlob(blob);

      final anchor = html.AnchorElement(href: url)
        ..setAttribute("download", fileName)
        ..style.display = "none";
      html.document.body?.append(anchor);
      anchor.click();
      anchor.remove();
      html.Url.revokeObjectUrl(url);
    } else {
      try {
        final String path = (await getApplicationDocumentsDirectory()).path;
        final String filePath = '$path/$fileName';
        final File file = File(filePath);
        await file.writeAsBytes(bytes, flush: true);

        OpenFile.open(filePath);
      } catch (e) {
        debugPrint("Error in local save logic: $e");
      }
    }
  }
}