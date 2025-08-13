import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'services/api_service.dart';
import 'viewmodels/bank_list_viewmodel.dart';
import 'views/bank_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  // The 'key' parameter is correctly passed to the superclass constructor.
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Injetando as dependências na árvore de widgets
    return ChangeNotifierProvider(
      create: (context) => BankListViewModel(apiService: ApiService()),
      child: MaterialApp(
        title: 'Teste Dev Sênior',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const BankListScreen(),
      ),
    );
  }
}