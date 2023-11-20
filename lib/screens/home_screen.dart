import 'package:app_pronto/controllers/numbers_controller.dart';
import 'package:app_pronto/controllers/numbers_storage_controller.dart';
import 'package:app_pronto/models/number_model.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final numbersCtrl = NumbersController(NumbersStorageController());

  @override
  void initState() {
    numbersCtrl.loadList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ValueListenableBuilder<List<NumberModel>>(
              valueListenable: numbersCtrl.numbers,
              builder: (_, List<NumberModel> numbers, __) => Expanded(
                child: numbers.isEmpty
                    ? const Center(
                        child: Text(
                          'Comece gerando um número!',
                          style: TextStyle(
                            fontSize: 24,
                          ),
                        ),
                      )
                    : ListView(
                        children: numbers
                            .map(
                              (numberModel) => Text(
                                numberModel.number.toString(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 48,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            )
                            .toList(),
                      ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: numbersCtrl.addRandomNumber,
                    child: const Text('Gerar número aleatório'),
                  ),
                  ElevatedButton(
                    onPressed: () => numbersCtrl.clear(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    child: const Text('Limpar lista'),
                  ),
                  ElevatedButton(
                    onPressed: () => numbersCtrl.saveList(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                    child: const Text('Salvar'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
