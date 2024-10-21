import 'dart:math';

import 'package:flight_booking/pages/constants/app.assets.dart';
import 'package:flight_booking/pages/view_page/view_page.controller.dart';
import 'package:flight_booking/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ViewPage extends GetResponsiveView<ViewPageController> {
  ViewPage({super.key}) {
    Get.put(ViewPageController());
    controller.inIt();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 190, 255, 193),
        title: const Text('Ezy Travel'),
        leading: InkWell(
            onTap: () => Get.back(), child: const Icon(Icons.arrow_back)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            _flightInfoWidgets(context),
            const SizedBox(height: 10),
            _dayFilterWidget(context),
            const SizedBox(height: 10),
            Expanded(
                child: ListView.builder(
              itemCount: 3,
              itemBuilder: (context, index) {
                return FlightBookingCard(
                  fromDestination: controller.destinationMap['fromDestination'],
                  toDestination: controller.destinationMap['toDestination'],
                );
              },
            )),
          ],
        ),
      ),
    );
  }

  Widget _dayFilterWidget(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _dayWidget(addDate(controller.destinationMap['departureDate'], -1),
            formatDate(controller.destinationMap['departureDate'])),
        _dayWidget(formatDate(controller.destinationMap['departureDate']),
            addDate(controller.destinationMap['departureDate'], 1)),
        _dayWidget(formatDate(controller.destinationMap['departureDate']),
            addDate(controller.destinationMap['departureDate'], 2)),
      ],
    );
  }

  _dayWidget(firstDate, secondDate) {
    Random random = Random();
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10)),
      padding: const EdgeInsets.all(5),
      child: Column(
        children: [
          Text(
            '$firstDate - $secondDate',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
          ),
          Text(
            'From AED ${random.nextInt(1000)}',
            style: const TextStyle(fontWeight: FontWeight.w300, fontSize: 13),
          ),
        ],
      ),
    );
  }

  Widget _flightInfoWidgets(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Obx(() => Text(
                  '${controller.destinationMap['fromDestination']}  to ${controller.destinationMap['toDestination']}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                )),
            const SizedBox(height: 5),
            Obx(() => Text(
                  'Departure: ${controller.destinationMap['departureDate'] != null ? formatDate(controller.destinationMap['departureDate']) : 'Sat, 23 Mar'} - Return: ${controller.destinationMap['returnDate'] != null ? formatDate(controller.destinationMap['returnDate']) : 'Sat, 30 Mar'}',
                  style: TextStyle(color: Colors.grey[700]),
                )),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '(Round Trip)',
                  style: TextStyle(color: Colors.red),
                ),
                SizedBox(width: 10),
                Text(
                  'Modify Search',
                  style: TextStyle(color: Colors.green),
                ),
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Row(
                  children: [
                    Text('Sort'),
                    Icon(Icons.keyboard_arrow_down_outlined)
                  ],
                ),
                const Text('Non-Stop'),
                Row(
                  children: [
                    const Text('Filter'),
                    const SizedBox(width: 5),
                    SvgPicture.asset(MyAppAssets.filterIcon)
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

formatDate(date) {
  DateTime dateV = DateTime.parse(date);
  String formattedDate = DateFormat('MMM d').format(dateV);
  return formattedDate;
}

addDate(date, addDay) {
  DateTime dateV = DateTime.parse(date).add(Duration(days: addDay));
  String formattedDate = DateFormat('MMM d').format(dateV);
  return formattedDate;
}
