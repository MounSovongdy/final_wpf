import 'package:flutter/material.dart';

class InvoiceTamplet extends StatelessWidget {
  const InvoiceTamplet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Logo and Title Section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "HSP",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Text("Heng Sok Panha Motor Shop"),
                ],
              ),
              Row(
                children: [
                  Image.asset('assets/motorbike1.png', width: 50, height: 50),
                  const SizedBox(width: 10),
                  Image.asset('assets/motorbike2.png', width: 50, height: 50),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Contact Information
          const Row(
            children: [
              Icon(Icons.phone),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('096 711 8000'),
                  Text('097 711 8000'),
                  Text('076 711 8000'),
                ],
              )
            ],
          ),
          const SizedBox(height: 20),

          // Form Fields
          buildFormField("Invoice Number:"),
          buildFormField("Date:"),
          buildFormField("Customer Name:"),
          buildFormField("Address:"),
          buildFormField("Phone:"),
          buildFormField("Vehicle Model:"),
          buildFormField("Price:"),
          buildFormField("Amount Paid:"),

          // Signature and Stamp
          const Spacer(),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text("Customer Signature"),
                  SizedBox(height: 50),
                  Divider(color: Colors.black, thickness: 1),
                ],
              ),
              Column(
                children: [
                  Text("Store Stamp"),
                  SizedBox(height: 50),
                  Divider(color: Colors.black, thickness: 1),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget buildFormField(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Text(label, style: const TextStyle(fontSize: 16)),
          const Expanded(
            child: Divider(color: Colors.black, thickness: 1),
          ),
        ],
      ),
    );
  }
}
