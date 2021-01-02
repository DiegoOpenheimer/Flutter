import 'package:flutter/material.dart';

class AboutWidget extends StatelessWidget {

  final Function onPress;

  AboutWidget({ this.onPress });

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        if (onPress == null) {
          return Future.value(true);
        }
        onPress();
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text('About'),
          backgroundColor: Colors.transparent,
          leading: onPress != null ? IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: onPress,
          ) : null,
        ),
        body: _buildBody(context),
      ),
    );
  }

  Widget _buildBody(context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: SingleChildScrollView(
        child: Text('''
          The Chuck Norris app is also on Facebook Messenger. Click the Message Us button below to start a conversation.

You can simply ask a random joke by typing hi, tell me a joke. To get help to get started type help.

Contact: Feel free to tweet ideas, suggestions, help requests and similar to @matchilling or drop me a line at m@matchilling.com

Privacy: The app was a weekend project and is just fun. All we're storing are team and user ids and the appropriate OAuth tokens. This allows you to post these awesome Chuck Norris facts on slack on the appropriate channel. Our applications is hosted on https://aws.amazon.com/privacy. We use a secure connection between slack servers and aws. We anonymously keep track of two data points; the total number of teams and unique users. None of the data will ever be shared, except for maybe some anonymous statistics in the future.
        ''', textAlign: TextAlign.justify, style: Theme.of(context).textTheme.headline5,),
      ),
    );
  }
}