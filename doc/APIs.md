

# MoneyHash SDK API Documentation

The MoneyHash SDK for Flutter offers a comprehensive suite of APIs for managing payment intents, handling various payment methods, and processing transactions. The following documentation details the available methods within the `MoneyHashSDK` class.

---

### API Methods of MoneyHashSDK

#### 1. Render MoneyHash Embed Form

```dart
Future<IntentDetails?> renderForm(
    String intentId,
    IntentType intentType,
    EmbedStyle? embedStyle,
)
```

- **Purpose**: Renders the MoneyHash embed form within the Flutter application.
- **Parameters**:
    - `intentId`: The unique identifier of the intent.
    - `intentType`: The type of the intent (`IntentType`), either payment or payout.
    - `embedStyle`: Optional styling configuration for the embed form.
- **Returns**: `IntentDetails` if successful, `null` otherwise.
- **Throws**: An `MHException` if something went wrong while rendering the intent.
- **Example**:

```dart
try {
    var intentDetails = await moneyHashSDK.renderForm(
        "current intent id",
        IntentType.payment,
        null,  // Optional EmbedStyle
    );
    print("Form rendered with details: $intentDetails");
} catch (e) {
    print("Failed to render form: $e");
}
```

---

#### 2. Retrieve Available Methods

```dart
Future<IntentMethods> getIntentMethods(String intentId, IntentType intentType)
```

- **Purpose**: Retrieves available payment methods for a specified intent.
- **Parameters**:
    - `intentId`: The unique identifier of the intent.
    - `intentType`: The type of the intent (`IntentType`), either payment or payout.
- **Returns**: `IntentMethods` containing available methods.
- **Throws**: An `MHException` if failed to retrieve the methods.
- **Example**:

```dart
try {
    var methods = await moneyHashSDK.getIntentMethods("Z1ED7zZ", IntentType.payment);
    print("Available methods: $methods");
} catch (e) {
    print("Error retrieving methods: $e");
}
```

---

#### 3. Retrieve Intent Details

```dart
Future<IntentDetails> getIntentDetails(String intentId, IntentType intentType)
```

- **Purpose**: Retrieves the details of a specified intent.
- **Parameters**:
    - `intentId`: The unique identifier of the intent.
    - `intentType`: The type of the intent (`IntentType`), either payment or payout.
- **Returns**: `IntentDetails`.
- **Throws**: An `MHException` if failed to retrieve the intent details.
- **Example**:

```dart
try {
    var intentDetails = await moneyHashSDK.getIntentDetails("Z1ED7zZ", IntentType.payment);
    print("Intent details: $intentDetails");
} catch (e) {
    print("Error retrieving intent details: $e");
}
```

---

#### 4. Delete a Saved Card

```dart
Future<void> deleteSavedCard(String cardTokenId, String intentSecret)
```

- **Purpose**: Deletes a saved card using its token ID and associated intent secret.
- **Parameters**:
    - `cardTokenId`: The token ID of the card to be deleted.
    - `intentSecret`: The secret associated with the intent.
- **Throws**: An `MHException` if failed to to delete the card.
- **Example**:

```dart
try {
    await moneyHashSDK.deleteSavedCard("card_token_123", "secret_456");
    print("Card deleted successfully");
} catch (e) {
    print("Error deleting card: $e");
}
```

---

#### 5. Reset Selected Method

```dart
Future<IntentResult> resetSelectedMethod(String intentId, IntentType intentType)
```

- **Purpose**: Resets the selected payment or payout method for a specified intent.
- **Parameters**:
    - `intentId`: The unique identifier of the intent.
    - `intentType`: The type of the intent (`IntentType`), either payment or payout.
- **Returns**: `IntentResult` with the reset result.
- **Throws**: An `MHException` if failed to to reset the selected method.
- **Example**:

```dart
try {
    var result = await moneyHashSDK.resetSelectedMethod("Z1ED7zZ", IntentType.payment);
    print("Method reset successfully: $result");
} catch (e) {
    print("Error resetting method: $e");
}
```

---

#### 6. Proceed with Selected Method

```dart
Future<IntentResult> proceedWithMethod(
    String intentId,
    IntentType intentType,
    String selectedMethodId,
    MethodType methodType,
    MethodMetaData? methodMetaData
)
```

- **Purpose**: Proceeds with the selected payment or payout method for a given intent.
- **Parameters**:
    - `intentId`: The unique identifier of the intent.
    - `intentType`: The type of the intent (`IntentType`), either payment or payout.
    - `selectedMethodId`: The ID of the selected method.
    - `methodType`: The type of the method (`MethodType`).
    - `methodMetaData`: Optional metadata related to the method.
- **Returns**: `IntentResult` encapsulating the result of the method selection.
- **Throws**: An `MHException` if failed to to proceed with the selected method.
- **Example**:

```dart
try {
    var result = await moneyHashSDK.proceedWithMethod(
        "Z1ED7zZ",
        IntentType.payment,
        "method_123",
        MethodType.paymentMethod,
        null  // Optional metadata
    );
    print("Proceeded with method: $result");
} catch (e) {
    print("Error proceeding with method: $e");
}
```

---

#### 7. Submit Form

```dart
Future<IntentDetails?> submitForm(
    String intentId,
    String selectedMethodId,
    Map<String, String> billingData,
    Map<String, String> shippingData,
    VaultData cardData
)
```

