// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../entries/entries_controller.dart';
import '../../sales/sales_controller.dart';
import 'constant.dart';

class DatePickerRow extends StatelessWidget {
  DatePickerRow({
    super.key,
    required this.label,
    required this.selectedTime,
    required this.dateController,
    this.isSales = false,
    this.isEntries = false,
  });

  late bool isSales;
  late bool isEntries;
  late String label;
  late DateTime selectedTime;
  late TextEditingController dateController;

  final _salesController = Get.find<SalesController>();
  final _entriesController = Get.find<EntriesController>();

  @override
  Widget build(BuildContext context) {
    dateController.text = DateFormat.yMd('tr-Tr').format(selectedTime);
    return buildRow();
  }

  Row buildRow() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(label, style: const TextStyle(fontSize: labelFontSize)),
        const SizedBox(width: paddingBoxWidth),
        GestureDetector(
          onTap: onTap,
          child: TextFormField(
            controller: dateController,
            enabled: false,
            decoration: const InputDecoration(
              constraints: BoxConstraints(
                maxWidth: maxWidth,
                maxHeight: maxHeight,
              ),
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

  void onTap() {
    showDialog(context: Get.context!, builder: (_) => datePicker());
  }

  AlertDialog datePicker() {
    return AlertDialog(
      content: SizedBox(
        width: datePickerBoxWidth,
        height: datePickerBoxHeight,
        child: CalendarDatePicker(
          initialDate: selectedTime,
          firstDate: startTime,
          lastDate: endTime,
          onDateChanged: (date) {
            bool state = label == 'Bitiş Tarihi:' ? true : false;
            var formattedDate = DateFormat(dateFormat).format((date));
            var newTime = label == 'Bitiş Tarihi:' ? '23:59:59' : '00:00:00';
            var newFormattedDate = '${formattedDate.substring(0, 11)}$newTime';
            selectedTime = DateFormat(dateFormat).parse(newFormattedDate);
            dateController.text = DateFormat.yMd('tr-Tr').format(
              selectedTime,
            );
            isSales
                ? (state
                    ? _salesController.selectedEndTime = selectedTime
                    : _salesController.selectedStartTime = selectedTime)
                : (state
                    ? _entriesController.selectedEndTime = selectedTime
                    : _entriesController.selectedStartTime = selectedTime);
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
