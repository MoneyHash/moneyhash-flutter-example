import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:moneyhash_payment/data/intent_type.dart';
import 'package:moneyhash_payment/data/intent_detais.dart';
import 'package:moneyhash_payment/moneyhash_payment.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var moneyhashSDK = MoneyHashSDKBuilder.build();
  IntentDetails? _result = null;

  TextEditingController? paymentIdTextEditController = TextEditingController();
  String? errorText;

  @override
  void initState() {
    super.initState();
  }

  Future<void> initPlatformState() async {
    try {
      await moneyhashSDK.renderForm(
          paymentIdTextEditController!.text, IntentType.payment);
    } on PlatformException {}

    if (!mounted) return;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('MoneyHash Example'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    onChanged: (value) {
                      setState(() {
                        errorText = null;
                      });
                    },
                    controller: paymentIdTextEditController,
                    decoration: InputDecoration(
                        labelText: "Payment id",
                        errorText: errorText,
                        border: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10)))),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    width: double.maxFinite,
                    child: ElevatedButton(
                      onPressed: () {
                        if (paymentIdTextEditController!.text.isNotEmpty) {
                          initPlatformState();
                        } else {
                          setState(() {
                            errorText = "Please enter payment id";
                          });
                        }
                      },
                      child: const Text("Checkout"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
