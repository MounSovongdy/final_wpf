import 'dart:html' as html;
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' as excel;

class ReportController extends GetxController {
  Future<void> downloadExcel({
    required String fileName,
    required List<String> headers,
    required List<List<dynamic>> data,
  }) async {
    final excel.Workbook workbook = excel.Workbook();
    final excel.Worksheet sheet = workbook.worksheets[0];

    final excel.Style headerStyle = workbook.styles.add('HeaderStyle');
    headerStyle.bold = true;
    headerStyle.fontName = 'Times New Roman';
    headerStyle.hAlign = excel.HAlignType.center;
    headerStyle.borders.all.lineStyle = excel.LineStyle.thin;

    final excel.Style dataStyle = workbook.styles.add('DataStyle');
    dataStyle.fontName = 'Calibri';
    dataStyle.hAlign = excel.HAlignType.center;
    dataStyle.borders.all.lineStyle = excel.LineStyle.thin;

    for (int i = 0; i < headers.length; i++) {
      final excel.Range cell = sheet.getRangeByIndex(1, i + 1);
      cell.setText(headers[i]);
      cell.cellStyle = headerStyle;
    }

    for (int i = 0; i < data.length; i++) {
      final row = data[i];
      for (int j = 0; j < row.length; j++) {
        final excel.Range cell = sheet.getRangeByIndex(i + 2, j + 1);
        cell.setText(row[j].toString());
        cell.cellStyle = dataStyle;
      }
    }

    final List<int> bytes = workbook.saveAsStream();
    if (kIsWeb) {
      await _downloadFileWeb(bytes,fileName);
    } else {
      await _saveFileLocal(bytes);
    }
  }

  Future<void> _downloadFileWeb(List<int> bytes, String fileName) async {
    try {
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
    } catch (e) {
      debugPrint("Error while handling web download: $e");
    }
  }

  Future<void> _saveFileLocal(List<int> bytes) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final String filePath = '${directory.path}/booking.xlsx';

      final File file = File(filePath);
      await file.writeAsBytes(bytes, flush: true);

      await OpenFile.open(filePath);
    } catch (e) {
      debugPrint("Error in local save logic: $e");
    }
  }
}
