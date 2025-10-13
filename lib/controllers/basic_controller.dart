import 'package:get/get.dart';
import 'package:lekra/data/repositories/basic_repo.dart';

class BasicController extends GetxController implements GetxService {
  final BasicRepo basicRepo;

  BasicController({required this.basicRepo});

  bool isLoading = false;

  List<String> sliders = [];
}
