import 'package:flutter/material.dart';
import '../models/bank_logo.dart';
import '../services/api_service.dart';

enum ViewState { idle, loading, success, error }

class BankListViewModel extends ChangeNotifier {
  final ApiService _apiService;

  BankListViewModel({required ApiService apiService}) : _apiService = apiService {
    fetchLogos();
  }

  ViewState _state = ViewState.idle;
  ViewState get state => _state;

  List<BankLogo> _logos = [];
  List<BankLogo> get logos => _logos;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  void _setState(ViewState state) {
    _state = state;
    notifyListeners();
  }

  Future<void> fetchLogos() async {
    _setState(ViewState.loading);
    try {
      _logos = await _apiService.fetchBankLogos();
      _setState(ViewState.success);
    } catch (e) {
      _errorMessage = e.toString();
      _setState(ViewState.error);
    }
  }
}