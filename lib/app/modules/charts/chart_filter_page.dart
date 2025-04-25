import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/app/modules/charts/charts_controller.dart';
import '/app/modules/charts/widgets/cupertino_year_picker.dart';
import './widgets/filter/index.dart';
import '/app/core/components/my_form_page.dart';
import '/app/core/components/form/my_form_date.dart';
import '/generated/locales.g.dart';
import 'package:flutter/cupertino.dart';


class ChartFilterPage extends StatelessWidget {

  const ChartFilterPage({super.key});

  void _showYearPicker(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) {
        return CupertinoYearPicker(
          initialYear: DateTime.now().year,
          minYear: 2000,
          maxYear: DateTime.now().year,
          onYearChanged: (int selectedYear) {
            Get.find<ChartsController>().setTime4(selectedYear);
            });
            // 在此处执行其他操作，例如关闭弹窗
            Navigator.pop(context);
          },
        );
  }

  void _showMouthYearDialog(BuildContext context) {
    showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) => Container(
          height: 216,
          padding: const EdgeInsets.only(top: 6.0),
          // The Bottom margin is provided to align the popup above the system
          // navigation bar.
          margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          // Provide a background color for the popup.
          color: CupertinoColors.systemBackground.resolveFrom(context),
          // Use a SafeArea widget to avoid system overlaps.
          child: SafeArea(
            top: false,
            child: CupertinoDatePicker(
              initialDateTime: DateTime.fromMillisecondsSinceEpoch(DateTime.now().millisecondsSinceEpoch),
              mode: CupertinoDatePickerMode.monthYear,
              maximumDate: DateTime.now(),
              use24hFormat: true,
              // This is called when the user changes the date.
              onDateTimeChanged: (DateTime newDate) {
                Get.find<ChartsController>().setTime3(newDate);
              },
            ),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return MyFormPage(
      title: Text(LocaleKeys.flow_filterPageTitle.tr),
      actions: [
        IconButton(
          icon: const Icon(Icons.done),
          onPressed: () {
            Get.find<ChartsController>().reload();
            Get.back();
          },
        )
      ],
      children: [
        const Book(),
        const FilterTitle(),
        const MinTime(),
        const MaxTime(),
        const Category(),
        const FilterTag(),
        const Payee(),
        const Account(),
        const SizedBox(height: 70),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            icon: const Icon(Icons.done),
            onPressed: () {
              Get.find<ChartsController>().reload();
              Get.back();
            },
            label: Text(LocaleKeys.common_submit.tr)
          ),
        ),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              Get.find<ChartsController>().reset();
            },
            label: Text(LocaleKeys.common_reset.tr)
          ),
        ),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            icon: const Icon(Icons.schedule),
            onPressed: () {
              Get.find<ChartsController>().setTime1();
            },
            label: Text(LocaleKeys.chart_searchTime1.tr)
          ),
        ),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
              icon: const Icon(Icons.schedule),
              onPressed: () {
                Get.find<ChartsController>().setTime2();
              },
              label: Text(LocaleKeys.chart_searchTime2.tr)
          ),
        ),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
              icon: const Icon(Icons.schedule),
              onPressed: () {
                Get.find<ChartsController>().setTime3(DateTime.now());
                _showMouthYearDialog(context);
              },
              label: Text(LocaleKeys.chart_searchTime3.tr)
          ),
        ),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
              icon: const Icon(Icons.schedule),
              onPressed: () {
                Get.find<ChartsController>().setTime4(DateTime.now().year);
                _showYearPicker(context);
              },
              label: Text(LocaleKeys.chart_searchTime4.tr)
          ),
        ),
      ],
    );
  }



}