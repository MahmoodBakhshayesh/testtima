import 'package:abds/widgets/MyButton.dart';
import 'package:flutter/material.dart';

class ImagePickMethodSelectSheet extends StatelessWidget {
  const ImagePickMethodSelectSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: true,
      child: Container(
        padding: EdgeInsets.only(left: 12,right: 12,top: 36),
        child: Row(
          spacing: 12,
          children: [
            Expanded(
              child: MyButton(
                height: 75,
                label: "Gallery",
                onPressed: () {
                  Navigator.of(context).pop(1);
                },
                icon: Icons.photo,
              ),
            ),
            Expanded(
              child: MyButton(
                label: "Camera",
                height: 75,
                onPressed: () {
                  Navigator.of(context).pop(2);
                },
                icon: Icons.camera,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
