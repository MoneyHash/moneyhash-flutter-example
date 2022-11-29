import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  MoneyHashPaymentResult? _result;
  TextEditingController? paymentIdTextEditController = TextEditingController();
  String? errorText;

  @override
  void initState() {
    super.initState();
  }

  Future<void> initPlatformState() async {
    MoneyHashPaymentResult? result;
    try {
      result = await MoneyhashPayment.startPaymentFlow(
          paymentIdTextEditController!.text);
    } on PlatformException {}

    if (!mounted) return;

    setState(() {
      _result = result;
    });
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
                  if (_result != null)
                    Column(
                      children: [
                        const SizedBox(height: 32),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Payment Status  :  ',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w500),
                            ),
                            Expanded(
                              child: Text(
                                  '${_result?.status ?? "no payment status"}\n'),
                            )
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Payment Extra Actions  :  ',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w500),
                            ),
                            Expanded(
                                child: _result?.extraActions != null &&
                                        _result?.extraActions != ""
                                    ? Text('${_result?.extraActions}')
                                    : const Text("no payment extra actions"))
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Payment Result ID :  ',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w500),
                            ),
                            Expanded(
                                child: Text(
                                    '${_result?.result?.intent?.id ?? "no payment result id"}\n')),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Payment Result Amount :  ',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w500),
                            ),
                            Expanded(
                                child: Text(
                                    '${_result?.result?.intent?.amountValue ?? "no payment result amount"}\n')),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Payment Result Selected Method :  ',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w500),
                            ),
                            Expanded(
                                child: Text(
                                    '${_result?.result?.intent?.selectedMethod ?? "no payment result selected method"}\n')),
                          ],
                        ),
                      ],
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
