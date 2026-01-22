import 'package:url_launcher/url_launcher.dart';

Future<void> launchUrlSocialMedia({required Uri url}) async {
  final Uri url0 = url;

  if (!await launchUrl(url0)) {
    throw Exception('Could not launch $url0');
  }
}
