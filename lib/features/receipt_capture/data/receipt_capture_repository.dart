import 'package:felo/features/receipt_capture/domain/receipt_capture.dart';
import 'package:felo/features/transactions/domain/felo_transaction.dart';

abstract class ReceiptCaptureRepository {
  ReceiptOcrResult mockResultFor(FeloTransaction transaction);
}
