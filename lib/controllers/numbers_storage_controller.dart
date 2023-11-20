import 'dart:convert';

import 'package:app_pronto/models/number_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String LIST_OF_INT_KEY = 'LIST_OF_INT_KEY';

class NumbersStorageController {
  Future<void> saveNumbersList(List<NumberModel> listOfInt) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString(
      LIST_OF_INT_KEY,
      jsonEncode(
        listOfInt
            .map(
              (number) => number.toMap(),
            )
            .toList(),
      ),
    );
  }

  Future<List<NumberModel>> loadNumbersList() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final String? listString = prefs.getString(LIST_OF_INT_KEY);

    if (listString != null) {
      return ((jsonDecode(listString)) as List)
          .map<NumberModel>(
            (numberString) => NumberModel.fromMap(numberString),
          )
          .toList();
    }

    return [];
  }

  Future<void> clearNumbersList() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.clear();
  }
}
