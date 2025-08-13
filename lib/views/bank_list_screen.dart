import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/bank_list_viewmodel.dart';

class BankListScreen extends StatelessWidget {
  const BankListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Logos de Bancos'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Consumer<BankListViewModel>(
        builder: (context, viewModel, child) {
          switch (viewModel.state) {
            case ViewState.loading:
              return const Center(child: CircularProgressIndicator());
            case ViewState.error:
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Ocorreu um erro: ${viewModel.errorMessage}'),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => viewModel.fetchLogos(),
                      child: const Text('Tentar Novamente'),
                    )
                  ],
                ),
              );
            case ViewState.success:
              return ListView.builder(
                itemCount: viewModel.logos.length,
                itemBuilder: (context, index) {
                  final bank = viewModel.logos[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(10),
                      leading: SizedBox(
                        width: 80,
                        height: 40,
                        child: Image.network(
                          bank.logoUrl,
                          fit: BoxFit.contain,
                          // Bônus: Placeholder de carregamento para cada imagem
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(
                              child: CircularProgressIndicator(
                                strokeWidth: 2.0,
                                value: loadingProgress.expectedTotalBytes != null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                    : null,
                              ),
                            );
                          },
                          // Bônus: Tratamento de erro para cada imagem
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(Icons.error_outline, color: Colors.red);
                          },
                        ),
                      ),
                      title: Text(bank.bankName),
                    ),
                  );
                },
              );
            default:
              return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}