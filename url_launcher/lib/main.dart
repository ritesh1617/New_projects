import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'URL Launcher Demo',
      home: Scaffold(
        appBar: AppBar(
          title: Text('URL Launcher Example'),
        ),
        body: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  void _launchURL() async {
    const url = 'https://flutter.dev';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _makePhoneCall() async {
    const phoneNumber = 'tel:+1234567890';
    if (await canLaunch(phoneNumber)) {
      await launch(phoneNumber);
    } else {
      throw 'Could not launch $phoneNumber';
    }
  }

  void _sendEmail() async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'email@example.com',
      queryParameters: {
        'subject': 'Example Subject',
        'body': 'Hello, this is a test email.'
      },
    );

    if (await canLaunch(emailLaunchUri.toString())) {
      await launch(emailLaunchUri.toString());
    } else {
      throw 'Could not launch email';
    }
  }

  void _sendSMS() async {
    const sms = 'sms:+1234567890?body=Hello, this is a test message';
    if (await canLaunch(sms)) {
      await launch(sms);
    } else {
      throw 'Could not launch SMS';
    }
  }

  void _openGoogleMaps() async {
    const googleMapsUrl = 'https://www.google.com/maps/search/?api=1&query=37.7749,-122.4194';
    if (await canLaunch(googleMapsUrl)) {
      await launch(googleMapsUrl);
    } else {
      throw 'Could not open the map';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ElevatedButton(
            onPressed: _launchURL,
            child: Text('Open Flutter Website'),
          ),
          ElevatedButton(
            onPressed: _makePhoneCall,
            child: Text('Make Phone Call'),
          ),
          ElevatedButton(
            onPressed: _sendEmail,
            child: Text('Send Email'),
          ),
          ElevatedButton(
            onPressed: _sendSMS,
            child: Text('Send SMS'),
          ),
          ElevatedButton(
            onPressed: _openGoogleMaps,
            child: Text('Open Google Maps'),
          ),
        ],
      ),
    );
  }
}
