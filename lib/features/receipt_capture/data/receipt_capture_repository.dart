import 'package:felo/core/network/felo_api_client.dart';
import 'package:felo/features/receipt_capture/domain/receipt_capture.dart';
import 'package:felo/features/transactions/domain/felo_transaction.dart';

// ============================================================================
// Abstract Interface
// ============================================================================

abstract class ReceiptCaptureRepository {
  ReceiptOcrResult mockResultFor(FeloTransaction transaction);
}

// ============================================================================
// API Implementation (production)
// ============================================================================

class ApiReceiptCaptureRepository implements ReceiptCaptureRepository {
  ApiReceiptCaptureRepository(this._api);

  final FeloApiClient _api;

  @override
  ReceiptOcrResult mockResultFor(FeloTransaction transaction) {
    // In API mode, this is called as a fallback after upload fails.
    // The real flow uploads via /receipts/upload then parses via /receipts/{id}/parse.
    final totalMinor = transaction.amountMinor.abs();
    return ReceiptOcrResult(
      id: 'receipt_${transaction.id}',
      transactionId: transaction.id,
      merchant: transaction.merchant,
      purchasedAt: transaction.bookedAt,
      currency: transaction.currency,
      totalMinor: totalMinor,
      lineItems: [
        ReceiptLineItem(
          name: transaction.category,
          amountMinor: (totalMinor * 0.7).round(),
        ),
        ReceiptLineItem(
          name: transaction.merchant,
          amountMinor: totalMinor - (totalMinor * 0.7).round(),
        ),
      ],
      confidence: transaction.parserConfidence.clamp(0, 1),
    );
  }
}

// ============================================================================
// Fake Implementation (demo/offline mode)
// ============================================================================

class FakeReceiptCaptureRepository implements ReceiptCaptureRepository {
  @override
  ReceiptOcrResult mockResultFor(FeloTransaction transaction) {
    final totalMinor = transaction.amountMinor.abs();
    final primaryLineMinor = (totalMinor * 0.7).round();
    final secondaryLineMinor = totalMinor - primaryLineMinor;

    return ReceiptOcrResult(
      id: 'receipt_${transaction.id}',
      transactionId: transaction.id,
      merchant: transaction.merchant,
      purchasedAt: transaction.bookedAt,
      currency: transaction.currency,
      totalMinor: totalMinor,
      lineItems: [
        ReceiptLineItem(
          name: transaction.category,
          amountMinor: primaryLineMinor,
        ),
        ReceiptLineItem(
          name: transaction.merchant,
          amountMinor: secondaryLineMinor,
        ),
      ],
      confidence: transaction.parserConfidence.clamp(0, 1),
    );
  }
}
