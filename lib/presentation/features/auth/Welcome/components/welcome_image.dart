import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/constants.dart';
import '../../../../core/controllers/responsive.dart';

class WelcomeImage extends StatefulWidget {
  const WelcomeImage({
    super.key,
  });

  @override
  State<WelcomeImage> createState() => _WelcomeImageState();
}

class _WelcomeImageState extends State<WelcomeImage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Bienvenido a Vistony Dashboard",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: defaultPadding * 2),
        if(Responsive.isDesktop(context))
        Row(
          children: [
            const Spacer(),
            Expanded(
              flex: 8,
              child: SvgPicture.asset(
                "assets/icons/chat.svg",
              ),
            ),
            const Spacer(),
          ],
        ),
        const SizedBox(height: defaultPadding * 2),
      ],
    );
  }
}