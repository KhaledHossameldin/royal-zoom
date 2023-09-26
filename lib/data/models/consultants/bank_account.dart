import 'dart:convert';

class BankAccount {
  final int id;
  final String uuid;
  final int userId;
  final String bankName;
  final String accountName;
  final String accountNumber;
  final String address;
  final String swiftCode;
  final String iban;
  final bool isActive;
  //TODO: final String? paypalAccount;

  BankAccount({
    required this.id,
    required this.uuid,
    required this.userId,
    required this.bankName,
    required this.accountName,
    required this.accountNumber,
    required this.address,
    required this.swiftCode,
    required this.iban,
    required this.isActive,
  });

  BankAccount copyWith({
    int? id,
    String? uuid,
    int? userId,
    String? bankName,
    String? accountName,
    String? accountNumber,
    String? address,
    String? swiftCode,
    String? iban,
    bool? isActive,
  }) {
    return BankAccount(
      id: id ?? this.id,
      uuid: uuid ?? this.uuid,
      userId: userId ?? this.userId,
      bankName: bankName ?? this.bankName,
      accountName: accountName ?? this.accountName,
      accountNumber: accountNumber ?? this.accountNumber,
      address: address ?? this.address,
      swiftCode: swiftCode ?? this.swiftCode,
      iban: iban ?? this.iban,
      isActive: isActive ?? this.isActive,
    );
  }

  Map<String, dynamic> toMap() {
    final contract = _BankAccountContract();

    return {
      contract.id: id,
      contract.uuid: uuid,
      contract.userId: userId,
      contract.bankName: bankName,
      contract.accountName: accountName,
      contract.accountNumber: accountNumber,
      contract.address: address,
      contract.swiftCode: swiftCode,
      contract.iban: iban,
      contract.isActive: isActive,
    };
  }

  factory BankAccount.fromMap(Map<String, dynamic> map) {
    final contract = _BankAccountContract();

    return BankAccount(
      id: map[contract.id]?.toInt() ?? 0,
      uuid: map[contract.uuid] ?? '',
      userId: map[contract.userId]?.toInt() ?? 0,
      bankName: map[contract.bankName] ?? '',
      accountName: map[contract.accountName] ?? '',
      accountNumber: map[contract.accountNumber] ?? '',
      address: map[contract.address] ?? '',
      swiftCode: map[contract.swiftCode] ?? '',
      iban: map[contract.iban] ?? '',
      isActive: (map[contract.isActive] as int) != 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory BankAccount.fromJson(String source) =>
      BankAccount.fromMap(json.decode(source));

  @override
  String toString() =>
      'BankAccount(id: $id, uuid: $uuid, userId: $userId, bankName: $bankName, accountName: $accountName, accountNumber: $accountNumber, address: $address, swiftCode: $swiftCode, iban: $iban, isActive: $isActive)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BankAccount &&
        other.id == id &&
        other.uuid == uuid &&
        other.userId == userId &&
        other.bankName == bankName &&
        other.accountName == accountName &&
        other.accountNumber == accountNumber &&
        other.address == address &&
        other.swiftCode == swiftCode &&
        other.iban == iban &&
        other.isActive == isActive;
  }

  @override
  int get hashCode =>
      id.hashCode ^
      uuid.hashCode ^
      userId.hashCode ^
      bankName.hashCode ^
      accountName.hashCode ^
      accountNumber.hashCode ^
      address.hashCode ^
      swiftCode.hashCode ^
      iban.hashCode ^
      isActive.hashCode;
}

class _BankAccountContract {
  final id = 'id';
  final uuid = 'uuid';
  final userId = 'user_id';
  final bankName = 'bank_name';
  final accountName = 'account_name';
  final accountNumber = 'account_number';
  final address = 'address';
  final swiftCode = 'swift_code';
  final iban = 'iban';
  final paypalAccount = 'paypal_account';
  final isActive = 'is_active';
}
