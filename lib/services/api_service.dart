import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/bank_logo.dart';

class ApiService {
  final String _baseUrl = 'https://api.bankconv.com';

  Future<List<BankLogo>> fetchBankLogos() async {
    final response = await http.get(Uri.parse('$_baseUrl/bank-logos/'));

    if (response.statusCode == 200) {
      // Decodifica a resposta UTF-8 para lidar com caracteres especiais
      final List<dynamic> data = json.decode(utf8.decode(response.bodyBytes));
      return data.map((json) => BankLogo.fromJson(json)).toList();
    } else {
      // Lança uma exceção em caso de erro na API
      throw Exception('Falha ao carregar os dados dos bancos');
    }
  }
}