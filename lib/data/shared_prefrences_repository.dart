import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_beautiful_checklist_exercise/data/database_repository.dart';

class SharedPreferencesRepository implements DatabaseRepository {
  static const String _storageKey = 'items';

  Future<SharedPreferences> get _prefs async =>
      await SharedPreferences.getInstance();

  Future<List<String>> _loadItems() async {
    final prefs = await _prefs;
    return prefs.getStringList(_storageKey) ?? [];
  }

  Future<void> _saveItems(List<String> items) async {
    final prefs = await _prefs;
    await prefs.setStringList(_storageKey, items);
  }

  @override
  Future<int> getItemCount() async {
    final items = await _loadItems();
    return items.length;
  }

  @override
  Future<List<String>> getItems() async {
    return await _loadItems();
  }

  @override
  Future<void> addItem(String item) async {
    if (item.isEmpty) return;
    final items = await _loadItems();
    if (!items.contains(item)) {
      items.add(item);
      await _saveItems(items);
    }
  }

  @override
  Future<void> deleteItem(int index) async {
    final items = await _loadItems();
    if (index >= 0 && index < items.length) { 
      items.removeAt(index);
      await _saveItems(items);
    }
  }

  @override
  Future<void> editItem(int index, String newItem) async {
    if (newItem.trim().isEmpty) return;
    final items = await _loadItems();
    if (index >= 0 && index < items.length && !items.contains(newItem)) {
      items[index] = newItem;
      await _saveItems(items);
    }
  }
}
