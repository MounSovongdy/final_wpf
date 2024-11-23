import 'package:flutter/material.dart';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
// ignore: avoid_web_libraries_in_flutter
import 'dart:js' as js;

import 'package:motor/constants/firebase.dart';

String buildTableRows(List<Map<String, dynamic>> payment) {
  return payment.map((item) {
    return '''
      <tr>
        <td>${item['no']}</td>
        <td>${item['date']}</td>
        <td>${item['amount']}</td>
        <td>${item['note']}</td>
      </tr>
    ''';
  }).join('');
}

Future<String> generateHtmlContent({
  required String penalty,
  required int counter,
  required payment,
  required plate,
  required String leasingYear,
  required String leasingMonth,
  required String leasingDay,
  required String fullName,
  required String gender,
  required String age,
  required String idCard,
  required String tel1,
  required String name2,
  required String tel2,
  required String name3,
  required String tel3,
  required String address,
  required String model,
  required String year,
  required String frameNo,
  required String engineeNo,
  required String plateNo,
  required String price,
  required String approve,
  required String deposit,
  required String totalOwn,
}) async {
  final StringBuffer htmlContent = StringBuffer();

  htmlContent.writeln('''
  <div id="pdfPaymentTable">
    <html lang="">
     <head>
                    <meta charset="utf-8">
                    <meta name="viewport" content="width=device-width, initial-scale=1.0" />              
                    <meta http-equiv="cache-control" content="max-age=0"/>
                    <meta http-equiv="cache-control" content="no-cache"/>
                    <meta http-equiv="expires" content="0"/>
                    <meta http-equiv="pragma" content="no-cache"/>
                    <link rel="preconnect" href="https://fonts.googleapis.com">
                    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
                    <link href="https://fonts.googleapis.com/css2?family=Battambang&family=Moul&display=swap" rel="stylesheet">
                    <style type="text/css" media="all">
                        @page {
                            margin: 15px; 
                        }
                        * { -webkit-print-color-adjust: exact !important; /* Chrome, Safari */ color-adjust: exact !important; /*Firefox*/ }
                        body { 
							color: #000; 
							font-family: "Battambang", "Khmer OS Battambang";
							font-size: 14px;
							line-height: 1.42857143;
							margin: 0 5px;
						}
						p {
							margin:5px 0;
						}
						.text-right {
							text-align: right;
                            padding-right: 10px !important;
						}
                        #wrapper { margin: 0 auto; padding-top: 20px; }
                        .btn { margin-bottom: 5px; }
                        .table { border-radius: 3px; width:100%; border-collapse: collapse; margin-bottom:-10px;}
                        thead.mythead, tr.mythead {color:#000; }
                        tr.mythead, tr.mytotal {color:#000 !important;}
                        tr.mythead th, tr.mytotal th {color:#000 !important;}
                        tr.mytotal th {font-size: 14px;}
                        tr.mythead th.text-right {padding-right:10px !important;}
						thead.mythead th { padding:10px 0; color:#000 !important;}
						tfoot.mytfoot { border-top: 1px solid #000;}
                        .table th, .table td { vertical-align: middle !important; padding:5px; border:1px solid;}
                        h3 { margin: 5px 0; }
                        
						a {
							text-decoration: none;
							color: #fff;
						}
						.btn-primary {
							background-color: #3c8dbc;
							border-color: #367fa9;
						}
						.btn-success {
							background-color: #00a65a;
							border-color: #008d4c;
						}
						.btn-warning {
							background-color: #f39c12;
							border-color: #e08e0b;
						}
						.btn-block {
							display: block;
							width: 100%;
						}
						.btn-primary {
							color: #fff;
						}
						.btn {
							border-radius: 3px;
                            font-family: "Battambang", "Khmer OS Battambang";
							margin-bottom: 5px;
							-webkit-box-shadow: none;
							box-shadow: none;
							border: 0px solid transparent;
							display: inline-block;
							padding: 6px 0;
							margin-bottom: 0;
							font-size: 14px;
							font-weight: 400;
							line-height: 1.42857143;
							text-align: center;
							white-space: nowrap;
							-ms-touch-action: manipulation;
							touch-action: manipulation;
							cursor: pointer;
							-webkit-user-select: none;
							-moz-user-select: none;
							-ms-user-select: none;
							user-select: none;
							margin-bottom: 5px;
						}
						.well-sm {
							padding: 5px;
							border-radius: 3px;
						}
						.well {
							min-height: 20px;
							border: 1px solid #000;
							border-radius: 4px;
							-webkit-box-shadow: inset 0 1px 1px rgba(0,0,0,.05);
							box-shadow: inset 0 1px 1px rgba(0,0,0,.05);
						}
						.alert-success {
							background-color: #00a65a!important;
							border-color: #008d4c!important;
						}
						.alert, .callout {
							border-radius: 3px;
						}
						.alert {
							padding: 15px;
							border: 1px solid transparent;
						}
						.alert, .thumbnail {
							margin-bottom: 20px;
						}
						.alert .close {
							color: #000;
							opacity: .2;
							filter: alpha(opacity=20);
						}
						button.close {
							-webkit-appearance: none;
							padding: 0;
							cursor: pointer;
							background: 0 0;
							border: 0;
						}
						.close {
							float: right;
							font-size: 21px;
							line-height: 1;
							color: #000;
							text-shadow: 0 1px 0 #fff;
							filter: alpha(opacity=20);
							opacity: .2;
						}
            .invoice-table {
                width: 100%;
                border-collapse: collapse;
            }
            .invoice-table, .invoice-table th, .invoice-table td {
                border: 1px solid black;
                padding: 8px;
                text-align: left;
            }
            .invoice-table th {
                background-color: #f2f2f2;
            }
                        a[href^=tel] {
                            color: inherit;
                            text-decoration: none;
                        }
						.alert .alert-link, .close {
							font-weight: 700;
						}						
                        @media print {
                            .no-print { display: none; }
                            #wrapper { max-width: 700px; min-width: 250px; margin: 0 auto; padding-top:0 !important;}	
                            thead {display: table-header-group;}
                            tfoot {display: table-footer-group;}
                            tr { page-break-inside:avoid; page-break-after:auto; }
                            td { page-break-inside:avoid; page-break-after:auto; }		
                            div#receipt-data {padding-right:0 !important;}			
                        }
                        @media only screen and (max-device-width: 480px) {
                            #wrapper {
                                max-width: 100% !important;
                                margin: 0 auto;
                                padding-top: 10px;
                            }
                            div#receiptData {
                                max-width: 100% !important;
                                margin: 0 auto;
                                padding : 10px;
                            }
                        }
                    </style>
                </head>
              <body>

              <div id="wrapper">        
                    <div id="receiptData" style="width: auto; max-width: 700px; margin: 0 auto;">                       
                        <div id="receipt-data" style="padding-right:10px;">
                        <br>                     
                              <table width="100%">                                 
                                <tr>                               
                                  <b><p style="font-size: 23px; font-family:Khmer OS Bokor;text-align:center;">កិច្ចសន្យាបង់ប្រាក់</p></b>
                                </tr>                                
                              </table>
                             <table width="100%"; style="font-size:12px; font-family:Khmer OS Battambang;">                                 
                                <tr>                               
                                  <td width: "35%">អតិថិជនឈ្មោះ <b>$fullName</td>
                                  <td width: "15%">ភេទ <b>$gender</td>
                                  <td width: "35%">អាយុ <b>$age</b>&nbsp;ឆ្នាំ</td>
                                  <td width: "15%">លេខអត្តសញ្ញាណប័ណ្ណ <b>$idCard</td>
                                </tr>                                
                              </table>
                             <table width="100%" style="border-spacing: 0;border:1px solid;">                                 
                                <tr>                               
                                  <td style="width: 25%; font-size:12px; font-family:Khmer OS Battambang;border-bottom:1px solid;border-right:1px solid; text-align:center">លេខទូរស័ព្ទ 3 ខ្សែ</td>
                                  <td style="width: 25%; font-size:12px; font-family:Khmer OS Battambang;border-bottom:1px solid;border-right:1px solid;">&nbsp;&nbsp; $tel1</td>
                                  <td style="width: 25%; font-size:12px; font-family:Khmer OS Battambang;border-bottom:1px solid;border-right:1px solid;">&nbsp;&nbsp; $tel2</td>
                                  <td style="width: 25%; font-size:12px; font-family:Khmer OS Battambang;border-bottom:1px solid; ">&nbsp;&nbsp; $tel3</td>
                                </tr>     
                                <tr>                               
                                  <td style="font-size:12px; font-family:Khmer OS Battambang;text-align:center;border-right:1px solid;">ឈ្មោះ </td>
                                  <td style="width: 25%; font-size:12px; font-family:Khmer OS Battambang;border-right:1px solid;"> &nbsp;&nbsp; $fullName</td>
                                  <td style="width: 25%; font-size:12px; font-family:Khmer OS Battambang;border-right:1px solid;"> &nbsp;&nbsp; $name2</td>
                                  <td style="width: 25%; font-size:12px; font-family:Khmer OS Battambang;border-right:1px solid;"> &nbsp;&nbsp; $name3</td>
                                </tr>                            
                              </table>
                              <table width="100%" style="font-size:12px; font-family:Khmer OS Battambang;">                                 
                                <tr>                               
                                  <td colspan="4">អាសយដ្ឋាន <b>$address</td>
                                </tr>       
                                <tr>                               
                                  <td colspan="2" width="75%">បានបង់រំលស់ម៉ូតូមួយគ្រឿងម៉ាក <b>$model</td>
                                  <td colspan="2">ឆ្នាំផលិត <b>$year</td>
                                </tr>     
                                 <tr>                               
                                  <td>លេខតួ <b>$frameNo</td>
                                  <td>លេខម៉ាស៊ីន <b>$engineeNo</td>
                                  <td>ពន្ធ/ស្លាកលេខ <b>$plateNo</td>
                                </tr>  
                                 <tr>                               
                                  <td width="25%">តម្លៃម៉ូតូ <b>$price\$</td>
                                  <td width="25%">ចំនួនទឹកប្រាក់អនុម័ត <b>$approve\$</td>
                                  <td width="25%">ចំនួនលុយចូលរួម <b>$deposit\$</td>
                                  <td width="25%">ដូចនេះនៅខ្វះ <b>$totalOwn\$</td>
                                </tr>
                                <tr>                               
                                  <td colspan="4">ចំនួនលុយដែលនៅខ្វះត្រូវបង់រំលស់ជាមួយហាងម៉ូតូ ហេង សុខបញ្ញាតាមតារាងបង់ប្រាក់ខាងក្រោម៖</td>
                                </tr>                      
                              </table>
                              <table width="100%" style="font-size:12px; font-family:Khmer OS Battambang;border:1px solid" class="invoice-table">  
                                <thead>
                                  <tr >
                                      <th style="text-align:center">ល.រ</th>
                                      <th style="text-align:center">កាលបរិច្ឆេទបង់លុយ</th>
                                      <th style="text-align:center">ចំនួនលុយត្រូវបង់</th>
                                      <th style="text-align:center">កំណត់សំគាល់</th>
                                  </tr>
                                  
                                </thead>
                                <tbody>
                          ''');
  for (int i = 0; i < plate.length; i++) {
    var amount = num.parse(plate[i].amount).toStringAsFixed(2);

    htmlContent.writeln('<tr style="height: 10px;">');
    htmlContent.writeln(
        '<td style="text-align:center; line-height: 10px;"> ${plate[i].no}</td>');
    htmlContent.writeln(
        '<td style="text-align:center; line-height: 10px;"> ${plate[i].date}</td>');
    htmlContent.writeln(
        '<td style="text-align:center; line-height: 10px;"> $amount \$</td>');
    htmlContent
        .writeln('<td style="line-height: 10px;"> ${plate[i].note}</td>');
  }

  for (int i = counter; i < payment.length; i++) {
    var amount = num.parse(payment[i].amount).toStringAsFixed(2);

    htmlContent.writeln('<tr style="height: 10px;">');
    htmlContent.writeln(
        '<td style="text-align:center; line-height: 10px;"> ${payment[i].no}</td>');
    htmlContent.writeln(
        '<td style="text-align:center; line-height: 10px;"> ${payment[i].date}</td>');
    htmlContent.writeln(
        '<td style="text-align:center; line-height: 10px;"> $amount \$</td>');
    htmlContent
        .writeln('<td style="line-height: 10px;"> ${payment[i].note}</td>');
  }

  htmlContent.writeln('''
                                  </tbody>
                              </table>

                              <br>

                              <div>
                                <img src="http://moto.cpos.cc/payment.png" alt="" width="100%">
                              </div><br>
                              <div style="font-size:12px; font-family:Khmer OS Battambang;">ក្នុងករណីបង់យឺត អតិថិជនយល់ព្រមបង់ប្រាក់ពិន័យក្នុងមួយថ្ងៃចំនួន <b>$penalty</b> \$</div>
                              <div style="font-size:12px; font-family:Khmer OS Battambang;">អតិថិជនបានអាន និងស្តាប់ហើយព្រមព្រៀងបង់តាមពេលវេលាដែលបានកំណត់ដូចខាងលើ។</div>
                              <br>
                              <div style="font-size:12px; font-family:Khmer OS Battambang;text-align:right">ធ្វើនៅ រាជធានីភ្នំពេញ ថ្ងៃទី <b>$leasingDay ខែ <b>$leasingMonth ឆ្នាំ <b>$leasingYear </div>
                              <br><br><br><br><br>
                              <table width="100%">
                                <tr>
                                  <td width="50%">
                                    <div style="font-size:12px; font-family:Khmer OS Battambang;">ឈ្មោះអតិថិជន <b>$fullName</div>
                                  </td>
                                  <td>
                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                  </td>
                                  <td>
                                    <div style="font-size:12px; font-family:Khmer OS Battambang;">ត្រាហាងម៉ូតូ</div>
                                  </td>
                                </tr>
                              </table>                                                              
                      </div>
                  </div>
              </div>
              </body>
                    
    </html>
    
 ''');

  return htmlContent.toString();
}

