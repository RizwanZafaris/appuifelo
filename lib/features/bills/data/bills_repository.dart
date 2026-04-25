import 'package:felo/features/bills/domain/bill.dart';

abstract class BillsRepository {
  List<Bill> seedBills();

  Bill createManualBill({
    required String name,
    required int amountMinor,
    required DateTime dueDate,
  });
}
