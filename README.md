### MoneyHash Flutter Support
The SDK allows you to build full payment experiences in your native Android and iOS apps using Flutter.

### Installation

dart pub add moneyhash_payment

## Requirements
### Android
* Compatible with apps targeting Android 5.0 (API level 21) and above
* Use Kotlin version 1.6.10 and above
* Using an up-to-date [Android Gradle Plugin](https://developer.android.com/studio/releases/gradle-plugin)
* [AndroidX](https://developer.android.com/jetpack/androidx/) (as of v11.0.0)

Enable `databinding` in your project.

```
dataBinding {
  enabled = true
}
```

### iOS
Compatible with apps targeting iOS 11 or above.

## Create a Payment Intent
You will need to create a Payment Intent and use it's ID to initiate the SDK, There are two ways to create a Payment Intent:

- **Using The Sandbox**

  Which is helpful to manually and quickly create a Payment Intent without having to running any backend code. For more information about the Sandbox refer to this [section](https://moneyhash.github.io/sandbox)
- **Using The Payment Intent API**

  This will be the way your backend server will eventually use to create a Payment Intents, for more information refer to this [section](https://moneyhash.github.io/api)

### Usage Example

To start the payment flow use the Payment Intent ID from the step above as a parameter along with a PaymentResultContract instance like below:

1- Add PaymentActivity to AndroidManifest.xml
```xml
<activity android:name="com.moneyhash.sdk.android.payment.PaymentActivity"
android:theme="@style/Theme.AppCompat.Light.NoActionBar.FullScreen"/>
```
2-

#### startPaymentFlow
```dart
import 'package:moneyhash_payment/moneyhash_payment.dart';

    MoneyHashPaymentResult? result;

    try {
      result = await MoneyhashPayment.startPaymentFlow("YourPaymentIntentIdHere");
    } on PlatformException {
      // Handle the errors
    }

```

#### startPayoutFlow

1- Add PaymentActivity to AndroidManifest.xml
```xml
<activity android:name="com.moneyhash.sdk.android.payout.PayoutActivity"
android:theme="@style/Theme.AppCompat.Light.NoActionBar.FullScreen"/>
```
2-

```dart
import 'package:moneyhash_payment/moneyhash_payment.dart';

    MoneyHashPayoutResult? result;

    try {
      result = await MoneyhashPayment.startPayoutFlow("YourPayoutIntentIdHere");
    } on PlatformException {
      // Handle the errors
    }
```

### Payment Statuses
Once your customer finishes adding the payment information they will reach one of the following statuses, and  a callback is fired with the payment status which indicate the current status of your payment.

| Status             | #                                                                                                                                                                                                                                      |
|--------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Error              | There was an error while processing the payment and more details about the errors will be found inside errors data.                                                                                                                    |
| Success            | The payment is Successful.                                                                                                                                                                                                             |
| RequireExtraAction | That payment flow is done and the customer needs to do some extra actions off the system, a list of the actions required by the customer will be found inside the actions data, and it should be rendered to the customer in your app. |
| Failed             | There was an error while processing the payment.                                                                                                                                                                                       |
| Unknown            | There was an unknown state received and this should be checked from your MoneyHash dashboard.                                                                                                                                          |
| Cancelled          | The customer cancelled the payment flow by clicking back or cancel.                                                                                                                                                                    |
| Redirect           | That payment flow is done and the customer needs to be redirect to `redirectUrl`.                                                                                                                                                      |

### MoneyHashPaymentResult

```dart
class MoneyHashPaymentResult {
  final String status; // Payment Status
  final String? errors; // errors if any (incase of status = "error")
  final String? extraActions; // list of extra actions required (incase of status = "require_extra_action")
  final String? redirectUrl; // link needs to be redirect to  (in case of status = "redirect")
  final PaymentResult? result; // the payment details (in case of status = "success" || status = "redirect" ||status = "require_extra_action" || status = "failed")
}

class PaymentResult {
  final PaymentIntent? intent;
  final PaymentTransaction? transaction;
}

```
### MoneyHashPayoutResult

```dart
class MoneyHashPayoutResult {
  final String status; // Payout Status
  final String? errors; // errors if any (incase of status = "error")
  final String? extraActions; // list of extra actions required (incase of status = "require_extra_action")
  final String? redirectUrl; // link needs to be redirect to  (in case of status = "redirect")
  final PayoutResult? result; // the payout details (in case of status = "success" || status = "redirect" || status = "require_extra_action" || status = "failed")
}

class PayoutResult {
  final PayoutIntent? intent;
  final PayoutTransaction? transaction;
}
```


### Questions and Issues

Please provide any feedback via a [GitHub Issue](https://github.com/MoneyHash/moneyhash-flutter-example/issues/new?template=bug_report.md).