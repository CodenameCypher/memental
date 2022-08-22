import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:memental/model/suggestion.dart';
import 'package:memental/services/reminderDatabase.dart';
import 'package:memental/model/reminder.dart';

class SuggestionCard extends StatefulWidget {
  final Suggestion suggestions;

  SuggestionCard({required this.suggestions});

  @override
  State<SuggestionCard> createState() => _SuggestionCardState();
}

class _SuggestionCardState extends State<SuggestionCard> {
  bool starred = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Column(
        children: [
          Card(
            margin: EdgeInsets.symmetric(horizontal: 12, vertical: 0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)
            ),
            child: ListTile(
              leading: Image.network(widget.suggestions.urlPoster, width: 30, height: 50,),
              title: Container(
                margin: EdgeInsets.only(top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.suggestions.name),
                    Text('Type: ${widget.suggestions.type} - ${widget.suggestions.genre}',
                      style: TextStyle(
                        fontFamily: 'formal',
                          color: Colors.grey,
                          fontSize: 12,
                        height: 1.4
                      ),
                    ),
                    SizedBox(height: 3,)
                  ],
                ),
              ),
              subtitle: Container(
                margin: EdgeInsets.only(bottom: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Duration: ${widget.suggestions.duration} minutes',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                        fontWeight: FontWeight.w300,
                        fontFamily: 'Formal',
                          height: 1
                      ),
                    ),
                  ],
                ),
              ),
              trailing: IconButton(
                onPressed: () async{
                  setState(() {
                    starred = true;
                  });
                  Reminder reminder = Reminder(
                      userUID: FirebaseAuth.instance.currentUser!.uid,
                      subject: '${widget.suggestions.type} - ${widget.suggestions.name}',
                      startTime: DateTime.now(),
                      endTime: DateTime.now().add(Duration(minutes: int.parse(widget.suggestions.duration)))
                  );
                  await ReminderDatabase().createReminder(reminder);
                },
                icon: starred ? Icon(Icons.star) : Icon(Icons.star_border),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
