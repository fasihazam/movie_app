import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:movie_app/core/config/app_colors.dart';
import 'package:movie_app/core/utils/size_utils.dart';
import 'package:movie_app/features/presentation/pages/ticket_selection_screen.dart';

class SeatMappingScreen extends StatefulWidget {
  final String movieName;
  final String releaseDate;

  const SeatMappingScreen(
      {super.key, required this.movieName, required this.releaseDate});

  @override
  SeatMappingScreenState createState() => SeatMappingScreenState();
}

class SeatMappingScreenState extends State<SeatMappingScreen> {
  String? _selectedDate;

  @override
  Widget build(BuildContext context) {
    String formattedReleaseDate = _formatReleaseDate(widget.releaseDate);

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Padding(
            padding: EdgeInsets.only(right: 36.w),
            child: Column(
              children: [
                Text(
                  widget.movieName,
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  formattedReleaseDate,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: AppColors.inputBorder,
                  ),
                ),
              ],
            ),
          ),
        ),
        backgroundColor: AppColors.onPrimary,
        elevation: 8,
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Select Date",
                    style: GoogleFonts.poppins(
                        fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 10),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(7, (index) {
                        DateTime date =
                            DateTime.now().add(Duration(days: index));
                        String formattedDate = DateFormat('d MMM').format(date);

                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedDate = formattedDate;
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.only(right: 12),
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            decoration: BoxDecoration(
                              color: _selectedDate == formattedDate
                                  ? AppColors.inputBorder
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              formattedDate,
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                color: _selectedDate == formattedDate
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                if (_selectedDate != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TicketSelectScreen(),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Please select a date."),
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 6,
                  backgroundColor: AppColors.inputBorder),
              child: Text("Select Seats",
                  style: GoogleFonts.poppins(
                      fontSize: 18, color: AppColors.onPrimary)),
            ),
          ),
        ],
      ),
    );
  }

  String _formatReleaseDate(String releaseDate) {
    try {
      final DateFormat inputFormat = DateFormat('yyyy-MM-dd');
      final DateFormat outputFormat = DateFormat('MMMM dd, yyyy');
      final date = inputFormat.parse(releaseDate);
      return outputFormat.format(date);
    } catch (e) {
      return 'Release Date: $releaseDate';
    }
  }
}
