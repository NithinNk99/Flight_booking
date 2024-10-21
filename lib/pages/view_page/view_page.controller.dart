import 'package:flight_booking/pages/view_page/view_page.variables.dart';
import 'package:get/get.dart';

class ViewPageController extends GetxController with ViewPageVariables {
  inIt() async {
    destinationMap.value = {
      "fromDestination": "SIN - Singapore",
      "toDestination": "HND - Tokyo",
      "departureDate": "2024-10-23",
      "returnDate": "2024-10-21"
    };
  }
}
