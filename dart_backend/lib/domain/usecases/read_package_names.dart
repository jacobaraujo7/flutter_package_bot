import 'dart:io';

abstract class ReadPackageName {
  Future<List<String>> call(File txtFile);
}

class IOReadPackageName implements ReadPackageName {
  @override
  Future<List<String>> call(File txtFile) async {
    final lines = await txtFile.readAsLines();
    return lines.map((e) => e.trim()).toList();
  }
}
