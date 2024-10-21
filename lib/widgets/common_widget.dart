// ignore_for_file: must_be_immutable

import 'package:flight_booking/pages/constants/app.assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TravelCard extends StatelessWidget {
  final String imageUrl;
  final String destination;
  final String description;
  final double width;
  final double height;

  const TravelCard(
      {super.key,
      required this.imageUrl,
      required this.width,
      required this.height,
      required this.destination,
      required this.description});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.only(right: 10),
          height: height,
          width: width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            image: DecorationImage(
              image: AssetImage(imageUrl),
              fit: BoxFit.fill,
            ),
          ),
        ),
        Positioned(
          bottom: 20,
          left: 20,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                description,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                description != "" ? "Economy round trip" : "",
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(destination,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  )),
            ],
          ),
        ),
      ],
    );
  }
}

class FlightBookingCard extends StatelessWidget {
  FlightBookingCard(
      {super.key, required this.fromDestination, required this.toDestination});

  String fromDestination, toDestination;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          flightInfoRow(
            'Onward - Garuda Indonesia',
            'AED 409',
            '14:35',
            '21:55',
            fromDestination,
            toDestination,
            '4h 30m',
            '2 Stops',
          ),
          Divider(thickness: 1, color: Colors.grey[300]),
          flightInfoRow(
            'Return - Garuda Indonesia',
            'AED 359',
            '21:55',
            '14:35',
            toDestination,
            fromDestination,
            '4h 30m',
            '',
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  tagChip('Cheapest', Colors.green),
                  const SizedBox(width: 8),
                  tagChip('Refundable', Colors.blue),
                ],
              ),
              const Text(
                'Flight Details',
                style: TextStyle(
                  color: Colors.orange,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget flightInfoRow(
      String title,
      String price,
      String departureTime,
      String arrivalTime,
      String departureCity,
      String arrivalCity,
      String duration,
      String stops) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SvgPicture.asset(MyAppAssets.companyLogo),
                const SizedBox(width: 5),
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            Text(
              price,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.green,
                fontSize: 16,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              departureTime,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            SvgPicture.asset(MyAppAssets.planeLine),
            Text(
              arrivalTime,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(departureCity),
            Text(duration),
            Text(arrivalCity),
          ],
        ),
        const SizedBox(height: 4),
        if (stops.isNotEmpty)
          Center(
            child: Text(
              stops,
              style: const TextStyle(
                color: Colors.grey,
              ),
            ),
          ),
      ],
    );
  }

  Widget tagChip(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(color: color),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
