import '../utils/date_formatter.dart';
import 'app_text_button.dart';
import 'source.dart';
class DateSelector extends StatefulWidget {
  const DateSelector({
    Key? key,
    required this.title,
    required this.onDateSelected,
    required this.date,
  }) : super(key: key);

  final String title;
  final void Function(DateTime) onDateSelected;
  final DateTime date;

  @override
  State<DateSelector> createState() => _DateSelectorState();
}

class _DateSelectorState extends State<DateSelector> {
  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormatter.convertToDMY(widget.date);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.dw),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(widget.title, opacity: .7, size: 14.dw),
          SizedBox(height: 8.dh),
          AppTextButton(
            backgroundColor: AppColors.surface,
            onPressed: _showDatePicker,
            child: Container(
              width: double.infinity,
              height: 40.dh,
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric( horizontal: 10.dw),
              child: AppText(formattedDate, weight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }

  _showDatePicker() async {
    final selectedDate = await showDatePicker(
        context: context,
        initialDate: widget.date,
        firstDate: DateTime(1975),
        lastDate: DateTime.now());

    if (selectedDate != null) widget.onDateSelected(selectedDate);
  }
}
