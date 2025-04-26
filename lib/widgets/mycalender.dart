import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  // Map to store events
  Map<DateTime, String> events = {
    DateTime.utc(2025, 4, 27): "Coding Event!",
    DateTime.utc(2025, 5, 1): "Holiday - Labor Day",
    DateTime.utc(2025, 5, 10): "Team Meeting",
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Calendar with Events & Dots')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TableCalendar(
          firstDay: DateTime.utc(2020, 1, 1),
          lastDay: DateTime.utc(2030, 12, 31),
          focusedDay: _focusedDay,
          selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
          eventLoader: (day) {
            // Check if this day has an event
            if (events.containsKey(
              DateTime.utc(day.year, day.month, day.day),
            )) {
              return [events[DateTime.utc(day.year, day.month, day.day)]!];
            }
            return [];
          },
          onDaySelected: (selectedDay, focusedDay) {
            setState(() {
              _selectedDay = selectedDay;
              _focusedDay = focusedDay;
            });

            String? event =
                events[DateTime.utc(
                  selectedDay.year,
                  selectedDay.month,
                  selectedDay.day,
                )];

            if (event != null) {
              _showEventDialog(event);
            }
          },
          onDayLongPressed: (selectedDay, focusedDay) {
            setState(() {
              _selectedDay = selectedDay;
              _focusedDay = focusedDay;
            });

            _showEditEventDialog(selectedDay);
          },
          calendarStyle: const CalendarStyle(
            todayDecoration: BoxDecoration(
              color: Colors.orange,
              shape: BoxShape.circle,
            ),
            selectedDecoration: BoxDecoration(
              color: Colors.blue,
              shape: BoxShape.circle,
            ),
            markerDecoration: BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
            ),
          ),
          headerStyle: const HeaderStyle(
            formatButtonVisible: false,
            titleCentered: true,
          ),
        ),
      ),
    );
  }

  void _showEventDialog(String eventText) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text("Event Info"),
            content: Text(eventText),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("OK"),
              ),
            ],
          ),
    );
  }

  void _showEditEventDialog(DateTime selectedDay) {
    TextEditingController _controller = TextEditingController();
    String? existingEvent =
        events[DateTime.utc(
          selectedDay.year,
          selectedDay.month,
          selectedDay.day,
        )];

    if (existingEvent != null) {
      _controller.text = existingEvent;
    }

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text(existingEvent == null ? "Add Event" : "Edit Event"),
            content: TextField(
              controller: _controller,
              decoration: const InputDecoration(
                hintText: "Enter event details",
              ),
            ),
            actions: [
              if (existingEvent != null)
                TextButton(
                  onPressed: () {
                    setState(() {
                      events.remove(
                        DateTime.utc(
                          selectedDay.year,
                          selectedDay.month,
                          selectedDay.day,
                        ),
                      );
                    });
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Delete",
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancel"),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    events[DateTime.utc(
                          selectedDay.year,
                          selectedDay.month,
                          selectedDay.day,
                        )] =
                        _controller.text;
                  });
                  Navigator.pop(context);
                },
                child: const Text("Save"),
              ),
            ],
          ),
    );
  }
}
