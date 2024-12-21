import 'package:flutter/material.dart';
import 'package:movie_app/core/config/app_colors.dart';
import 'package:movie_app/core/shared_widgets/text_widget.dart';
import 'package:movie_app/core/utils/size_utils.dart';
import 'package:movie_app/features/data/models/seats_model.dart';
import 'package:movie_app/features/seatbooking/curved_screen.dart';
import 'package:movie_app/features/seatbooking/seat_color.dart';
import 'package:movie_app/features/seatbooking/seat_widget.dart';

class TicketSelectScreen extends StatefulWidget {
  const TicketSelectScreen({super.key});

  @override
  TicketSelectScreenState createState() => TicketSelectScreenState();
}

class TicketSelectScreenState extends State<TicketSelectScreen> {
  final ScrollController _screenScrollController = ScrollController();
  final double _screenWidth = 400.w;

  List<SeatModel> seats = [];

  @override
  void initState() {
    super.initState();
    _initializeSeats(10, 10);
  }

  // Initialize the seats list
  void _initializeSeats(int rows, int columns) {
    List<SeatModel> seatList = [];
    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < columns; j++) {
        seatList.add(SeatModel(row: i + 1, number: j + 1, isSelected: false));
      }
    }
    setState(() {
      seats = seatList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Your Seats'),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            CurvedScreen(
              screenScrollController: _screenScrollController,
              screenWidth: _screenWidth,
            ),
            const Center(child: TextWidget('Screen')),
            const SizedBox(height: 20),
            Row(
              children: [
                Column(
                  children: List.generate(10, (index) {
                    return Text(
                      '${index + 1}',
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    );
                  }),
                ),
                const SizedBox(width: 10),
                Flexible(
                  child: GridView.builder(
                    shrinkWrap: true,
                    itemCount: seats.length,
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 20,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemBuilder: (ctx, index) {
                      final seat = seats[index];
                      return SeatWidget(
                        seat: seat,
                        onSeatSelected: (seat) {
                          setState(() {
                            seat.isSelected = !seat.isSelected;
                          });
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 30.h),
            const SeatColorIndicators(),
            const SizedBox(height: 20),
            PurchaseSeatsButton(seats: seats),
          ],
        ),
      ),
    );
  }
}

class PurchaseSeatsButton extends StatelessWidget {
  final List<SeatModel> seats;

  const PurchaseSeatsButton({super.key, required this.seats});

  @override
  Widget build(BuildContext context) {
    final selectedSeats = seats.where((seat) => seat.isSelected).toList();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ElevatedButton(
        onPressed: selectedSeats.isNotEmpty ? () {} : null,
        style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 6,
            backgroundColor: AppColors.inputBorder),
        child: Center(
          child: Text(
            'Purchase - ${selectedSeats.length} Seats',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
