import 'package:flutter/material.dart';

class CustomButtonData {
  final IconData icon;
  final String text;

  CustomButtonData(this.icon, this.text);
}

class CustomButton extends StatelessWidget {
  final CustomButtonData data;
  final VoidCallback onPressed;

  const CustomButton({
    Key? key,
    required this.data,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, left: 10, right: 10),
      child: Container(
        child: ElevatedButton.icon(
          onPressed: onPressed,
          icon: Icon(
            data.icon,
            color: Colors.black,
            size: 35,
          ),
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
          label: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              data.text,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
