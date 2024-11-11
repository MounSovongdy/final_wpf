import 'package:flutter/material.dart';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
// ignore: avoid_web_libraries_in_flutter
import 'dart:js' as js;

import 'package:motor/constants/firebase.dart';

Future<String> generateHtmlContent({
  required String invoiceNum,
  required String invoiceDate,
  required String plateNo,
  required String customerName,
  required String customerAge,
  required String customerId,
  required String customerAddress,
  required String totalPrice,
  required String approveAmount,
  required String gender,
  required String tel,
  required String model,
  required String yearProduct,
  required String power,
  required String color,
  required String frameNo,
  required String machinNo,
}) async {
  
  return '''
  <div id="pdfLeasingInvoice">
<html lang="en">
  <head>
      <meta charset="utf-8">
      <meta name="viewport" content="width=device-width, initial-scale=1.0">
      <meta http-equiv="cache-control" content="no-cache">
      <meta http-equiv="expires" content="0">
      <meta http-equiv="pragma" content="no-cache">
      <link rel="preconnect" href="https://fonts.googleapis.com">
      <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
      <link href="https://fonts.googleapis.com/css2?family=Battambang&family=Moul&display=swap" rel="stylesheet">
      
      <style type="text/css" media="all">
          @page {
              margin: 15px;
          }
          body {
              color: #000;
              font-family: "Battambang", "Khmer OS Battambang", sans-serif;
              font-size: 14px;
              line-height: 1.4;
              margin: 0;
              padding: 5px;
          }
          p {
              margin: 5px 0;
          }
          .text-center { text-align: center; }
          .text-right { text-align: right; padding-right: 10px; }
          
          #wrapper {
              margin: 0 auto;
              max-width: 700px;
          }

          .table {
              width: 100%;
              border-collapse: collapse;
              margin-bottom: 10px;
          }
          .table th, .table td {
              padding: 5px;
              font-size: 17px;
              text-align: left;
              color: #282D91;
          }
          .header-text {
              font-size: 19px;
              color: #282D91;
          }
          .sub-header-text {
              font-size: 18px;
              color: #282D91;
          }
          .well {
              padding: 10px;
              background-color: #CEEDFB;
              color: #282D91;
              text-align: right;
              border-radius: 4px;
          }
          
          /* Print-specific styles */
          @media print {
              .no-print { display: none; }
              #wrapper {
                  margin: 0 auto;
                  padding: 0;
              }
              .text-right { text-align: right; }
              .well { color: #282D91; font-size: 15px; }
          }

          .table .text-right {
            text-align: right;
          }
      </style>
  </head>

  <body>
      <div id="wrapper">
          <div id="receiptData" style="margin: 0 auto; text-align: center;">
              <!-- Header Image -->
              <div><img src="http://moto.cpos.cc/header.png" alt="Header Image" style="width: 100%;"></div>

              <!-- Title and Address -->
              <br>
              <p class="header-text text-center"><b>ទិញ លក់ និងបង់រំលស់ម៉ូតូគ្រប់ប្រភេទ</p>
              <p class="sub-header-text text-center"><b>ផ្ទះលេខ 268 & 269 ផ្លូវវេងស្រេង ភូមិត្រពាំងថ្លឹង សង្កាត់ចោមចៅ ខណ្ឌពោធិ៍សែនជ័យ រាជធានីភ្នំពេញ</p>
            
              <!-- Invoice Details -->
              <br>
              <table class="table">
                <tr>
                    <td>Tel: 096 888 3369</td>
                    <td>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    </td>
                    <td>វិក្កយបត្រលេខ: <b>$invoiceNum</td>
                </tr>
                <tr>
                    <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;097 888 3369</td>
                    <td>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    </td>
                    <td>កាលបរិច្ឆេទ: <b>$invoiceDate</td>
                </tr>
                <tr>
                    <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;012 888 795</td>
                    <td>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    </td>
                    <td>ពន្ធ / ស្លាកលេខ: <b>$plateNo</td>
                </tr>
              </table>

              <!-- Customer Information -->
              <br>
              <table class="table">
                  <tr>
                      <td>លក់ជូនអតិថិជន: <b>$customerName</td>
                      <td>ភេទ: <b>$gender</td>
                      <td>អាយុ: <b>$customerAge</td>
                  </tr>
                  <tr>
                      <td>លេខអត្តសញ្ញាណប័ណ្ណ: <b>$customerId</td>
                      <td>លេខទូរស័ព្ទ: <b>$tel</td>
                  </tr>
                  <tr>
                      <td colspan="3">អាសយដ្ឋាន: <b>$customerAddress</td>
                  </tr>
                  <tr>
                      <td>ម៉ាកម៉ូតូ: <b>$model</td>
                      <td>ឆ្នាំផលិត: <b>$yearProduct</td>
                  </tr>
                  <tr>
                      <td>កំលាំង: <b>$power</td>
                      <td>ពណ៍: <b>$color</td>
                  </tr>
                  <tr>
                      <td>លេខតួ: <b>$frameNo</td>
                      <td>លេខម៉ាស៊ីន: <b>$machinNo</td>
                  </tr>
              </table>

              <!-- Note and Total Price -->
              <table class="table">
                <tr>
                    <td><b>បញ្ជាក់: ទំនិញទិញហើយមិនអាចដូរវិញបានទេ! </td>
                </tr>
              </table>

              <table width="30%" align="right">
                    <td style="border: 0.5px solid black;border-radius: 10px;font-size:17px; font-family:Khmer OS Battambang;color:#282D91" bgcolor="#CEEDFB">
                        <b>&nbsp;&nbsp; តម្លៃសរុប:&nbsp;&nbsp;&nbsp;$totalPrice</b>
                        <hr style="border: 0.1px solid black">
                        <b>&nbsp;&nbsp;  អនុម័ត:&nbsp;&nbsp;&nbsp;$approveAmount</b>
                    </td>
                </table>

              <!-- Signatures -->
              <table width="100%" class="table">
                  <tr>
                      <td class="text-center">ហត្ថលេខាអតិថិជន<br>Customer Signature</b>
                          <br><br><br><br><br>.....................................
                      </td>
                      <td>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                      </td>
                      <td class="text-center">ត្រាហាងម៉ូតូ<br>Store Stamp</b>
                          <br><br><br><br><br>.....................................
                      </td>
                  </tr>
              </table>
          </div>
      </div>
  </body>
</html>
    
  ''';
}

void printLeasingInvoice(int id) async {
  await getByLeasing(id);

  final htmlContent = await generateHtmlContent(
    invoiceNum: '${byLeasing[0].id}',
    invoiceDate: byLeasing[0].leasingDate,
    plateNo: byLeasing[0].plateNo,
    customerName: byLeasing[0].name,
    customerAge: byLeasing[0].age,
    customerId: byLeasing[0].idCard,
    customerAddress: byLeasing[0].address,
    totalPrice: byLeasing[0].price,
    approveAmount: byLeasing[0].approveAmount,
    gender: byLeasing[0].gender,
    tel: byLeasing[0].tel,
    model: byLeasing[0].model,
    yearProduct: byLeasing[0].year,
    power: byLeasing[0].power,
    color: byLeasing[0].color,
    frameNo: byLeasing[0].frameNo,
    machinNo: byLeasing[0].engineNo,
  );

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
