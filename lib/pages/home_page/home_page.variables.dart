import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

mixin HomePageVariables {
  List destinationList = [
    'BLR - Bengaluru',
    'DXB - Dubai',
    'LHR - London',
    'JFK - New York',
    'SIN - Singapore',
    'HND - Tokyo',
    'SYD - Sydney',
    'DEL - Delhi',
    'CDG - Paris',
    'CPT - Cape Town',
  ];
  RxList passengerList = ['1 Passenger', '2 Passenger', '3 Passenger'].obs;
  RxList classList = ['Economy Class', 'Business Class', 'First Class'].obs;

  RxString fromDestination = ''.obs;
  RxString toDestination = ''.obs;
  final departureDateController = TextEditingController();
  final returnDateController = TextEditingController();
}
