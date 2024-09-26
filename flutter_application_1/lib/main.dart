import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Launcher Example',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Launcher Demo'),
        ),
        body: LauncherDemo(),
      ),
    );
  }
}

class LauncherDemo extends StatelessWidget {
  // Make a phone call
  void dialPhone() async {
    final Uri phoneUri = Uri(scheme: 'tel', path: '+91 9327019854');
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    } else {
      throw 'Could not dial $phoneUri';
    }
  }

  // Open a website
  void openWebsite() async {
    final Uri webUri = Uri(scheme: 'https', host: 'www.facebook.com');
    if (await canLaunchUrl(webUri)) {
      await launchUrl(webUri);
    } else {
      throw 'Could not launch $webUri';
    }
  }

  // Send an SMS
  void sendSMS() async {
    final Uri smsUri = Uri(scheme: 'sms', path: '+91 9512040898');
    if (await canLaunchUrl(smsUri)) {
      await launchUrl(smsUri);
    } else {
      throw 'Could not send SMS to $smsUri';
    }
  }

  // Send an email
  void sendEmail() async {
    final Uri emailUri =
        Uri(scheme: 'mailto', path: 'patelritesh6448@gmail.com');
    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      throw 'Could not send email to $emailUri';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          ElevatedButton(
            onPressed: dialPhone,
            child: Text('Dial Phone'),
          ),
          ElevatedButton(
            onPressed: openWebsite,
            child: Text('Open Facebook'),
          ),
          ElevatedButton(
            onPressed: sendSMS,
            child: Text('Send SMS'),
          ),
          ElevatedButton(
            onPressed: sendEmail,
            child: Text('Send Email'),
          ),
        ],
      ),
    );
  }
}
