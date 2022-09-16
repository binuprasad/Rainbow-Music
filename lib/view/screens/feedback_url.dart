import 'package:url_launcher/url_launcher.dart';

class Urifunction {
  emailUriFunction() {
    String email = 'binuprasad2000@gmail.com';
    String subject = 'Feed Back';
    String body = 'Type your feed back here: ';

    String? encodeQueryParameters(Map<String, String> params) {
      return params.entries
          .map((MapEntry<String, String> e) =>
              '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
          .join('&');
    }

    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: email,
      query: encodeQueryParameters(
          <String, String>{'subject': subject, 'body': body}),
    );
    launchUrl(emailUri);
  }


}