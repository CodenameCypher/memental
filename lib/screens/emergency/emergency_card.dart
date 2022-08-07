import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:memental/model/hospitals.dart';
import 'package:url_launcher/url_launcher.dart';

class EmergencyCard extends StatelessWidget {
  Hospital hospitalObject;

  EmergencyCard({required this.hospitalObject});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10),
      child: FlipCard(
        fill: Fill.fillBack,
        front: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: Colors.white
          ),
          margin: EdgeInsets.fromLTRB(12.0, 6.0, 12.0, 0.0),
          padding: EdgeInsets.fromLTRB(6.0, 12.0, 6.0, 12.0),
          child: ListTile(
            leading: CircleAvatar(
              radius: 25,
              backgroundColor: Colors.white,
              backgroundImage: NetworkImage('https://seeklogo.com/images/H/hospital-clinic-plus-logo-7916383C7A-seeklogo.com.png'),
            ),
            title: Text(
                hospitalObject.hospital_name,
              style: TextStyle(
                fontFamily: 'Formal'
              ),
            ),
            subtitle: Text(
                'Location: '+hospitalObject.location + '\nFare: ' + hospitalObject.fare,
              style: TextStyle(
                  fontFamily: 'Formal',
                height: 1.4
              ),

            ),
            trailing: IconButton(
              color: Colors.grey[600],
                onPressed: () async{
                  await launchUrl(
                      Uri(path: "+88${hospitalObject.number}", scheme: 'tel')
                  );
                },
                icon: Icon(Icons.phone),
              splashColor: Colors.greenAccent[100],
            ),
          ),
        ),
        back: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: hospitalObject.availability? Colors.green[300] : Colors.red[300],
          ),
          padding: EdgeInsets.fromLTRB(6.0, 13.0, 6.0, 12.0),
          margin: EdgeInsets.fromLTRB(12.0, 6.0, 12.0, 0.0),
          child: ListTile(
            leading: CircleAvatar(
              radius: 25,
              backgroundColor: Colors.white,
              backgroundImage: NetworkImage('https://seeklogo.com/images/H/hospital-clinic-plus-logo-7916383C7A-seeklogo.com.png'),
            ),
            title: Text(
              "Available: ${hospitalObject.availability? 'Yes' : 'No'}",
              style: TextStyle(
                  fontFamily: 'Formal',
                color: Colors.black
              ),
            ),
            subtitle: Text(
              'Location: '+hospitalObject.location + '\nFare: ' + hospitalObject.fare,
              style: TextStyle(
                  fontFamily: 'Formal',
                  color: Colors.grey[800],
                  height: 1.4
              ),

            ),
            trailing: IconButton(
              color: Colors.grey[600],
              onPressed: () async{
                await launchUrl(
                    Uri(path: "+88${hospitalObject.number}", scheme: 'tel')
                );
              },
              icon: Icon(Icons.phone, color: Colors.white,),
              splashColor: Colors.greenAccent[100],
            ),
          ),
        )
      )
    );
  }
}
