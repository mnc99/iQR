import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_qr_reader/flutter_qr_reader.dart';
import 'package:iqr/screens/screens.dart';
import 'package:iqr/themes/iqr_themes.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScanQRScreen extends StatefulWidget {
  const ScanQRScreen({Key? key}) : super(key: key);

  @override
  State<ScanQRScreen> createState() => _ScanQRScreenState();
}

class _ScanQRScreenState extends State<ScanQRScreen> {

  // Key to indentify the QR Scanner widget
  final _qrKey = GlobalKey(debugLabel: 'qr_scanner');
  // Controller of the QR Scanner
  QRViewController? _controller;
  // QR Code info
  Barcode? barcode;

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Future<void> reassemble() async {
    super.reassemble();
    
    if (defaultTargetPlatform == TargetPlatform.android) {
      await _controller!.pauseCamera();
    }

    _controller?.resumeCamera();
  }
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          alignment: Alignment.center,
          children: [
            buildQrScanner(context),
            Positioned(bottom: 20.0, child: buildData())
          ],
        )
      ),
    );
  }

  Widget buildData() {
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.white24,
        borderRadius: BorderRadius.circular(30.0)
      ),
      child: Text(barcode != null ? 'Result: ${barcode!.code}' : 'Scan a code!', maxLines: 3,));
  }

  Widget buildQrScanner(BuildContext context) {
    void onQRViewCreated(QRViewController controller) {
      setState(() => _controller = controller); 
        // Get the date from the QR code
      _controller?.scannedDataStream.listen((barcode) { setState(() => this.barcode = barcode); });
      
    }

    return QRView(
      key: _qrKey,
      onQRViewCreated: onQRViewCreated,
      overlay: QrScannerOverlayShape(
        borderWidth: 8.0,
        borderColor: AppThemes.accentColor,
        borderRadius: 30.0,
        cutOutSize: MediaQuery.of(context).size.width*0.8
      ),
    );

    
  }
}

