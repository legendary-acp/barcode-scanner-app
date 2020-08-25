import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() => (runApp(MaterialApp(
      home: Cam(),
    )));

class Cam extends StatefulWidget {
  @override
  _CamState createState() => _CamState();
}

class _CamState extends State<Cam> {
  String barcodeNum = '';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              barcodeNum == ''
                  ? Container()
                  : Text('Barcode Number: $barcodeNum'),
              RaisedButton(
                child: Container(
                  width: 150,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.camera_enhance),
                      Text(barcodeNum == '' ? 'Scan Barcode' : 'Scan Another'),
                    ],
                  ),
                ),
                onPressed: () async {
                  var result = await BarcodeScanner.scan();
                  if (result.type == 'failed') {
                    Fluttertoast.showToast(
                        msg: "Failed to scan",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0);
                    setState(() {
                      barcodeNum = '';
                    });
                  }
                  setState(() {
                    barcodeNum = result.rawContent;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
