
# MoneyHash SDK Models Documentation

This document provides a detailed explanation of each model within the MoneyHash SDK for Flutter. These models represent various aspects of payment intents, methods, transactions, and more.

#### 1. `CardFieldState`

```dart
class CardFieldState {
  final bool isValid;
  final String? errorMessage;
}
```

- **Description**: Represents the state of a card input field.
- **Properties**:
    - `isValid`: A boolean indicating whether the input in the field is valid.
    - `errorMessage`: An optional string that contains an error message if the input is invalid.

---

#### 2. `CardFieldType`

```dart
enum CardFieldType {
  cardNumber,
  cardHolderName,
  expiryYear,
  expiryMonth,
  cvv
}
```

- **Description**: Enum representing different types of card fields used in forms.
- **Enum Cases**:
    - `cardNumber`: Represents the card number field.
    - `cardHolderName`: Represents the cardholder's name field.
    - `expiryYear`: Represents the expiration year field.
    - `expiryMonth`: Represents the expiration month field.
    - `cvv`: Represents the CVV field (Card Verification Value).

---

#### 3. `CardTokenData`

```dart
class CardTokenData {
  final String? bin;
  final String? brand;
  final String? cardHolderName;
  final String? country;
  final String? expiryMonth;
  final String? expiryYear;
  final String? issuer;
  final String? last4;
  final String? logo;
  final List<String>? paymentMethods;
  final bool? requiresCvv;
}
```

- **Description**: Represents token data for a card used in payment processing.
- **Properties**:
    - `bin`: Bank Identification Number of the card.
    - `brand`: Brand of the card (e.g., Visa, MasterCard).
    - `cardHolderName`: Name of the cardholder.
    - `country`: Country where the card was issued.
    - `expiryMonth`: Expiry month of the card.
    - `expiryYear`: Expiry year of the card.
    - `issuer`: Issuer of the card.
    - `last4`: Last four digits of the card number.
    - `logo`: Logo associated with the card brand.
    - `paymentMethods`: List of payment methods associated with the card.
    - `requiresCvv`: Boolean indicating if CVV is required for transactions.

---

#### 4. `FeeItem`

```dart
class FeeItem {
  final Map<Language, String> title;
  final String value;
}
```

- **Description**: Represents a fee item associated with an intent.
- **Properties**:
    - `title`: A map of titles by language, describing the fee.
    - `value`: The value of the fee.

---

#### 5. `Language`

```dart
enum Language { arabic, english, french }
```

- **Description**: Enum representing different languages supported by the SDK.
- **Enum Cases**:
    - `arabic`: Arabic language.
    - `english`: English language.
    - `french`: French language.

---

#### 6. `InputField`

```dart
class InputField {
  final InputFieldType type;
  final String? name;
  String? value;
  final String? label;
  final int? maxLength;
  final bool isRequired;
  final List<OptionItem>? optionsList;
  final Map<String, List<OptionItem>>? optionsMap;
  final String? hint;
  final int? minLength;
  final bool readOnly;
  final String? dependsOn;
}
```

- **Description**: Represents a field in a form used for collecting user input.
- **Properties**:
    - `type`: Type of the input field (e.g., text, email).
    - `name`: Name of the input field.
    - `value`: Current value of the input field.
    - `label`: Label for the input field.
    - `maxLength`: Maximum length of the input.
    - `isRequired`: Indicates if the field is required.
    - `optionsList`: List of selectable options.
    - `optionsMap`: Map of selectable options.
    - `hint`: Hint message for the input field.
    - `minLength`: Minimum length of the input.
    - `readOnly`: Indicates if the field is read-only.
    - `dependsOn`: Specifies another field that this field depends on.

---

#### 7. `InputFieldType`

```dart
enum InputFieldType {
  text,
  email,
  phoneNumber,
  date,
  number,
  select,
}
```

- **Description**: Enum representing the type of an input field.
- **Enum Cases**:
    - `text`: Standard text input field.
    - `email`: Email input field.
    - `phoneNumber`: Phone number input field.
    - `date`: Date input field.
    - `number`: Numeric input field.
    - `select`: Dropdown or select input field.

---

#### 8. `OptionItem`

```dart
class OptionItem {
  final String label;
  final String value;
}
```

- **Description**: Represents an option item in a selectable list within an input field.
- **Properties**:
    - `label`: The label displayed to the user.
    - `value`: The value associated with the option.

---

#### 9. `IntentStatus`

