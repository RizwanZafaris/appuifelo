import 'package:freezed_annotation/freezed_annotation.dart';

part 'receipt_capture.freezed.dart';
part 'receipt_capture.g.dart';

enum ReceiptCaptureSource { camera, gallery }

@freezed
abstract class ReceiptLineItem with _$ReceiptLineItem {
  const factory ReceiptLineItem({
    required String name,
    required int amountMinor,
  }) = _ReceiptLineItem;

  factory ReceiptLineItem.fromJson(Map<String, Object?> json) =>
      _$ReceiptLineItemFromJson(json);
}

@freezed
abstract class ReceiptOcrResult with _$ReceiptOcrResult {
  const factory ReceiptOcrResult({
    required String id,
    required String transactionId,
    required String merchant,
    required DateTime purchasedAt,
    required String currency,
    required int totalMinor,
    required List<ReceiptLineItem> lineItems,
    required double confidence,
  }) = _ReceiptOcrResult;

  factory ReceiptOcrResult.fromJson(Map<String, Object?> json) =>
      _$ReceiptOcrResultFromJson(json);
}

@freezed
sealed class ReceiptCaptureState with _$ReceiptCaptureState {
  const factory ReceiptCaptureState.idle() = ReceiptCaptureIdle;

  const factory ReceiptCaptureState.processing({
    required ReceiptCaptureSource source,
  }) = ReceiptCaptureProcessing;

  const factory ReceiptCaptureState.ready({
    required ReceiptOcrResult result,
    @Default(false) bool editing,
  }) = ReceiptCaptureReady;

  const factory ReceiptCaptureState.confirmed({
    required ReceiptOcrResult result,
  }) = ReceiptCaptureConfirmed;
}
