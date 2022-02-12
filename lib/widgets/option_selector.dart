import '../source.dart';

class OptionSelector extends StatefulWidget {
  const OptionSelector({
    Key? key,
    required this.title,
    required this.onValueSelected,
    required this.value,
  }) : super(key: key);

  final String title;
  final ValueChanged<String> onValueSelected;
  final String? value;

  @override
  State<OptionSelector> createState() => _OptionSelectorState();
}

class _OptionSelectorState extends State<OptionSelector> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.dw),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(widget.title, opacity: .7),
          SizedBox(height: 8.dh),
          AppTextButton(
            isFilled: false,
            onPressed: _showOptionsDialog,
            child: Container(
              color: AppColors.surface,
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 8.dh, horizontal: 10.dw),
              child: AppText(widget.value?.toUpperCase() ?? 'Tap to select',
                  weight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  _showOptionsDialog() {
    showDialog(
        context: context,
        builder: (_) {
          return Dialog(
            child: SizedBox(
              height: 165.dh,
              child: Column(
                children: [
                  _buildTitle(),
                  _buildOption('Male'),
                  const AppDivider(height: 1, margin: EdgeInsets.zero),
                  _buildOption('Female'),
                  const AppDivider(height: 1, margin: EdgeInsets.zero),
                  _buildOption('Other'),
                ],
              ),
            ),
          );
        });
  }

  _buildTitle() {
    return Container(
      height: 40.dh,
      width: double.infinity,
      alignment: Alignment.center,
      color: AppColors.primary,
      child: AppText('Choose Gender'.toUpperCase(), color: AppColors.onPrimary),
    );
  }

  _buildOption(String option) {
    return AppTextButton(
        onPressed: () {
          Navigator.pop(context);
          widget.onValueSelected(option);
        },
        borderRadius: 0,
        isFilled: false,
        child: Container(
          height: 40.dh,
          alignment: Alignment.center,
          child: AppText(option, weight: FontWeight.bold),
          width: double.infinity,
        ));
  }
}
