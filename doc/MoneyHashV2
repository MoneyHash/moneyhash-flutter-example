
# How to use MoneyHash V2 Flutter

Welcome to the MoneyHash SDK documentation for Flutter! This guide provides an overview of the core functionalities of the MoneyHash SDK, including intent states, API methods, and models.

---


### Intent States and Corresponding Actions

Here's a summary of the different intent states defined in the Flutter SDK and the actions associated with them:

| State                              | Action                                                                                                                                                                                                                                                             |
| :--------------------------------- | :----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **MethodSelection**                | [Handle this state](#how-to-handle-method-selection) by rendering the payment methods provided in `methods`. After user selection, proceed with the selected method by calling [`moneyHashSDK.proceedWithMethod`](APIs.md#6-proceed-with-selected-method).                                                                                                  |
| **FormFields**                     | [Handle this state](#handling-the-formfields-state) by rendering form fields from `billingFields`, `shippingFields`, and `tokenizeCardInfo`. Submit the completed data using [`moneyHashSDK.submitForm`](APIs.md#7-submit-form).                        |
| **UrlToRender**                    | Use the [`moneyHashSDK.renderForm`](APIs.md#1-render-moneyhash-embed-form) to display the MoneyHash embed form based on the URL provided. Handle the form submission results through the provided `completionHandler`.                                                                                             |
| **SavedCardCVV**                   | Render a CVV input field using `cvvField`. Optionally, display card information from [`cardTokenData`](./Models.md#3-cardtokendata). Submit the CVV using [`moneyHashSDK.submitCardCVV`](APIs.md#8-submit-card-cvv).                                          |
| **IntentForm**                     | Display the MoneyHash embed form using [`moneyHashSDK.renderForm`](APIs.md#1-render-moneyhash-embed-form). Monitor the form submission outcome with `completionHandler`.                               |
| **IntentProcessed**                | Render a success confirmation UI indicating the payment or payout completion with provided intent details.                                                                                                                        |
| **TransactionWaitingUserAction**   | Show a UI element indicating the transaction awaits user action. If available, show any external action message required from `Transaction`.                                                                                       |
| **TransactionFailed**              | Display a UI element indicating transaction failure. If `recommendedMethods` are provided, show these as alternative options for the user to retry the payment or payout.                                                                  |
| **Expired**                        | Show a message indicating that the intent has expired, prompting the user to initiate a new transaction.                                                                                                                                                             |
| **Closed**                         | Show a message indicating that the intent has been closed and no further actions can be taken.                                                                                                                                                          |

---


### How to Handle Method Selection

Handling method selection is a crucial part of integrating the MoneyHash SDK. This process involves rendering available payment methods and managing the user's choice. Here's how you can handle method selection effectively:

#### Steps to Handle Method Selection

1. **Display Payment Methods**:
   - When the SDK state is `MethodSelection`, extract the `methods` object which contains the available payment options for the intent.
   - Use your UI components to render these payment methods in a list or grid format, allowing the user to choose one.

2. **Capture User Selection**:
   - Implement an interactive element for each payment method. When a user selects a method, capture this selection and prepare to proceed with that method.

3. **Proceed with the Selected Method**:
   - Use the [`moneyHashSDK.proceedWithMethod`](APIs.md#6-proceed-with-selected-method) API call to initiate the payment process with the selected method.
   - Pass the necessary parameters, such as `intentId`, `intentType`, `selectedMethodId`, and `methodType` to this function. Optionally, include any `methodMetaData` if required by the payment process.

#### Example Implementation

Here’s an example of how you might implement this in your Flutter application:

```dart
Widget buildPaymentMethodsList(IntentMethods methods) {
  return ListView.builder(
    itemCount: methods.paymentMethods.length,
    itemBuilder: (context, index) {
      var method = methods.paymentMethods[index];
      return ListTile(
        title: Text(method.title),
        subtitle: Text(method.description),
        onTap: () async {
          try {
            // Assume you have already defined 'intentId' and 'intentType'
            var result = await moneyHashSDK.proceedWithMethod(
              intentId: "currentIntentId",
              intentType: IntentType.payment,  // or payout based on your application flow
              selectedMethodId: method.id,
              methodType: method.type,
            );
            print("Method proceeded successfully: $result");
          } catch (e) {
            print("Error proceeding with method: $e");
          }
        },
      );
    },
  );
}
```

This function builds a list where each payment method is represented by a list tile in the UI. When a user taps on a method, the [`proceedWithMethod`](./APIs.md#6-proceed-with-selected-method) function is called, using the details of the selected method to proceed with the payment process.

---

By following these steps, you can integrate the method selection process seamlessly within your application, ensuring that users can choose their preferred payment method and proceed smoothly. This section of the SDK is crucial for handling payments effectively and should be tailored to fit the specific UI and UX guidelines of your application.

---
### Handling the `formFields` State

When handling the `FormFields` state in MoneyHash, you will deal with two primary scenarios: managing billing or shipping data and handling card tokenization. These scenarios are broken down into steps for clarity.

#### Handling Billing or Shipping Data

1. **Rendering Input Fields**:
   - Use `InputField` data to render form fields. Each field type corresponds to an attribute like name, address, etc., and comes with specific properties to guide the rendering.

2. **Collecting User Input**:
   - Capture input from these fields in the form of map of key as the field name and value is the user value.

Example of handling billing data:
```dart
Map<String, String> billingData = {
  "firstName": "John",
  "lastName": "Doe",
  "email": "john.doe@example.com"
};
```

Handling card tokenization effectively within the MoneyHash SDK for Flutter involves a few critical steps that integrate secure data handling with user interaction. Below, I'll outline a comprehensive approach using the `SecureTextField` and `CardCollector` classes to manage card data securely.

---

### Handling Card Tokenization

#### Overview
Card tokenization in the MoneyHash SDK involves capturing sensitive card information securely and converting it into a token that can be safely stored and transmitted. This process reduces PCI compliance requirements and enhances security.


### Step 1: Configure the Card Form Builder

This step involves initializing the `CardFormBuilder` and setting up listeners for each card field. These listeners will handle real-time validation and state updates for each input.

```dart
CardFormBuilder configureCardFormBuilder() {
    // Initialize the builder
    CardFormBuilder cardFormBuilder = CardFormBuilder();

    // Set up listeners for each field
    cardFormBuilder
        .setCardNumberField((CardFieldState? state) {
          if (state?.isValid ?? false) {
            print("Card number is valid");
          } else {
            print("Card number error: ${state?.errorMessage}");
          }
        })
        .setCVVField((CardFieldState? state) {
          if (state?.isValid ?? false) {
            print("CVV is valid");
          } else {
            print("CVV error: ${state?.errorMessage}");
          }
        })
        .setCardHolderNameField((CardFieldState? state) {
          if (state?.isValid ?? false) {
            print("Card holder name is valid");
          } else {
            print("Card holder name error: ${state?.errorMessage}");
          }
        })
        .setExpiryMonthField((CardFieldState? state) {
          if (state?.isValid ?? false) {
            print("Expiry month is valid");
          } else {
            print("Expiry month error: ${state?.errorMessage}");
          }
        })
        .setExpiryYearField((CardFieldState? state) {
          if (state?.isValid ?? false) {
            print("Expiry year is valid");
          } else {
            print("Expiry year error: ${state?.errorMessage}");
          }
        });

    // Assume TokenizeCardInfo is previously defined and set it
    TokenizeCardInfo tokenizeCardInfo = TokenizeCardInfo(/* parameters */);
    cardFormBuilder.setTokenizeCardInfo(tokenizeCardInfo);

    return cardFormBuilder;
}
```

### Step 2: Build the Card Collector

After configuring the `CardFormBuilder`, the next step is to build the `CardCollector` from it. The `CardCollector` aggregates all card data fields and manages their states, allowing for secure data collection.

```dart
CardCollector buildCardCollector(CardFormBuilder cardFormBuilder) {
    // Build the CardCollector from the configured CardFormBuilder
    CardCollector cardCollector = cardFormBuilder.build();

    return cardCollector;
}
```

3. **Implement Secure Text Fields:**
   - For each card detail (number, CVV, expiry date), implement a `SecureTextField` that binds to the `CardCollector`.
   - `SecureTextField` should handle user inputs, validate them, and update their respective field state in the `CardCollector`.

4. **Collect and Validate Data:**
   - Before attempting to tokenize the card data, validate all fields using the `CardCollector`'s validation methods.
   - If validation passes, proceed to collect the data for tokenization.

5. **Tokenize and Handle Response:**
   - Call the `collect` method on the `CardCollector` to initiate the tokenization process.
   - Handle the response which includes either a token (on success) or error handling logic (on failure).

#### Example Implementation

```dart
class CardDetailsForm extends StatelessWidget {
  final CardCollector cardCollector;

  CardDetailsForm({Key? key, required this.cardCollector}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Card number field
    SecureTextField cardNumberField = SecureTextField(
      cardFormCollector: cardCollector,
      type: CardFieldType.cardNumber,
      placeholder: "Card Number",
      label: "Card Number",
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.next,
    );

    // CVV field
    SecureTextField cvvField = SecureTextField(
      cardFormCollector: cardCollector,
      type: CardFieldType.cvv,
      placeholder: "CVV",
      label: "CVV",
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.next,
    );

    // Expiry date field
    SecureTextField expiryDateField = SecureTextField(
      cardFormCollector: cardCollector,
      type: CardFieldType.expiryMonth,
      placeholder: "MM/YY",
      label: "Expiry Date",
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.done,
    );

    return Column(
      children: [
        cardNumberField,
        cvvField,
        expiryDateField,
        ElevatedButton(
          onPressed: () async {
            if (await cardCollector.isValid()) {
              try {
                VaultData? vaultData = await cardCollector.collect("intentId");
                print("Tokenization successful: ${vaultData?.token}");
              } catch (e) {
                print("Tokenization failed: $e");
              }
            } else {
              print("Validation failed");
            }
          },
          child: Text('Tokenize and Submit'),
        ),
      ],
    );
  }
}
```

#### Explanation:
- **SecureTextField Widgets**: Each field is implemented as a `SecureTextField`, which is tied to the `CardCollector`. The fields handle user input, with the card number, CVV, and expiry date managed separately.
- **Validation and Tokenization**: Before tokenization, the form checks if all fields are valid. If valid, it proceeds with tokenization; otherwise, it alerts the user to correct the inputs.
- **Handling Responses**: Upon successful tokenization, the token is printed or used as needed. If tokenization fails, the error is handled appropriately.

This implementation ensures that card details are handled securely, following best practices for sensitive data management and compliance with security standards.
---

### Overview of MoneyHash APIs

For a detailed guide to all available APIs in the MoneyHash SDK for Flutter, including parameters, return types, and usage examples, refer to the [APIs.md](APIs.md) document. This includes methods for handling payments, retrieving intent details, submitting forms, and more.

---

### Overview of MoneyHash Models

The MoneyHash SDK for Flutter features various models to represent data structures like intents, payment methods, transactions, and card information. For comprehensive details on these models, including their properties and usage within the SDK, see the [Models.md](Models.md) document.

---

This documentation provides a comprehensive overview of integrating and utilizing the MoneyHash SDK in your Flutter applications. For more detailed information, please refer to the linked documentation files.