void printPaymentTable(int id) async {
  await getByLeasing(id);
  await getByReceivable(id);
  await getByPlateSchedule(id);
  await getByPaymentSchedule(id);

  int counter = 0;

  final htmlContent = await generateHtmlContent(
    penalty: byReceivable[0].penalty,
    counter: counter,
    payment: schedule,
    plate: plate,
    leasingYear: byLeasing[0].leasingDate.split(' ')[0].split('-')[0],
    leasingMonth: byLeasing[0].leasingDate.split(' ')[0].split('-')[1],
    leasingDay: byLeasing[0].leasingDate.split(' ')[0].split('-')[2],
    fullName: byLeasing[0].name,
    gender: byLeasing[0].gender,
    age: byLeasing[0].age,
    idCard: byLeasing[0].idCard,
    tel1: byReceivable[0].tel1,
    name2: byReceivable[0].name2,
    tel2: byReceivable[0].tel2,
    name3: byReceivable[0].name3,
    tel3: byReceivable[0].tel3,
    address: byLeasing[0].address,
    model: byLeasing[0].model,
    year: byLeasing[0].year,
    frameNo: byLeasing[0].frameNo,
    engineeNo: byLeasing[0].engineNo,
    plateNo: byLeasing[0].plateNo == '' ? 'ក្រដាសពន្ធ' : byLeasing[0].plateNo,
    price: byLeasing[0].price,
    approve: byLeasing[0].approveAmount,
    deposit: byLeasing[0].deposit,
    totalOwn: byLeasing[0].totalDebt,
  );

  final div = html.DivElement()
    ..setInnerHtml(htmlContent, treeSanitizer: html.NodeTreeSanitizer.trusted);
  html.document.body?.append(div);

  try {
    js.context.callMethod('printPaymentTable');
  } catch (e) {
    debugPrint('Error calling printContent: $e');
  }

  await Future.delayed(const Duration(seconds: 1));
  div.remove();
}
