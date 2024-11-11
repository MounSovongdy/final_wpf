import 'package:flutter/material.dart';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
// ignore: avoid_web_libraries_in_flutter
import 'dart:js' as js;

import 'package:motor/constants/firebase.dart';

Future<String> generateHtmlContent({
  required payment,
  required String leasingYear,
  required String leasingMonth,
  required String leasingDay,
  required String fullName,
  required String gender,
  required String age,
  required String idCard,
  required String tel1,
  required String tel2,
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
  return '''
  <div id="pdfPaymentTable">
    <html>
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
                              <table width="100%">                                 
                                <tr>                               
                                  <b><p style="font-size: 22px; font-family:Khmer OS Bokor;text-align:center;">កិច្ចសន្យាបង់ប្រាក់</p></b>
                                </tr>                                
                              </table>
                             <table width="100%">                                 
                                <tr>                               
                                  <td style="font-size:15px; font-family:Khmer OS Battambang; ">អតិថិជនឈ្មោះ <b>$fullName</td>
                                  <td style="font-size:15px; font-family:Khmer OS Battambang;">ភេទ <b>$gender</td>
                                  <td style="font-size:15px; font-family:Khmer OS Battambang;">អាយុ <b>$age</td>
                                  <td style="font-size:15px; font-family:Khmer OS Battambang;">លេខអត្តសញ្ញាណប័ណ្ណ <b>$idCard</td>
                                </tr>                                
                              </table>
                             <table width="100%" style="border-spacing: 0;border:1px solid;">                                 
                                <tr>                               
                                  <td style="width: 25%; font-size:15px; font-family:Khmer OS Battambang;border-bottom:1px solid;border-right:1px solid; text-align:center">លេខទូរសព្ទ3ខ្សែ                 </td>
                                  <td style="width: 25%; font-size:15px; font-family:Khmer OS Battambang;border-bottom:1px solid;border-right:1px solid;"> &nbsp;&nbsp;<b>$tel1</td>
                                  <td style="width: 25%; font-size:15px; font-family:Khmer OS Battambang;border-bottom:1px solid;border-right:1px solid;"> &nbsp;&nbsp;<b>$tel2</td>
                                  <td style="width: 25%; font-size:15px; font-family:Khmer OS Battambang;border-bottom:1px solid; "> &nbsp;&nbsp;<b>$tel3</td>
                                </tr>     
                                <tr>                               
                                  <td style="font-size:15px; font-family:Khmer OS Battambang;text-align:center;border-right:1px solid;">ឈ្មោះ </td>
                                  <td style="width: 25%; font-size:15px; font-family:Khmer OS Battambang;border-right:1px solid;"></td>
                                  <td style="width: 25%; font-size:15px; font-family:Khmer OS Battambang;border-right:1px solid;"></td>
                                  <td style="width: 25%; font-size:15px; font-family:Khmer OS Battambang;" ></td>
                                </tr>                            
                              </table>
                              <table width="100%" style="font-size:15px; font-family:Khmer OS Battambang;">                                 
                                <tr>                               
                                  <td>អាសយដ្ឋាន <b>$address</td>
                                </tr>       
                                <tr>                               
                                  <td >បានបង់រំលស់ម៉ូតូមួយគ្រឿងម៉ាក <b>$model</td>
                                  <td>ឆ្នាំផលិត <b>$year</td>
                                </tr>     
                                 <tr>                               
                                  <td >លេខតួ <b>$frameNo</td>
                                  <td>លេខម៉ាស៊ីន <b>$engineeNo</td>
                                  <td>ពន្ធ/ស្លាកលេខ <b>$plateNo</td>
                                </tr>  
                                 <tr>                               
                                  <td >តម្លៃម៉ូតូ <b>$price</td>
                                  <td>ចំនួនទឹកប្រាក់អនុម័ត <b>$approve</td>
                                  <td>ចំនួនលុយចូលរួម <b>$deposit</td>
                                  <td>ដូចនេះនៅខ្វះ <b>$totalOwn</td>
                                </tr>                       
                              </table>
                              <div style="font-size:15px; font-family:Khmer OS Battambang;">ចំនួនលុយដែលនៅខ្វះត្រូវបង់រំសល់ជាមួយហាងម៉ូតូ ហេង សុខបញ្ញាតាមតារាងបង់ប្រាក់ខាងក្រោម៖</div><br>
                              <table width="100%" style="font-size:15px; font-family:Khmer OS Battambang;border:1px solid" class="invoice-table">  
                                <thead>
                                  <tr>
                                      <th>ល.រ</th>
                                      <th>កាលបរិច្ឆេទបង់លុយ</th>
                                      <th>ចំនួនលុយត្រូវបង់</th>
                                      <th>កំណត់សំគាល់</th>
                                  </tr>
                                </thead>
                                  <tbody>
                                    <tr>
                                        <td>1</td>
                                        <td> </td>
                                        <td> </td>
                                        <td> </td>
                                    </tr>
                                    <tr>
                                        <td>2</td>
                                        <td> </td>
                                        <td> </td>
                                        <td> </td>
                                    </tr>
                                    <tr>
                                        <td>3</td>
                                        <td> </td>
                                        <td> </td>
                                        <td> </td>
                                    </tr>
                                    <tr>
                                        <td>4</td>
                                        <td> </td>
                                        <td> </td>
                                        <td> </td>
                                    </tr>
                                    <tr>
                                        <td>5</td>
                                        <td> </td>
                                        <td> </td>
                                        <td> </td>
                                    </tr>
                                    <tr>
                                        <td>6</td>
                                        <td> </td>
                                        <td> </td>
                                        <td> </td>
                                    </tr>
                                  
                                </tbody>
                              </table>

                              <br>

                              <div>
                                <img src="http://moto.cpos.cc/payment.png" alt="" width="100%">
                              </div><br>
                              <div style="font-size:15px; font-family:Khmer OS Battambang;">ក្នុងករណីបង់យឺត អតិថិជនយល់ព្រមបង់ប្រាក់ពិន័យក្នុងថ្ងៃចំនួន</div>
                              <div style="font-size:15px; font-family:Khmer OS Battambang;">អតិថិជនបានអាន និងស្តាប់ហើយព្រមព្រៀងបង់តាមពេលវេលាដែលបានកំណត់ដូចខាងលើ។</div>
                              <br>
                              <div style="font-size:15px; font-family:Khmer OS Battambang;text-align:right">ធ្វើនៅ រាជធានីភ្នំពេញ ថ្ងៃទី <b>$leasingDay ខែ <b>$leasingMonth ឆ្នាំ <b>$leasingYear </div>
                              <br><br>
                              <table width="100%">
                                <tr>
                                  <td width="50%">
                                    <div style="font-size:15px; font-family:Khmer OS Battambang;">ឈ្មោះអតិថិជន <b>$fullName</div>
                                  </td>
                                  <td>
                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                  </td>
                                  <td>
                                    <div style="font-size:15px; font-family:Khmer OS Battambang;">ត្រាហាងម៉ូតូ</div>
                                  </td>
                                </tr>
                              </table>
                                  
                                

                      </div>
                  </div>
              </div>
              </body>
                    
    </html>
    
  ''';
}

void printPaymentTable(int id) async {
  await getByLeasing(id);
  await getByReceivable(id);
  await getByPaymentSchedule(id);

  final htmlContent = await generateHtmlContent(
    payment: schedule,
    leasingYear: byLeasing[0].leasingDate.split(' ')[0].split('-')[0],
    leasingMonth: byLeasing[0].leasingDate.split(' ')[0].split('-')[1],
    leasingDay: byLeasing[0].leasingDate.split(' ')[0].split('-')[2],
    fullName: byLeasing[0].name,
    gender: byLeasing[0].gender,
    age: byLeasing[0].age,
    idCard: byLeasing[0].idCard,
    tel1: byReceivable[0].tel1,
    tel2: byReceivable[0].tel2,
    tel3: byReceivable[0].tel3,
    address: byLeasing[0].address,
    model: byLeasing[0].model,
    year: byLeasing[0].year,
    frameNo: byLeasing[0].frameNo,
    engineeNo: byLeasing[0].engineNo,
    plateNo: byLeasing[0].plateNo,
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