```dart
enum IntentStatus {
  processed,
  unProcessed,
  timeExpired,
  closed,
}
```

- **Description**: Enum representing the possible statuses of an intent.
- **Enum Cases**:
    - `processed`: The intent has been processed.
    - `unProcessed`: The intent remains unprocessed.
    - `timeExpired`: The intent has expired due to time constraints.
    - `closed`: The intent has been closed.

---

#### 10. `IntentDetails`

```dart
class IntentDetails {
  final String? selectedMethod;
  final IntentData? intent;
  final double? walletBalance;
  final TransactionData? transaction;
  final IntentStateDetails? intentState;
  final List<ProductItem>? productItems;
}
```

- **Description**: Provides detailed information about an intent.
- **Properties**:
    - `selectedMethod`: The payment method selected for the intent.
    - `intent`: The `IntentData` object containing core details of the intent.
    - `walletBalance`: The wallet balance associated for the current customer.
    - `transaction`: Details about the transaction (`TransactionData`).
    - `intentState`: The current state of the intent (`IntentStateDetails`).
    - `productItems`: A list of product items related to the intent.

---

#### 11. `TransactionData`

```dart
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
```

- **Description**: Represents details about a transaction within an intent.
- **Properties**:
    - `billingData`: Billing data associated with the transaction.
    - `amount`: The amount involved in the transaction.
    - `externalActionMessage`: External action messages, if any.
    - `amountCurrency`: The currency of the transaction amount.
    - `id`: The unique identifier of the transaction.
    - `methodName`: The name of the method used for the transaction.
    - `method`: The method used for the transaction.
    - `createdDate`: The date when the transaction was created.
    - `status`: The current status of the transaction.
    - `customFields`: Custom fields related to the transaction.
    - `providerTransactionFields`: Fields specific to the transaction provider.
    - `customFormAnswers`: Answers to any custom forms associated with the transaction.

---

#### 12. `IntentData`

```dart
class IntentData {
  final AmountData? amount;
  final String? secret;
  final String? expirationDate;
  final bool? isLive;
  final String? id;
  final IntentStatus? status;
  final List<FeeItem>? fees;
  final String? totalDiscount;
  final String? subtotalAmount;
}
```

- **Description**: Represents the core details of an intent.
- **Properties**:
    - `amount`: The total amount for the intent (`AmountData`).
    - `secret`: A secret key associated with the intent.
    - `expirationDate`: The date when the intent expires.
    - `isLive`: Indicates if the intent is in live mode.
    - `id`: The unique identifier for the intent.
    - `status`: The current status of the intent (`IntentStatus`).
    - `fees`: A list of fees applied to the intent (`FeeItem`).
    - `totalDiscount`: The total discount applied to the intent.
    - `subtotalAmount`: The subtotal amount before any discounts or fees.

---

#### 13. `AmountData`

```dart
class AmountData {
  final String? value;
  final double? formatted;
  final String? currency;
  final double? maxPayout;
}
```

- **Description**: Represents the monetary value related to an intent.
- **Properties**:
    - `value`: The raw value of the amount.
    - `formatted`: The formatted amount value.
    - `currency`: The currency code (e.g., "USD").
    - `maxPayout`: The maximum payout amount allowed.

---

#### 14. `CustomerBalance`

```dart
class CustomerBalance {
  final double? balance;
  final String? id;
  final String? icon;
  final bool? isSelected;
  final MethodType? type;
}
```

- **Description**: Represents a customer balance available for use in an intent.
- **Properties**:
    - `balance`: The balance amount.
    - `id`: The unique identifier of the customer balance.
    - `icon`: An icon associated with the balance.
    - `isSelected`: Indicates if this balance is selected.
    - `type`: The type of method (`MethodType`).

---

#### 15. `PaymentMethod`

```dart
class PaymentMethod {
  final String? id;
  final String? title;
  final bool? isSelected;
  final bool? confirmationRequired;
  final List<String>? icons;
  final MethodType? type;
}
```

- **Description**: Represents a payment method available for the user.
- **Properties**:
    - `id`: The unique identifier of the payment method.
    - `title`: The title or name of the payment method.
    - `isSelected`: Indicates if this method is selected.
    - `confirmationRequired`: Indicates if confirmation is required for this method.
    - `icons`: Icons associated with the payment method.
    - `type`: The type of method (`MethodType`).

---

#### 16. `PayoutMethod`

