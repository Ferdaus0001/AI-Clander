import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class MyCalendarPage extends StatefulWidget {
  const MyCalendarPage({super.key});

  @override
  _MyCalendarPageState createState() => _MyCalendarPageState();
}

class _MyCalendarPageState extends State<MyCalendarPage> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(180),
        child: AppBar(
          automaticallyImplyLeading: false,
          flexibleSpace: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(
                getSeasonImage(_focusedDay.month),
                fit: BoxFit.cover,
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.black.withOpacity(0.6), Colors.transparent],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    'My Calendar',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )
            ],
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          Card(
            color: Colors.white,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 16,
            shadowColor: Colors.black26,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: TableCalendar(
                currentDay: DateTime.now(),
                calendarFormat: CalendarFormat.month,
                startingDayOfWeek: StartingDayOfWeek.monday,
                locale: 'en_US',
                dayHitTestBehavior: HitTestBehavior.deferToChild,
                availableCalendarFormats: {
                  CalendarFormat.month: 'Month',
                  CalendarFormat.twoWeeks: _weeksLeftInMonthText(),
                  CalendarFormat.week: '1 Week',
                },
                daysOfWeekHeight: 40,
                daysOfWeekStyle: DaysOfWeekStyle(
                  weekdayStyle: const TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                  ),
                  weekendStyle: const TextStyle(
                    color: Colors.redAccent,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                daysOfWeekVisible: true,
                enabledDayPredicate: (day) {
                  return true; //All days selectable
                },
                formatAnimationCurve: Curves.easeInOut,
                formatAnimationDuration: const Duration(milliseconds: 300),
                rowHeight: 60,
                weekendDays: const [DateTime.saturday, DateTime.sunday],
                firstDay: DateTime(2024, 1, 1),
                lastDay: DateTime(2050, 12, 31),
                focusedDay: _focusedDay,
                selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                  });

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Selected: ${selectedDay.toLocal()}")),
                  );
                },
                calendarStyle: CalendarStyle(
                  outsideDaysVisible: false,
                  isTodayHighlighted: true,
                  todayDecoration: BoxDecoration(
                    color: Colors.orange.shade600,
                    shape: BoxShape.circle,
                  ),
                  selectedDecoration: BoxDecoration(
                    color: Colors.blue.shade600,
                    shape: BoxShape.circle,
                  ),
                  defaultTextStyle: const TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.w500,
                  ),
                  weekendTextStyle: const TextStyle(
                    color: Colors.redAccent,
                  ),
                ),
                calendarBuilders: CalendarBuilders(
                  defaultBuilder: (context, day, focusedDay) {
                    if (day.weekday == DateTime.friday) {
                      return null;
                    } else {
                      return Container(
                        margin: const EdgeInsets.all(6.0),
                        alignment: Alignment.center,
                        child: Text(
                          '${day.day}',
                          style: const TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 🔁 Helper: Get image based on month
  String getSeasonImage(int month) {
    return 'assets/image/R.jpg'; // Static for now
  }

  /// 🔁 Helper: Get dynamic text for 2 Weeks format
  String _weeksLeftInMonthText() {
    DateTime now = DateTime.now();
    int daysInMonth = DateTime(now.year, now.month + 1, 0).day;
    int remainingDays = daysInMonth - now.day;
    int remainingWeeks = (remainingDays / 7).ceil();

    if (remainingWeeks <= 0) return 'Final Week!';
    return '$remainingWeeks week${remainingWeeks > 1 ? 's' : ''} left';
  }
}
