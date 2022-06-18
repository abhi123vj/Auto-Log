import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:milage_calcualator/constants/app_colors.dart';

class BoarderTextField extends StatefulWidget {
  String hintText;
  TextEditingController controller;
  BoarderTextField({
    required this.controller,
    required this.hintText,
    Key? key,
  }) : super(key: key);

  @override
  State<BoarderTextField> createState() => _BoarderTextFieldState();
}

class _BoarderTextFieldState extends State<BoarderTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(18)),
        border: Border.all(color: AppColors.yellowDark, width: 1),
      ),
      padding: const EdgeInsets.only(
        left: 20,
      ),
      alignment: Alignment.centerLeft,
      child: TextFormField(
        controller: widget.controller,
        keyboardType: TextInputType.numberWithOptions(decimal: true),
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
        ],
        decoration: InputDecoration(
            border: const OutlineInputBorder(
              borderSide: BorderSide.none,
            ),
            hintStyle: const TextStyle(
                fontSize: 14, fontWeight: FontWeight.w400, color: AppColors.yellowPale),
            hintText: widget.hintText),
      ),
    );
  }
}
