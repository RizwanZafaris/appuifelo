import 'package:felo/features/splits/domain/split.dart';

class SplitsRepository {
  List<Split> seedSplits() {
    return [
      Split(
        id: 'split_rent_may',
        name: 'May rent',
        currency: 'CAD',
        totalMinor: 210000,
        status: SplitStatus.active,
        createdAt: DateTime(2026, 4, 24, 10),
        participants: const [
          SplitParticipant(
            id: 'participant_rizwan',
            splitId: 'split_rent_may',
            displayName: 'Rizwan',
            contact: 'rizwan@example.com',
            shareMinor: 70000,
            paidMinor: 70000,
            status: SplitParticipantStatus.paid,
          ),
          SplitParticipant(
            id: 'participant_saad',
            splitId: 'split_rent_may',
            displayName: 'Saad',
            contact: '+1 647 *** 2211',
            shareMinor: 70000,
            paidMinor: 0,
            status: SplitParticipantStatus.pending,
          ),
          SplitParticipant(
            id: 'participant_amina',
            splitId: 'split_rent_may',
            displayName: 'Amina',
            contact: '+1 416 *** 1189',
            shareMinor: 70000,
            paidMinor: 0,
            status: SplitParticipantStatus.pending,
          ),
        ],
      ),
      Split(
        id: 'split_family_gift',
        name: 'Family gift',
        currency: 'CAD',
        totalMinor: 30000,
        status: SplitStatus.settled,
        createdAt: DateTime(2026, 4, 18, 18),
        participants: const [
          SplitParticipant(
            id: 'participant_fatima',
            splitId: 'split_family_gift',
            displayName: 'Fatima',
            contact: 'fatima@example.com',
            shareMinor: 15000,
            paidMinor: 15000,
            status: SplitParticipantStatus.paid,
          ),
          SplitParticipant(
            id: 'participant_ali',
            splitId: 'split_family_gift',
            displayName: 'Ali',
            contact: '+1 905 *** 7312',
            shareMinor: 15000,
            paidMinor: 15000,
            status: SplitParticipantStatus.paid,
          ),
        ],
      ),
    ];
  }

  Split createSplit({
    required String name,
    required String currency,
    required int totalMinor,
    required List<SplitParticipantDraft> participants,
  }) {
    final splitId = 'split_${DateTime.now().microsecondsSinceEpoch}';
    return Split(
      id: splitId,
      name: name,
      currency: currency,
      totalMinor: totalMinor,
      status: SplitStatus.active,
      createdAt: DateTime.now(),
      participants: [
        for (var index = 0; index < participants.length; index++)
          SplitParticipant(
            id: 'participant_${splitId}_$index',
            splitId: splitId,
            displayName: participants[index].displayName,
            contact: participants[index].contact,
            shareMinor: participants[index].shareMinor,
            paidMinor: 0,
            status: SplitParticipantStatus.pending,
          ),
      ],
    );
  }
}

class SplitParticipantDraft {
  const SplitParticipantDraft({
    required this.displayName,
    required this.contact,
    required this.shareMinor,
  });

  final String displayName;
  final String contact;
  final int shareMinor;
}
