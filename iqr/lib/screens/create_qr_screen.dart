import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:iqr/screens/screens.dart';
import 'package:iqr/themes/iqr_themes.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_flutter/qr_flutter.dart';

class CreateQRScreen extends StatefulWidget {
  const CreateQRScreen({Key? key}) : super(key: key);

  @override
  State<CreateQRScreen> createState() => _CreateQRScreenState();
}

// Types of QR Codes formats
enum QRType { text, url, email, phone, sms, wifi, location, contact }

// WIFI QR Code
// WIFI:S:<SSID>;T:<WPA|WEP|>;P:<password>;;

// Geo Location QR Code
// GEO:<latitude>,<longitude>

// Contact QR Code
// BEGIN:VCARD
// VERSION:3.0
// N:<Last Name>;<First Name>;;;
// FN:<First Name> <Last Name>
// TEL;TYPE=CELL:<Phone Number>
// EMAIL:<Email Address>
// END:VCARD

// URL QR Code
// https://www.google.com

class _CreateQRScreenState extends State<CreateQRScreen> {

  // Controller for the textfield
  final TextEditingController _controller = TextEditingController();
  final qrKey = GlobalKey();

  // Save QR Code as image
  void takeScreenShot() async {
    PermissionStatus res;
    // Ask for permission to save the image into gallery
    res = await Permission.storage.request();
    if (res.isGranted) {
      final boundary =
          qrKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      // We can increse the size of QR using pixel ratio
      final image = await boundary.toImage(pixelRatio: 5.0); 
      final byteData = await (image.toByteData(format: ui.ImageByteFormat.png));
      if (byteData != null) {
        final pngBytes = byteData.buffer.asUint8List();
        // getting directory of our phone
        final directory = (await getApplicationDocumentsDirectory()).path; 
        final imgFile = File(
          '$directory/${DateTime.now()}${_controller.text}.png',
        );
        imgFile.writeAsBytes(pngBytes);
        GallerySaver.saveImage(imgFile.path).then((success) async {
          //In here you can show snackbar or do something in the backend at successfull download
        });
      }
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RepaintBoundary(
                key: qrKey,
                child: QrImage(
                  data: _controller.text,
                  foregroundColor: AppThemes.accentColor,
                ),
              ),
              const SizedBox(height: 20.0,),
              buildTextField(),
              const SizedBox(height: 20.0,),
              ElevatedButton(
                onPressed: () {
                  // Save QR Code as image if the textfield is not empty
                  if (_controller.text.isNotEmpty) {
                    takeScreenShot();
                  }
                  else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please enter some data to generate QR'),
                        backgroundColor: AppThemes.accentColor,
                      )
                    );
                  }
                },
                child: const Text('Save QR', style: TextStyle(fontSize: 20.0))
              )
            ]
          )
        )
      ),
    );
  }

  // Input field for the text to be encoded
  Widget buildTextField() {
    return TextField(
      controller: _controller,
      keyboardType: TextInputType.text,
      cursorColor: AppThemes.accentColor,
      decoration: InputDecoration(
        hintText: "Enter some data",
        suffixIcon: IconButton(
          icon: const Icon(Icons.check_rounded, color: AppThemes.accentColor),
          onPressed: () => setState(() {},)
        ),
      ),
    );
  }
}