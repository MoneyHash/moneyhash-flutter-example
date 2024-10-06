### MoneyHash V2 Flutter SDK

The MoneyHash Flutter SDK allows developers to integrate MoneyHash payment processing into their web applications. The SDK provides a simple and convenient way to accept customer payments, manage subscriptions, and send payouts.

Get started with our 📚 [integration guides](https://docs.moneyhash.io/docs/flutter-sdk) and [example projects](https://github.com/MoneyHash/moneyhash-flutter-example)

Upgrading to a new version of the SDK? Check out our [migration guide](https://docs.moneyhash.io/docs/migration-guide-upgrading-from-moneyhash-sdk-for-flutter-version-20-to-21) and [changelog](https://pub.dev/packages/moneyhash_payment/changelog).

#### Releases

Check out the [changelog](https://pub.dev/packages/moneyhash_payment/changelog) to view a summary of changes for each release. For instructions on how to upgrade from older versions of the SDK, refer to the [migration guide](https://docs.moneyhash.io/docs/migration-guide-upgrading-from-moneyhash-sdk-for-flutter-version-20-to-21).


##### Installation

Follow these steps to install the SDK in your Flutter project.

```bash
flutter pub add moneyhash_payment
```

This will add a line like this to your package's pubspec.yaml with the package including the latest version:

```bash
dependencies:
moneyhash_payment: ^{{latest_version}}
```

###### Import it

Now in your Dart code, you can use:

```dart
import 'package:moneyhash_payment/moneyhash_payment.dart';
```