```dart
class PayoutMethod {
  final String? id;
  final String? title;
  final bool? isSelected;
  final bool? confirmationRequired;
  final List<String>? icons;
  final MethodType? type;
}
```

- **Description**: Represents a payout method available for the user.
- **Properties**:
    - `id`: The unique identifier of the payout method.
    - `title`: The title or name of the payout method.
    - `isSelected`: Indicates if this method is selected.
    - `confirmationRequired`: Indicates if confirmation is required for this method.
    - `icons`: Icons associated with the payout method.
    - `type`: The type of method (`MethodType`).

---

#### 17. `ExpressMethod`

```dart
class ExpressMethod {
  final String? id;
  final String? title;
  final bool? isSelected;
  final bool? confirmationRequired;
  final List<String>? icons;
  final MethodType? type;
}
```

- **Description**: Represents an express payment method.
- **Properties**:
    - `id`: The unique identifier of the express method.
    - `title`: The title or name of the express method.
    - `isSelected`: Indicates if this method is selected.
    - `confirmationRequired`: Indicates if confirmation is required for this method.
    - `icons`: Icons associated with the express method.
    - `type`: The type of method (`MethodType`).

---

#### 18. `SavedCard`

```dart
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
```

- **Description**: Represents a saved card used in transactions.
- **Properties**:
    - `id`: The unique identifier of the saved card.
    - `brand`: The brand of the card (e.g., Visa, MasterCard).
    - `last4`: The last four digits of the card number.
    - `expiryMonth`: The expiry month of the card.
    - `expiryYear`: The expiry year of the card.
    - `country`: The country where the card was issued.
    - `logo`: The logo associated with the card brand.
    - `requireCvv`: Indicates if CVV is required for this card.
    - `cvvConfig`: Configuration related to CVV input (`CvvConfig`).
    - `type`: The type of method (`MethodType`).

---

#### 19. `CvvConfig`

```dart
class CvvConfig {
  final int? digitsCount;
}
```

- **Description**: Configuration details for entering the CVV during a transaction.
- **Properties**:
    - `digitsCount`: The number of digits required for the CVV.

---

#### 20. `IntentMethods`

```dart
class IntentMethods {
  final List<CustomerBalance>? customerBalances;
  final List<PaymentMethod>? paymentMethods;
  final List<ExpressMethod>? expressMethods;
  final List<SavedCard>? savedCards;
  final List<PayoutMethod>? payoutMethods;
}
```

- **Description**: Represents different payment methods available for an intent.
- **Properties**:
    - `customerBalances`: A list of available customer balances.
    - `paymentMethods`: A list of available payment methods.
    - `expressMethods`: A list of available express methods.
    - `savedCards`: A list of saved cards.
    - `payoutMethods`: A list of available payout methods.

---

#### 21. `IntentResult`

```dart
class IntentResult {
  final IntentMethods? methods;
  final IntentDetails? details;
}
```

- **Description**: Represents the result of available methods for an intent.
- **Properties**:
    - `methods

`: Contains the available payment methods (`IntentMethods`).
- `details`: Provides detailed information about the intent (`IntentDetails`).

---

#### 22. `IntentStateDetails`

```dart
sealed class IntentStateDetails {}
```

- **Description**: Represents different states an intent can be in.
- **Subclasses**:
    - `MethodSelection`: Represents the method selection state.
    - `IntentForm`: Represents the state where the MoneyHash form is rendered.
    - `IntentProcessed`: Represents the state where the intent has been processed.
    - `TransactionWaitingUserAction`: Represents the state where the transaction is waiting for user action.
    - `TransactionFailed`: Represents the state where the transaction has failed, with recommended methods provided.
    - `Expired`: Represents the state where the intent has expired.
    - `Closed`: Represents the state where the intent has been closed.
    - `FormFields`: Represents the state where form fields are being filled out.
    - `UrlToRender`: Represents the state where a URL is being redirected.
    - `SavedCardCVV`: Represents the state where a saved card's CVV is being entered.
    - `NativePay`: Represents the use of native payment methods like Apple Pay.

---

#### 23. `MethodType`

```dart
enum MethodType {
  expressMethod,
  customerBalance,
  savedCard,
  paymentMethod,
  payoutMethod,
}
```

- **Description**: Enum representing different types of methods available for an intent.
- **Enum Cases**:
    - `expressMethod`: Represents an express payment method.
    - `customerBalance`: Represents a customer balance method.
    - `savedCard`: Represents a saved card method.
    - `paymentMethod`: Represents a standard payment method.
    - `payoutMethod`: Represents a payout method.

