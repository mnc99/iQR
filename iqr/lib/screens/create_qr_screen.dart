import 'package:flutter/material.dart';
import 'package:iqr/screens/screens.dart';
import 'package:iqr/themes/iqr_themes.dart';
import 'package:qr_flutter/qr_flutter.dart';

class CreateQRScreen extends StatefulWidget {
  const CreateQRScreen({Key? key}) : super(key: key);

  @override
  State<CreateQRScreen> createState() => _CreateQRScreenState();
}

class _CreateQRScreenState extends State<CreateQRScreen> {

  // Controller for the textfield
  final TextEditingController _controller = TextEditingController();

  // Save QR Code as image
  // void takeScreenShot() async {
  //   PermissionStatus res;
  //   res = await Permission.storage.request();
  //   if (res.isGranted) {
  //     final boundary =
  //         qrKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
  //     // We can increse the size of QR using pixel ratio
  //     final image = await boundary.toImage(pixelRatio: 5.0); 
  //     final byteData = await (image.toByteData(format: ui.ImageByteFormat.png));
  //     if (byteData != null) {
  //       final pngBytes = byteData.buffer.asUint8List();
  //       // getting directory of our phone
  //       final directory = (await getApplicationDocumentsDirectory()).path; 
  //       final imgFile = File(
  //         '$directory/${DateTime.now()}${qr}.png',
  //       );
  //       imgFile.writeAsBytes(pngBytes);
  //       GallerySaver.saveImage(imgFile.path).then((success) async {
  //         //In here you can show snackbar or do something in the backend at successfull download
  //       });
  //     }
  //   }
  // }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              QrImage(
                data: _controller.text,
                foregroundColor: AppThemes.accentColor,
              ),
              const SizedBox(height: 20.0,),
              buildTextField()
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