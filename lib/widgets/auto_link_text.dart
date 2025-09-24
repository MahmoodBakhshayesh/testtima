import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:linkify/linkify.dart';
import 'package:url_launcher/url_launcher.dart';

class AutoLinkText extends StatelessWidget {
  final String text;
  const AutoLinkText(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    final elements = linkify(
      text,
      options: const LinkifyOptions(humanize: true),
    );

    return RichText(
      text: TextSpan(
        style: DefaultTextStyle.of(context).style,
        children: elements.map((e) {
          if (e is LinkableElement) {
            return TextSpan(
              text: e.text,
              style: const TextStyle(
                color: Colors.blue,
                decoration: TextDecoration.underline,
              ),
              recognizer: (TapGestureRecognizer()
                ..onTap = () async {
                  final uri = Uri.parse(e.url);
                  if (await canLaunchUrl(uri)) {
                    await launchUrl(uri, mode: LaunchMode.externalApplication);
                  }
                }),
            );
          } else {
            return TextSpan(text: e.text);
          }
        }).toList(),
      ),
    );
  }
}
