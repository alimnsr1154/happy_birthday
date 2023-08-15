
import 'package:flutter/material.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
              left: 16.0, right: 16.0, top: 36.0, bottom: 36),
          child: Card(
            elevation: 10,
            shadowColor: Colors.lightBlue,
            child: Padding(
              padding: EdgeInsets.only(left: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Wishing you a very happy birthday filled with joy, laughter, and cherished moments! May this special day be a reflection of the incredible person you are, surrounded by the love and warmth of those who hold you dear. May the year ahead bring you countless opportunities, adventures, and success in all your endeavors. Celebrate this day to the fullest, knowing that you are appreciated and celebrated not just today, but every day. Here's to another year of making memories and achieving dreams. Happy birthday! 🎉🎂🎈",
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Satisfy'

                    ),),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('Ali Mansoor', style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Caveat'

                      ),),
                      SizedBox(width: 10,)
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

