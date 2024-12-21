import 'package:flutter/material.dart';
import 'package:movie_app/features/data/models/seats_model.dart';

class SeatWidget extends StatelessWidget {
  final SeatModel seat;
  final Function(SeatModel) onSeatSelected;

  const SeatWidget(
      {super.key, required this.seat, required this.onSeatSelected});

  @override
  Widget build(BuildContext context) {
    final isSelected = seat.isSelected;

    return GestureDetector(
      onTap: () {
        onSeatSelected(seat);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          color: isSelected ? Colors.red : Colors.white,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: Colors.black,
            width: 1,
          ),
        ),
      ),
    );
  }
}
