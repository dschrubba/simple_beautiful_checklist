import 'package:flutter/material.dart';
import 'package:simple_beautiful_checklist_exercise/data/database_repository.dart';
import 'package:simple_beautiful_checklist_exercise/data/shared_prefrences_repository.dart';
import 'package:simple_beautiful_checklist_exercise/src/app.dart';

void main() async {
  // Wird benötigt, um auf SharedPreferences zuzugreifen
  WidgetsFlutterBinding.ensureInitialized();

  final DatabaseRepository repository = SharedPreferencesRepository();

  runApp(App(repository: repository));
}
