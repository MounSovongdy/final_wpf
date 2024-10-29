// ignore_for_file: avoid_web_libraries_in_flutter

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:html' as html;
import 'dart:js' as js;

Future<String> generateHtmlContent() async {
  final fontBytes =
      await rootBundle.load('assets/fonts/NotoSansKhmer-Regular.ttf');
  final fontBase64 = base64.encode(fontBytes.buffer.asUint8List());

  return '''
    <div id="pdfContent" style="font-family: 'NotoSansKhmer'; font-size: 24px;">
      <style>
        @font-face {
          font-family: 'NotoSansKhmer';
          src: url(data:font/ttf;base64,$fontBase64) format('truetype');
        }
        body {
            font-family: Arial, sans-serif;
            color: #2f2c7f;
            margin: 0;
            padding: 0;
        }
        .invoice-container {
            border: 1px solid #2f2c7f;
            padding: 20px;
            max-width: 600px;
            margin: auto;
        }
        .header, .contact, .info {
            text-align: center;
        }
        .header h1 {
            font-size: 36px;
            margin: 0;
        }
        .header h2 {
            margin: 5px 0;
            font-size: 18px;
        }
        .header img {
            max-width: 100px;
            margin: 10px 0;
        }
        .address {
            font-size: 14px;
            margin-bottom: 20px;
        }
        .contact {
            display: flex;
            justify-content: center;
            gap: 20px;
            font-size: 18px;
        }
        .contact div {
            text-align: center;
        }
        .contact img {
            max-width: 20px;
        }
        .info {
            margin-top: 20px;
            font-size: 16px;
            line-height: 1.5;
        }
        .info div {
            margin: 10px 0;
        }
        .form-container {
            border: 1px solid #2f2c7f;
            padding: 20px;
            max-width: 700px;
            margin: auto;
            line-height: 1.8;
        }
        .form-line {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin: 10px 0;
        }
        .form-line span {
            flex: 1;
            margin-right: 5px;
        }
        .form-line input {
            border: none;
            border-bottom: 1px dotted #2f2c7f;
            width: 100%;
            padding: 3px;
        }
        .notice {
            text-align: center;
            font-size: 14px;
            margin-top: 20px;
        }
        .signature-section {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: 30px;
        }
        .signature-section div {
            text-align: center;
        }
        .stamp {
            border: 1px solid #2f2c7f;
            padding: 10px;
            background-color: #e1eaff;
            font-weight: bold;
            color: #2f2c7f;
        } 
      </style>

      <div class="invoice-container">
        <div class="header">
          <h1>HSP</h1>
          <h2>Heng Sok Panha Motor Shop</h2>
          <img src="path_to_motorbikes_image.png" alt="Motorbikes">
        </div>
        <div class="address">
          <p> ផ្ទះលេខ 268 & 269 ផ្លូវជាតិលេខ៤, ភូមិព្រែកតាជ័យ សង្កាត់ចោមចៅ២ ខណ្ឌពោធិចិន </p>
        </div>
        <div class="contact">
          <div>
            <img src="phone_icon.png" alt="Phone">
            <p>096 711 8000</p>
          </div>
          <div>
            <p>097 711 8000</p>
          </div>
          <div>
            <p>076 711 8000</p>
          </div>
        </div>
        <div class="info">
            <div> អតិថិជន៖ ................................................................. </div>
            <div> ការចាប់ផ្តើម៖ .................................................... </div>
            <div> ថ្ងៃទី / ស្លាកលេខ៖ ............................................ </div>
        </div>
      </div>
      <div class="form-container">
        <div class="form-line">
          <span> លេខផ្ទះ អតិថិជន: </span>
          <input type="text">
          <span> ស្រុក: </span>
          <input type="text">
          <span> ខេត្ត: </span>
          <input type="text">
        </div>
        <div class="form-line">
          <span> លេខកូនសោរម៉ូតូ: </span>
          <input type="text">
          <span> លេខម៉ាស៊ីន: </span>
          <input type="text">
        </div>
        <div class="form-line">
          <span> អាសយដ្ឋាន: </span>
          <input type="text">
        </div>
        <div class="form-line">
          <span> ម៉ាកម៉ូតូ: </span>
          <input type="text">
          <span> ចំនួនស៊ីស៊ី: </span>
          <input type="text">
          <span> ពណ៌: </span>
          <input type="text">
        </div>
        <div class="form-line">
          <span> លេខតួ: </span>
          <input type="text">
          <span> លេខម៉ាស៊ីន: </span>
          <input type="text">
        </div>
        <div class="notice">
            <p> ចំណាំ: ទំនិញទិញហើយមិនអាចប្ដូរវិញបានទេ! </p>
        </div>
        <div class="signature-section">
          <div>
            <p> ហត្ថលេខាអតិថិជន </p>
            <p> Customer Signature </p>
          </div>
          <div class="stamp">
            <p> កន្លែងស្តាំ </p>
          </div>
          <div>
            <p> ស្លាកលេខ </p>
            <p> Store Stamp </p>
          </div>
        </div>
      </div>
    </div>
  ''';
}

void downloadPdf() async {
  final htmlContent = await generateHtmlContent();

  final div = html.DivElement()
    ..setInnerHtml(htmlContent, treeSanitizer: html.NodeTreeSanitizer.trusted);
  html.document.body?.append(div);

  try {
    js.context.callMethod('downloadPDF');
  } catch (e) {
    debugPrint('Error calling downloadPDF: $e');
  }

  div.remove();
}

void printPdf() async {
  final htmlContent = await generateHtmlContent();

  final div = html.DivElement()
    ..setInnerHtml(htmlContent, treeSanitizer: html.NodeTreeSanitizer.trusted);
  html.document.body?.append(div);

  try {
    js.context.callMethod('printContent');
  } catch (e) {
    debugPrint('Error calling printContent: $e');
  }

  await Future.delayed(const Duration(seconds: 1));

  div.remove();
}
