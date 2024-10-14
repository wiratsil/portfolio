import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';

Future<bool> openUrl(String url, {bool newWindow = false}) async {
  if (await canLaunch(url)) {
    return await launch(
      url,
    );
  } else {
    debugPrint("Could not launch $url");
    return false;
  }
}

String buildPackageUrlFromName(String name) {
  return 'https://pub.dev/packages/$name';
}

String buildPublisherUrlFromName(String name) {
  return 'https://$name';
}

String buildSearchUrlFromQuery(String query) {
  return 'https://www.google.com/search?q=$query';
}
