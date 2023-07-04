# moneyhash_payment

### MoneyHash Flutter Support
The SDK allows you to build full payment experiences in your native Android and iOS apps using Flutter.

### Installation

dart pub add moneyhash_payment

### Requirements

## Android
* Compatible with apps targeting Android 5.0 (API level 21) and above
* Use Kotlin version 1.8.10 and above:
* Using an up-to-date [Android Gradle Plugin](https://developer.android.com/studio/releases/gradle-plugin)
* [AndroidX](https://developer.android.com/jetpack/androidx/) (as of v11.0.0)

* Enable `viewBinding` in your project.
```
 buildFeatures {
   viewBinding true
 }
```

* Change the MainActivity to extend `FlutterFragmentActivity` instead of `FlutterActivity` in `android/app/src/main/kotlin/.../MainActivity.kt`:

```kotlin
import io.flutter.embedding.android.FlutterFragmentActivity

class MainActivity:  FlutterFragmentActivity()
```


## iOS
Compatible with apps targeting iOS 11 or above.

## How to use?

- Create moneyHash instance using `MoneyHashSDKBuilder`

```dart
import 'package:moneyhash_payment/moneyhash_payment.dart';
MoneyHashSDK moneyhashSDK = MoneyHashSDKBuilder.build();
```

> MoneyHash SDK guides to for the actions required to be done, to have seamless integration through intent details `state`

| state                             | Action                                                                                                                                                                                          |
| :-------------------------------- |:------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `METHOD_SELECTION`                | Use `moneyHash.getIntentMethod` to get different intent methods and render them natively with your own styles & use `moneyHash.proceedWithMethod` to proceed with one of them on user selection |
| `INTENT_FORM`                     | Use `moneyHash.renderForm` to start the SDK flow to let MoneyHash handle the flow for you & listen for result by using IntentContract() for Activity result                                     |
| `INTENT_PROCESSED`                | Render your successful confirmation UI with the intent details                                                                                                                                  |
| `TRANSACTION_FAILED`              | Render your failure UI with the intent details                                                                                                                                                  |
| `TRANSACTION_WAITING_USER_ACTION` | Render your pending actions confirmation UI with the intent details & `externalActionMessage` if exists on `Transaction`                                                                        |
| `EXPIRED`                         | Render your intent expired UI                                                                                                                                                                   |
| `CLOSED`                          | Render your intent closed UI                                                                                                                                                                    |

- Get intent details based on the intent id and type (Payment/Payout)

```dart
try{
  var result = await moneyhashSDK.getIntentDetails(intentId, IntentType.payment);
} catch (e) {
// Handle the errors
}
```

- Get intent available payment/payout methods, saved cards and customer balances

```dart
try{
  var result = await moneyhashSDK.getIntentMethods(intentId, IntentType.payment);
} catch (e) {
// Handle the errors
}
```

- Proceed with a payment/payout method, card or wallet

```dart
    try {
    var result = await moneyhashSDK.proceedWithMethod(
              intentId,
              IntentType.payment,
              selectedMethodId,
              MethodType.customerBalance, // method type that returned from the intent methods
              MethodMetaData(// optional and can be null
                  cvv: "123", // required for customer saved cards that requires cvv
              )
       );
      } catch (e) {
        // handle the error
      }
```

- Reset the selected method on and intent to null
> Can be used for `back` button after method selection  or `retry` button on failed transaction UI to try a different method by the user.
```dart
    try {
          var result = await moneyhashSDK.resetSelectedMethod(intentId, IntentType.payment);
      } catch (e) {
          // handle the error
      }
```

- Delete a customer saved card

```dart
    try {
          await moneyhashSDK.deleteSavedCard(cardTokenId, intentSecret); // No result expected from this method success or failure
      } catch (e) {
          // handle the error
      }
```

- Render SDK embed forms and payment/payout integrations

> Must be called if `state` of an intent is `INTENT_FORM` to let MoneyHash handle the payment/payout. you can also use it directly to render the embed form for payment/payout without handling the methods selection native UI.

Add PaymentActivity / PayoutActivity to AndroidManifest.xml

```xml
<activity android:name="com.moneyhash.sdk.android.payment.PaymentActivity"
    android:theme="@style/Theme.AppCompat.Light.NoActionBar.FullScreen"/>
```

```xml
<activity android:name="com.moneyhash.sdk.android.payout.PayoutActivity"
    android:theme="@style/Theme.AppCompat.Light.NoActionBar.FullScreen"/>
```

- Start the SDK flow to let MoneyHash handle the payment/payout
```dart
    try {
          var result = await moneyhashSDK.renderForm(intentId, IntentType.payment);
      } catch (e) {
          // handle the error
      }
```

## Responses
```dart
class CustomerBalance {
  final double? balance;
  final String? id;
  final String? icon;
  final bool? isSelected;
  final MethodType? type;
}

class PaymentMethod {
  final String? id;
  final String? title;
  final bool? isSelected;
  final bool? confirmationRequired;
  final List<String>? icons;
  final MethodType? type;
}

class PayoutMethod {
  final String? id;
  final String? title;
  final bool? isSelected;
  final bool? confirmationRequired;
  final List<String>? icons;
  final MethodType? type;
}

class ExpressMethod {
  final String? id;
  final String? title;
  final bool? isSelected;
  final bool? confirmationRequired;
  final List<String>? icons;
  final MethodType? type;
}

class SavedCard {
  final String? id;
  final String? brand;
  final String? last4;
  final String? expiryMonth;
  final String? expiryYear;
  final String? country;
  final String? logo;
  final bool? requireCvv;
  final CvvConfig? cvvConfig;
  final MethodType? type;
}

class CvvConfig {
  final int? digitsCount;
}

class IntentMethods {
  final List<CustomerBalance>? customerBalances;
  final List<PaymentMethod>? paymentMethods;
  final List<ExpressMethod>? expressMethods;
  final List<SavedCard>? savedCards;
  final List<PayoutMethod>? payoutMethods;
}

enum MethodType {
  expressMethod,
  customerBalance,
  savedCard,
  paymentMethod,
  payoutMethod,
}

class IntentDetails {
  final String? selectedMethod;
  final IntentData? intent;
  final double? walletBalance;
  final TransactionData? transaction;
  final RedirectData? redirect;
  final IntentState? state;
}

class TransactionData {
  final String? billingData;
  final double? amount;
  final List<String>? externalActionMessage;
  final String? amountCurrency;
  final String? id;
  final String? methodName;
  final String? method;
  final String? createdDate;
  final String? status;
  final String? customFields;
  final String? providerTransactionFields;
  final String? customFormAnswers;
}

class IntentData {
  final AmountData? amount;
  final String? secret;
  final String? expirationDate;
  final bool? isLive;
  final String? id;
  final IntentStatus? status;
}

class AmountData {
  final String? value;
  final double? formatted;
  final String? currency;
  final double? maxPayout;
}

class RedirectData {
  final String? redirectUrl;
}

class IntentResult {
  final IntentMethods? methods;
  final IntentDetails? details;
}

enum IntentType {
  payment,
  payout
}

class MethodMetaData {
  final String? cvv;
}

enum IntentStatus {
  processed,
  unProcessed,
  timeExpired,
  closed,
}

enum IntentState {
  methodSelection,
  intentForm,
  intentProcessed,
  transactionWaitingUserAction,
  transactionFailed,
  expired,
  closed,
}

```


### Questions and Issues

Please provide any feedback via a [GitHub Issue](https://github.com/MoneyHash/moneyhash-flutter-example/issues/new?template=bug_report.md).