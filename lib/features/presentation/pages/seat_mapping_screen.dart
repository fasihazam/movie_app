import 'package:flutter/material.dart';

class SeatMappingScreen extends StatefulWidget {
  const SeatMappingScreen({super.key});

  @override
  SeatMappingScreenState createState() => SeatMappingScreenState();
}

class SeatMappingScreenState extends State<SeatMappingScreen> {
  final List<bool> _selectedSeats = List.generate(20, (_) => false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Seat Mapping',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.grey,
        elevation: 8,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            GridView.builder(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                crossAxisSpacing: 12.0,
                mainAxisSpacing: 12.0,
              ),
              itemCount: 20,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedSeats[index] = !_selectedSeats[index];
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: _selectedSeats[index]
                          ? Colors.grey
                          : Colors.grey[300],
                      borderRadius: BorderRadius.circular(12.0),
                      boxShadow: [
                        BoxShadow(
                          color: _selectedSeats[index]
                              ? Colors.grey
                              : Colors.black26,
                          blurRadius: 8.0,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        'Seat ${index + 1}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: _selectedSeats[index]
                              ? Colors.white
                              : Colors.black87,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                final selectedSeats = _selectedSeats
                    .asMap()
                    .entries
                    .where((entry) => entry.value)
                    .map((entry) => entry.key + 1)
                    .toList();
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Seats Selected'),
                      content: Text(
                          'You have selected the following seats: $selectedSeats'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Close',
                              style: TextStyle(color: Colors.black)),
                        ),
                      ],
                    );
                  },
                );
              },
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                iconColor: Colors.orangeAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 6,
              ),
              child: const Text("Book Seats",
                  style: TextStyle(fontSize: 18, color: Colors.black)),
            ),
          ],
        ),
      ),
    );
  }
}