- **Purpose**: Submits a form with selected method and optional billing and shipping data.
- **Parameters**:
    - `intentId`: The unique identifier of the intent.
    - `selectedMethodId`: The ID of the selected payment method.
    - `billingData`: Optional billing details.
    - `shippingData`: Optional shipping details.
    - `cardData`: Data from card tokenization (if applicable).
- **Returns**: `IntentDetails` if successful, `null` otherwise.
- **Throws**: An `MHException` if failed to to submit the form data.
- **Example**:

```dart
try {
    var intentDetails = await moneyHashSDK.submitForm(
        "Z1ED7zZ",
        "selectedMethod",
        {"address": "123 Main St", "city": "New York"},
        {"address": "456 Elm St", "city": "Boston"},
        VaultData()  // Assuming VaultData is properly initialized
    );
    print("Form submitted successfully: $intentDetails");
} catch (e) {
    print("Error submitting form: $e");
}
```

---

#### 8. Submit Card CVV

```dart
Future<IntentDetails?> submitCardCVV(String intentId, String cvv)
```

- **Purpose**: Submits the CVV for a card associated with a specified intent.
- **Parameters**:
    - `intentId`: The unique identifier of the intent.
    - `cvv`: The CVV of the card.
- **Returns**: `IntentDetails` if successful, `null` otherwise.
- **Throws**: An `MHException` if failed to to submit the cvv.
- **Example**:

```dart
try {
    var intentDetails = await moneyHashSDK.submitCardCVV("Z1ED7zZ", "123");
    print("CVV submitted successfully: $intentDetails");
} catch (e) {
    print("Error submitting CVV: $e");
}
```

---

#### 9. Set Logging Level

```dart
void setLogLevel(LogLevel logLevel)
```

- **Purpose**: Sets the logging level for the SDK.
- **Parameters**:
    - `logLevel`: The desired logging level.
- **Example**:

```dart
moneyHashSDK.setLogLevel(LogLevel.debug);
print("Log level set to debug");
```

---

#### 10. Submit Payment Receipt

```dart
Future<IntentDetails?> submitPaymentReceipt(String intentId, String data)
```

- **Purpose**: Submits a payment receipt for a specified intent.
- **Parameters**:
    - `intentId`: The unique identifier of the payment intent.
    - `data`: The receipt data to be submitted.
- **Returns**: `IntentDetails` if successful, `null` otherwise.
- **Throws**: An `MHException` if failed to to submit the receipt.
- **Example**:

```dart
try {
    var intentDetails = await moneyHashSDK.submitPaymentReceipt("Z1ED7zZ", "receipt_data_string");
    print("Receipt submitted successfully: $intentDetails");
} catch (e) {
    print("Error submitting receipt: $e");
}
```

---

#### 11. Proceed with Apple Pay

> [!IMPORTANT]  
> This method is only available on iOS.

```dart
Future<IntentDetails?> proceedWithApplePay(
    String intentId,
    double depositAmount,
    String merchantIdentifier,
    String currencyCode,
    String countryCode
)
```

- **Purpose**: Initiates an Apple Pay transaction.
- **Parameters**:
    - `intentId`: The unique identifier of the intent.
    - `depositAmount`: The amount to be paid.
    - `merchantIdentifier`: A unique identifier for the merchant.
    - `currencyCode`: The currency code of the transaction (e.g., "USD").
    - `countryCode`: The country code associated with the transaction (e.g., "US").
- **Returns**: `IntentDetails` if successful, error with details if otherwise.
- **Throws**: An `MHException` if failed to to proceed with ApplePay.
- **Example**:

```dart
try {
    var intentDetails = await moneyHashSDK.proceedWithApplePay(
        "intent id here",
        99.99,
        "merchant.com.example",
        "USD",
        "US

"
    );
    print("Apple Pay transaction initiated: $intentDetails");
} catch (e) {
    print("Error initiating Apple Pay transaction: $e");
}
```

#### 12. is Device compatible with Apple Pay

> [!IMPORTANT]  
> This method is only available on iOS.

```dart
Future<bool> isDeviceCompatibleWithApplePay()
```

- **Purpose**: Checks if the current device is compatible with Apple Pay.
- **Returns**: A `bool` indicating whether the device supports Apple Pay (true if compatible, false otherwise).
- **Example**:

```dart
    var isCompatible = await moneyHashSDK.isDeviceCompatibleWithApplePay();
    print("Device is compatible with Apple Pay: $isCompatible");
```

#### 13. Set Locale

```dart
void setLocale(Language locale)
```
- **Purpose**: Sets the locale for the SDK.
- **Parameters**
  - `locale`: The Language object representing the locale to be set.

#### 14. Update Fees

```dart
Future<FeesData?> updateFees(
String intentId,
List<FeeItem> fees
)
```
- **Purpose**: Updates the fees associated with a specified intent.
- **Parameters**
  - `intentId`: The unique identifier of the intent.
  - `fees`: A list of `FeeItem` objects representing the fees to be updated.

- **Returns**: `FeesData` if successful
- **Throws**: An `MHException` if the fees cannot be updated.

#### 15. Update Discount

```dart
Future<DiscountData?> updateDiscount(
String intentId,
DiscountItem discount
)
```
- **Purpose**: Updates the discount associated with a specified intent.
- **Parameters**
  - `intentId`: The unique identifier of the intent.
  - `discount`: A `DiscountItem` object representing the discount to be updated.

- **Returns**: `DiscountData` if successful
- **Throws**: An `MHException` if the fees cannot be updated.

---