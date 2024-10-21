import 'package:flight_booking/pages/constants/app.assets.dart';
import 'package:flight_booking/pages/constants/app_strings.dart';
import 'package:flight_booking/pages/home_page/home_page.controller.dart';
import 'package:flight_booking/pages/view_page/view_page.view.dart';
import 'package:flight_booking/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HomePageView extends GetResponsiveView<HomePageController> {
  HomePageView({super.key}) {
    Get.put(HomePageController());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _appBar(), body: _body(context));
  }

  _appBar() {
    return AppBar(
      backgroundColor: const Color.fromARGB(255, 190, 255, 193),
      title: Text(AppStrings.searchFlights),
      actions: [
        IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {},
        ),
      ],
    );
  }

  _body(context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _headerWidget(),
          _toggleButtons(),
          Obx(() => Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    _destinationWidget(context),
                    const SizedBox(height: 10),
                    _dateWidget(context),
                    const SizedBox(height: 10),
                    _dropDownWidget(context),
                    const SizedBox(height: 10),
                    Center(
                      child: InkWell(
                          onTap: () async {
                            if (controller.fromDestination.isNotEmpty &&
                                controller.toDestination.isNotEmpty &&
                                controller.departureDateController.text != "" &&
                                controller.returnDateController.text != "") {
                              Map response = {
                                "fromDestination":
                                    controller.fromDestination.value,
                                "toDestination": controller.toDestination.value,
                                "departureDate":
                                    controller.departureDateController.text,
                                "returnDate":
                                    controller.returnDateController.text,
                              };
                              await Get.to(() => ViewPage(),
                                  arguments: response);
                            } else {
                              Get.snackbar(
                                  backgroundColor:
                                      const Color.fromARGB(255, 255, 178, 178),
                                  "Error",
                                  "Please fill all fields correctly.",
                                  snackPosition: SnackPosition.BOTTOM);
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(13)),
                            child: Text(
                              AppStrings.searchFlights,
                              style: const TextStyle(color: Colors.white),
                            ),
                          )),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(AppStrings.travelInspirations,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        const Row(
                          children: [
                            Text(
                              'Dubai',
                              style: TextStyle(
                                  color: Colors.blue,
                                  decoration: TextDecoration.underline),
                            ),
                            SizedBox(
                              width: 2,
                            ),
                            Icon(Icons.keyboard_arrow_down_outlined)
                          ],
                        )
                      ],
                    ),
                    const SizedBox(height: 16),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          TravelCard(
                            width: 250,
                            height: 300,
                            imageUrl: MyAppAssets.travel1,
                            destination: 'Saudi Arabia',
                            description: 'From AED867',
                          ),
                          TravelCard(
                            width: 250,
                            height: 300,
                            imageUrl: MyAppAssets.travel2,
                            destination: 'Kuwait',
                            description: 'From AED867',
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(AppStrings.flightAndHotel,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          TravelCard(
                            width: 400,
                            height: 250,
                            imageUrl: MyAppAssets.travel3,
                            destination: '',
                            description: '',
                          ),
                          TravelCard(
                            width: 400,
                            height: 250,
                            imageUrl: MyAppAssets.travel4,
                            destination: '',
                            description: '',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  _headerWidget() {
    return Stack(children: [
      Container(
        height: 200,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(MyAppAssets.headerImage),
            fit: BoxFit.cover,
          ),
        ),
      ),
      const Padding(
        padding: EdgeInsets.all(20),
        child: Text(
          "Let's start your trip",
          style: TextStyle(
            color: Colors.white,
            fontSize: 19,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    ]);
  }

  _dateWidget(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.43,
          child: TextFormField(
            decoration: InputDecoration(
              labelText: AppStrings.departure,
              prefixIcon: const Icon(Icons.calendar_today),
              border: const OutlineInputBorder(),
            ),
            readOnly: true,
            onTap: () async {
              DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2101),
              );
              if (pickedDate != null) {
                final formattedDate =
                    DateFormat('yyyy-MM-dd').format(pickedDate);
                controller.departureDateController.text = formattedDate;
              }
            },
            controller: controller.departureDateController,
          ),
        ),
        const SizedBox(width: 16),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.43,
          child: TextFormField(
            decoration: InputDecoration(
              labelText: AppStrings.returnText,
              prefixIcon: const Icon(Icons.calendar_today),
              border: const OutlineInputBorder(),
            ),
            readOnly: true,
            onTap: () async {
              DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2101),
              );
              if (pickedDate != null) {
                final formattedDate =
                    DateFormat('yyyy-MM-dd').format(pickedDate);
                controller.returnDateController.text = formattedDate;
              }
            },
            controller: controller.returnDateController,
          ),
        ),
      ],
    );
  }

  _dropDownWidget(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.43,
          child: DropdownButtonFormField(
            decoration: InputDecoration(
              labelText: AppStrings.travelers,
              border: const OutlineInputBorder(),
            ),
            value: '1 Passenger',
            items: controller.passengerList
                .map((element) =>
                    DropdownMenuItem(value: element, child: Text(element)))
                .toList(),
            onChanged: (value) {},
          ),
        ),
        const SizedBox(width: 16),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.43,
          child: DropdownButtonFormField(
            decoration: const InputDecoration(
              labelText: 'Class',
              border: OutlineInputBorder(),
            ),
            value: 'Economy Class',
            items: controller.classList
                .map((element) =>
                    DropdownMenuItem(value: element, child: Text(element)))
                .toList(),
            onChanged: (value) {},
          ),
        ),
      ],
    );
  }

  _toggleButtons() {
    RxList<bool> isSelected = [false, true, false].obs;
    return Obx(
      () => Center(
        child: ToggleButtons(
          borderRadius: BorderRadius.circular(10),
          selectedColor: Colors.white,
          fillColor: Colors.green,
          color: Colors.black,
          textStyle: const TextStyle(fontSize: 16),
          constraints: const BoxConstraints(minHeight: 50.0, minWidth: 100.0),
          isSelected: isSelected,
          onPressed: (int index) {
            for (int i = 0; i < isSelected.length; i++) {
              isSelected[i] = i == index;
            }
          },
          children: const [
            Text("Round Trip"),
            Text("One Way"),
            Text("Multi-city"),
          ],
        ),
      ),
    );
  }

  _destinationWidget(BuildContext context) {
    return Obx(() => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () async {
                    final value = await bottomSheet(context);
                    if (value != null) {
                      controller.fromDestination.value = value;
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SvgPicture.asset(MyAppAssets.flightLogo),
                        const SizedBox(width: 20),
                        Text(controller.fromDestination.value.isNotEmpty
                            ? controller.fromDestination.value
                            : 'From'),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: const Divider(
                    color: Colors.green,
                  ),
                ),
                InkWell(
                  onTap: () async {
                    final value = await bottomSheet(context);
                    if (value != null) {
                      controller.toDestination.value = value;
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SvgPicture.asset(MyAppAssets.locationIcon),
                        const SizedBox(width: 20),
                        Text(controller.toDestination.value.isNotEmpty
                            ? controller.toDestination.value
                            : 'To'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SvgPicture.asset(MyAppAssets.undoIcon),
          ],
        ));
  }

  bottomSheet(BuildContext context) {
    return Get.bottomSheet(
      isDismissible: false,
      IntrinsicHeight(
        child: Container(
          padding: const EdgeInsets.all(15),
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.0),
              topRight: Radius.circular(15.0),
            ),
          ),
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.006,
                width: MediaQuery.of(context).size.width * 0.1,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 0, 233, 12).withOpacity(0.4),
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () => Get.back(),
                    child: const Text('Back'),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 214, 243, 215),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Column(
                        children: [
                          ...controller.destinationList.map((data) {
                            return InkWell(
                              onTap: () {
                                Get.back(result: data);
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 15.0,
                                  horizontal: 30,
                                ),
                                child: Row(
                                  children: [
                                    Text(
                                      data,
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      isScrollControlled: true,
      enableDrag: true,
      backgroundColor: Colors.transparent,
    );
  }
}
