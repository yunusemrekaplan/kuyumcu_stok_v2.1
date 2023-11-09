// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

import 'constant.dart';

class DatePickerRow extends StatelessWidget {
  DatePickerRow({
    super.key,
    required this.label,
    required this.startTime,
    required this.endTime,
    required this.selectedTime,
  }) {
    initializeDateFormatting('tr_TR', null);
    dateController.value.text = DateFormat.yMd('tr-Tr').format(selectedTime!);
  }

  late String label;
  late DateTime startTime;
  late DateTime endTime;
  late DateTime? selectedTime;

  final dateController = TextEditingController().obs;

  @override
  Widget build(BuildContext context) {
    return buildRow();
  }

  Row buildRow() {
    return Row(
      children: [
        Text(label, style: const TextStyle(fontSize: labelFontSize)),
        const SizedBox(width: paddingBoxWidth),
        GestureDetector(
          onTap: onTap,
          child: TextFormField(
            controller: dateController.value,
            enabled: false,
            decoration: const InputDecoration(
              constraints: BoxConstraints(maxWidth: maxWidth),
              disabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: borderColor,
                  width: borderWidth,
                ),
              ),
              contentPadding: contentPadding,
            ),
            style: const TextStyle(
              color: textColor,
              fontSize: dateFontSize,
            ),
          ),
        ),
      ],
    );
  }

  void onTap() async {
    Get.dialog(
      datePicker(),
    );
  }

  AlertDialog datePicker() {
    return AlertDialog(
      title: Text(label),
      content: SizedBox(
        width: 300,
        height: 200,
        child: CalendarDatePicker(
          initialDate: selectedTime!,
          firstDate: startTime,
          lastDate: endTime,
          onDateChanged: (date) {
            selectedTime = date;
            var formattedDate = DateFormat(dateFormat).format((selectedTime!));
            var newTime = label == 'Bitiş Tarihi:' ? '23:59:59' : '00:00:00';
            var newFormattedDate = '${formattedDate.substring(0, 11)}$newTime';
            selectedTime = DateFormat(dateFormat).parse(newFormattedDate);
            dateController.value.text = DateFormat.yMd('tr-Tr').format(
              selectedTime!,
            );
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: const Text('Tamam'),
        ),
      ],
    );
  }
}
