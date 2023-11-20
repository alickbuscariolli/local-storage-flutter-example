import 'dart:math';

import 'package:app_pronto/controllers/numbers_storage_controller.dart';
import 'package:app_pronto/models/number_model.dart';
import 'package:flutter/material.dart';

class NumbersController {
  final NumbersStorageController _storageController;

  NumbersController(this._storageController);

  final ValueNotifier<List<NumberModel>> numbers = ValueNotifier([]);

  void addRandomNumber() {
    numbers.value = [
      ...numbers.value,
      NumberModel(
        Random().nextInt(100),
      )
    ];
  }

  Future<void> saveList(BuildContext context) async {
    await _storageController.saveNumbersList(numbers.value);

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Números aleatórios salvos com sucesso!'),
        ),
      );
    }
  }

  Future<void> loadList() async {
    numbers.value = await _storageController.loadNumbersList();
  }

  Future<void> clear(BuildContext context) async {
    await _storageController.clearNumbersList();

    numbers.value = [];

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Números aleatórios limpos com sucesso!'),
        ),
      );
    }
  }
}
