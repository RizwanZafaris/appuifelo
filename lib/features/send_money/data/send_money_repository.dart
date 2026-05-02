import 'package:felo/features/send_money/domain/send_money.dart';

abstract class SendMoneyRepository {
  List<SendRecipient> savedRecipients();

  SendMoneyQuote quoteForAmountMinor(int sourceAmountMinor);

  String referenceFor(SendMoneyDraft draft);
}
