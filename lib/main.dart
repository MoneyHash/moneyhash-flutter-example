import 'package:flutter/material.dart';
import 'package:moneyhash_payment/data/card/card_field_type.dart';
import 'package:moneyhash_payment/data/intent_methods.dart';
import 'package:moneyhash_payment/data/intent_type.dart';
import 'package:moneyhash_payment/data/methods/get_methods_params.dart';
import 'package:moneyhash_payment/log/log_level.dart';
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
  CardForm? _cardForm;
  String intentId = "Your intent id";

  MoneyHashSDK moneyHashSDK = MoneyHashSDKBuilder.build();

  @override
  void initState() {
    moneyHashSDK.setLogLevel(LogLevel.debug);
    _cardForm = CardFormBuilder().setCardHolderNameField((state) {
      print("CardHolderName: ${state?.isValid}");
      print("CardHolderName: ${state?.errorMessage}");
    }).setCardNumberField((state) {
      print("CardNumber: ${state?.isValid}");
      print("CardNumber: ${state?.errorMessage}");
    }).setCVVField((state) {
      print("CVV: ${state?.isValid}");
      print("CVV: ${state?.errorMessage}");
    }).setExpiryMonthField((state) {
      print("ExpireMonth: ${state?.isValid}");
      print("ExpireMonth: ${state?.errorMessage}");
    }).setExpiryYearField((state) {
      print("ExpireYear: ${state?.isValid}");
      print("ExpireYear: ${state?.errorMessage}");
    }).setCardBrandChangeListener((cardBrand) {
      print("CardBrand: ${cardBrand?.brand}");
      print("CardBrand: ${cardBrand?.brandIconUrl}");
      print("CardBrand: ${cardBrand?.first6Digits}");
    }).build();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Testing card"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SecureTextField(
              label: "cardNumber",
              placeholder: "cardNumber",
              cardForm: _cardForm!,
              type: CardFieldType.cardNumber,
            ),
            const SizedBox(height: 16),
            SecureTextField(
              label: "cvv",
              placeholder: "cvv",
              cardForm: _cardForm!,
              type: CardFieldType.cvv,
            ),
            const SizedBox(height: 16),
            SecureTextField(
              label: "expireMonth",
              placeholder: "expireMonth",
              cardForm: _cardForm!,
              type: CardFieldType.expiryMonth,
            ),
            const SizedBox(height: 16),
            SecureTextField(
              label: "cardHolderName",
              placeholder: "cardHolderName",
              cardForm: _cardForm!,
              type: CardFieldType.cardHolderName,
            ),
            SecureTextField(
              label: "expireYear",
              placeholder: "expireYear",
              cardForm: _cardForm!,
              type: CardFieldType.expiryYear,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
                onPressed: () async {
                  moneyHashSDK.setPublicKey("Your public key");
                  var intentMethods = await moneyHashSDK.getMethods(GetMethodsParams.withIntent(intentId, IntentType.payment));
                  print("Methods: $intentMethods");
                  //
                  var accountMethods = await moneyHashSDK.getMethods(
                      GetMethodsParams.withCurrency(currency: "USD", customer: "8fa8912f-e321-4899-8759-b8136fe95523", flowId: null, amount: null)
                  );
                  print("Methods: $accountMethods");


                  var intentDetails = await moneyHashSDK.getIntentDetails(intentId, IntentType.payment);
                  var intentAmount = intentDetails.intent?.amount;
                  print("intentAmount: $intentAmount");

                  var collectResult = await _cardForm?.collect();
                  print("CollectResult: ${collectResult?.cardHolderName}");
                  print("CollectResult: ${collectResult?.expiryMonth}");


                  // Set the intent method to Card before proceeding to payment
                  await moneyHashSDK.proceedWithMethod(intentId, IntentType.payment, "CARD", MethodType.paymentMethod, null);

                  var payResult = await _cardForm?.pay(
                    intentId,
                    collectResult!,
                    true,
                    null,
                    null,
                  );
                  print("PayResult: ${payResult?.transaction?.amount}");
                  print("PayResult: ${payResult?.transaction?.amountCurrency}");

                  var cardTokenResult = await _cardForm?.createCardToken("CardIntentId", collectResult!);
                  print("Card Token Result: $cardTokenResult");
                },
                child: const Text("Submit"))
          ],
        ),
      ),
    );
  }
}