---

#### 24. `MethodMetaData`

```dart
class MethodMetaData {
  final String? cvv;
}
```

- **Description**: Contains metadata related to a payment method, such as CVV.
- **Properties**:
    - `cvv`: The CVV code for a card.

---

#### 25. `ApplePayData`

```dart
class ApplePayData extends NativePayData {
  final String? countryCode;
  final String? merchantId;
  final String? currencyCode;
  final double? amount;
  final List<String>? supportedNetworks;
}
```

- **Description**: Contains data necessary for configuring an Apple Pay transaction.
- **Properties**:
    - `countryCode`: The country code for the transaction (e.g., "US").
    - `merchantId`: The merchant identifier for Apple Pay.
    - `currencyCode`: The currency code for the transaction (e.g., "USD").
    - `amount`: The amount to be charged.
    - `supportedNetworks`: A list of supported networks for Apple Pay (e.g., Visa, MasterCard).

---

#### 26. `ProductItem`

```dart
class ProductItem {
  final String? name;
  final String? type;
  final String? amount;
  final String? category;
  final int? quantity;
  final String? description;
  final String? subcategory;
  final String? referenceId;
}
```

- **Description**: Represents an item associated with a product in an intent.
- **Properties**:
    - `name`: The name of the product item.
    - `type`: The type of the product item.
    - `amount`: The amount associated with the product item.
    - `category`: The category of the product item.
    - `quantity`: The quantity of the product item.
    - `description`: A description of the product item.
    - `subcategory`: The subcategory of the product item.
    - `referenceId`: A reference ID associated with the product item.

---

#### 27. `RenderStrategy`

```dart
enum RenderStrategy {
  iframe,
  popupIframe,
  redirect,
  none,
}
```

- **Description**: Enum representing different strategies for rendering web content within the SDK.
- **Enum Cases**:
    - `iframe`: Content is rendered within an iframe.
    - `popupIframe`: Content is rendered within a popup iframe.
    - `redirect`: Content is rendered via a URL redirect.
    - `none`: No rendering strategy is applied.

---

#### 28. `SaveCardCheckbox`

```dart
class SaveCardCheckbox {
  final bool? mandatory;
  final bool? show;
}
```

- **Description**: Represents the configuration for the save card checkbox.
- **Properties**:
    - `mandatory`: Indicates if the save card option is mandatory.
    - `show`: Indicates if the save card checkbox should be shown.

---

#### 29. `TokenizeCardInfo`

```dart
class TokenizeCardInfo {
  final String? accessToken;
  final bool? isLive;
  final bool? saveCard;
  final SaveCardCheckbox? saveCardCheckbox;
}
```

- **Description**: Represents the data needed to tokenize a card in the payment process.
- **Properties**:
    - `accessToken`: An access token used for tokenizing the card.
    - `isLive`: Indicates if the card is in live mode.
    - `saveCard`: Indicates if the card should be saved.
    - `saveCardCheckbox`: Configuration for the save card checkbox (`SaveCardCheckbox`).

---

#### 30. `VaultData`

```dart
class VaultData {
  final String? firstSixDigits;
  final String? lastFourDigits;
  final String? cardScheme;
  final String? cardHolderName;
  final String? expiryYear;
  final String? expiryMonth;
  final bool? isLive;
  final String? accessToken;
  final String? cardToken;
  final String? cvv;
  final bool? saveCard;
  final String? fingerprint;
}
```

- **Description**: Represents the data stored in the vault for a card used in payment processing.
- **Properties**:
    - `firstSixDigits`: The first six digits of the card number.
    - `lastFourDigits`: The last four digits of the card number.
    - `cardScheme`: The scheme of the card (e.g., Visa, MasterCard).
    - `cardHolderName`: The name of the cardholder.
    - `expiryYear`: The expiry year of the card.
    - `expiryMonth`: The expiry month of the card.
    - `isLive`: Indicates if the card is in live mode.
    - `accessToken`: An access token associated with the card.
    - `cardToken`: A token representing the card.
    - `cvv`: The CVV code for the card.
    - `saveCard`: Indicates if the card should be saved.
    - `fingerprint`: A fingerprint associated with the card for additional security.

---

This documentation provides a comprehensive overview of the models used in the Flutter version of the MoneyHash SDK, detailing each model's role, properties, and interactions within the SDK ecosystem. If you have any further questions or need additional details on any of the models, please let me know!