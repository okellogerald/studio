import '../source.dart';

class GenderSelector extends StatefulWidget {
  const GenderSelector({
    Key? key,
    required this.title,
    required this.onGenderSelected,
    required this.selectedGender,
  }) : super(key: key);

  final String title;
  final ValueChanged<String> onGenderSelected;
  final String? selectedGender;

  @override
  State<GenderSelector> createState() => _GenderSelectorState();
}

class _GenderSelectorState extends State<GenderSelector> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.dw),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(widget.title, opacity: .7, size: 14.dw),
          SizedBox(height: 8.dh),
          AppTextButton(
            backgroundColor: AppColors.surface,
            onPressed: _showOptionsDialog,
            child: Container(
              width: double.infinity,
              height: 40.dh,
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(horizontal: 10.dw),
              child: AppText(
                  widget.selectedGender?.toUpperCase() ?? 'Tap to select',
                  weight: FontWeight.w500),
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
          widget.onGenderSelected(option);
        },
        borderRadius: 0,
        child: Container(
          height: 40.dh,
          alignment: Alignment.center,
          child: AppText(option),
          width: double.infinity,
        ));
  }
}
