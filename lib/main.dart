
import 'package:flutter/material.dart';
import 'package:moneyhash_payment/data/card/card_field_type.dart';
import 'package:moneyhash_payment/data/tokenize_card_info.dart';
import 'package:moneyhash_payment/data/vault_data.dart';
import 'package:moneyhash_payment/vault/card_collector.dart';
import 'package:moneyhash_payment/vault/widget/secure_text_field.dart';
import 'package:moneyhash_payment/vault/card_form_builder.dart';
import 'package:moneyhash_payment/moneyhash_payment.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  CardCollector? _cardCollector;
  String intentId = "LPMzr1g";
  String accessToken = "eyJhbGciOiJFUzI1NksiLCJ0eXAiOiJKV1QifQ.eyJleHAiOjE3MjQwMzQwNTF9.cQFf20PKO0IElvzn3mzBvpdWnRfz0DoKkmcpq-xwhvM_TMkyYt4uKo03N3T02xRnFgJzZrcuoN1AQFXK5whmOg";

  MoneyHashSDK moneyHashSDK = MoneyHashSDKBuilder.build();


  @override
  void initState() {
    _cardCollector = CardFormBuilder()
        .setCardHolderNameField((state) {
      print("CardHolderName: ${state?.isValid}");
      print("CardHolderName: ${state?.errorMessage}");
    })
        .setCardNumberField((state) {
      print("CardNumber: ${state?.isValid}");
      print("CardNumber: ${state?.errorMessage}");
    })
        .setCVVField((state) {
      print("CVV: ${state?.isValid}");
      print("CVV: ${state?.errorMessage}");
    })
        .setExpiryMonthField((state) {
      print("ExpireMonth: ${state?.isValid}");
      print("ExpireMonth: ${state?.errorMessage}");
    })
        .setExpiryYearField((state) {
      print("ExpireYear: ${state?.isValid}");
      print("ExpireYear: ${state?.errorMessage}");
    })
        .setTokenizeCardInfo(TokenizeCardInfo(
        accessToken: accessToken,
        isLive: true,
        saveCard: true,
        saveCardCheckbox: SaveCardCheckbox()))
        .build();


    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("MoneyHash Flutter Example"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SecureTextField(
              label: "cardNumber",
              placeholder: "cardNumber",
              cardFormCollector: _cardCollector!,
              type: CardFieldType.cardNumber,
            ),
            const SizedBox(height: 16),
            SecureTextField(
              label: "cvv",
              placeholder: "cvv",
              cardFormCollector: _cardCollector!,
              type: CardFieldType.cvv,
            ),
            const SizedBox(height: 16),
            SecureTextField(
              label: "expireMonth",
              placeholder: "expireMonth",
              cardFormCollector: _cardCollector!,
              type: CardFieldType.expiryMonth,
            ),
            const SizedBox(height: 16),
            SecureTextField(
              label: "cardHolderName",
              placeholder: "cardHolderName",
              cardFormCollector: _cardCollector!,
              type: CardFieldType.cardHolderName,
            ),
            SecureTextField(
              label: "expireYear",
              placeholder: "expireYear",
              cardFormCollector: _cardCollector!,
              type: CardFieldType.expiryYear,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
                onPressed: () async {
                  bool? isValid = await _cardCollector?.isValid();
                  print("isValid: $isValid");
                  VaultData? result = await _cardCollector?.collect(intentId);
                  print("_cardFormCollector collect expiryYear: ${result?.expiryYear}");
                  print("_cardFormCollector collect expiryMonth: ${result?.expiryMonth}");
                  print("_cardFormCollector collect cardHolderName: ${result?.cardHolderName}");
                  print("_cardFormCollector collect cardScheme: ${result?.cardScheme}");
                },
                child: const Text("Submit"))
          ],
        ),
      ),
    );
  }
}
