import 'package:flutter/cupertino.dart';

class CupertinoYearPicker extends StatelessWidget {
  final int initialYear;
  final int minYear;
  final int maxYear;
  final ValueChanged<int> onYearChanged;

  const CupertinoYearPicker({
    super.key,
    required this.initialYear,
    required this.minYear,
    required this.maxYear,
    required this.onYearChanged,
  });

  @override
  Widget build(BuildContext context) {
    int initialIndex = initialYear - minYear;
    return Container(
      height: 200.0,
      padding: const EdgeInsets.only(top: 6.0),
      margin: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      color: CupertinoColors.systemBackground.resolveFrom(context),
      child: CupertinoPicker(
        magnification: 1.22,
        squeeze: 1.45,
        itemExtent: 32.0,
        useMagnifier: true,
        onSelectedItemChanged: (int index) {
          int selectedYear = minYear + index;
          onYearChanged(selectedYear);
        },
        scrollController: FixedExtentScrollController(initialItem: initialIndex),
        children: List<Widget>.generate(
          maxYear - minYear + 1,
              (int index) {
            int year = minYear + index;
            return Center(
              child: Text(
                '$year',
                style: const TextStyle(
                  fontSize: 24.0,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
