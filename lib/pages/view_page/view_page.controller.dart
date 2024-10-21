import 'package:flight_booking/pages/view_page/view_page.variables.dart';
import 'package:get/get.dart';

class ViewPageController extends GetxController with ViewPageVariables {
  inIt() async {
    destinationMap.value = Get.arguments;
  }
}
