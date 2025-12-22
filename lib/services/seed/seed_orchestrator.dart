import 'seed_validator.dart';
import 'seed_writer.dart';

class SeedOrchestrator {
  static Future<void> run() async {
    await SeedValidator.validateAll();
    await SeedWriter.writeAll();
  }
}
