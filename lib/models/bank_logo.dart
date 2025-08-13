import 'package:flutter/foundation.dart';

@immutable
class BankLogo {
  final String bankName;
  final String logoUrl;

  const BankLogo({required this.bankName, required this.logoUrl});

  // Factory constructor para criar uma instância a partir de um JSON Map
  factory BankLogo.fromJson(Map<String, dynamic> json) {
    return BankLogo(
      bankName: json['bank_name'] ?? 'Nome Indisponível',
      logoUrl: json['logo_url'] ?? '',
    );
  }
}