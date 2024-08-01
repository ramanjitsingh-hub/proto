import 'package:flutter/material.dart';
import 'package:proto/product_info.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';

class CustomerScreen extends StatefulWidget {
  @override
  State<CustomerScreen> createState() => _CustomerScreenState();
}

class _CustomerScreenState extends State<CustomerScreen> {
  String result = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Customer Screen'),
      ),
      body: Center(
        child: Text(
          'Scan a QR to start',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.camera),
          onPressed: () async {
            // Navigate to QR code page
            var res = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SimpleBarcodeScannerPage(),
                ));

            setState(
              () {
                if (res is String) {
                  result = res;
                  print(result);
                }
              },
            );
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return ProductInfoPage(
                productId:'txIBQCWEsgujceBNuReA',
              );
            }));
          }),
    );
  }
}

class QRCodePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Replace this with your QR code scanning logic
    // Once the QR code is scanned, you can show the details in the center
    String scannedDetails = 'Scanned details';

    return Scaffold(
      appBar: AppBar(
        title: Text('QR Code Page'),
      ),
      body: Center(
        child: Text(
          scannedDetails,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
      ),
    );
  }
}
