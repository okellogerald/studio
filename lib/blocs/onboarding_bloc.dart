import '../source.dart';

class OnBoardingPagesBloc extends Cubit<OnBoardingPagesState> {
  OnBoardingPagesBloc(this.service) : super(OnBoardingPagesState.initial());

  final UserService service;

  void initCoursesPageState() async {
    var supp = state.supplements;
    emit(OnBoardingPagesState.laoding(supp, message: 'fetching courses ...'));

    try {
      final courseList = await OnBoardingApi.getAllCategories();
      final courseTypes = _getCourseTypes(courseList);
      supp = supp.copyWith(courseList: courseList, courseTypes: courseTypes);
      emit(OnBoardingPagesState.content(supp));
    } on ApiError catch (_) {
      emit(OnBoardingPagesState.failed(supp, _.message));
    }
  }

  List<String> _getCourseTypes(List<Course> courseList) {
    final types = <String>[];

    for (Course course in courseList) {
      if (!types.contains(course.type)) types.add(course.type);
    }

    return types;
  }

  void updateAttributes(
      {String? email,
      String? password,
      String? confirmationPassword,
      String? name,
      String? courseId,
      String? gradeId,
      String? level,
      String? gender,
      DateTime? dateOfBirth}) {
    var supp = state.supplements;
    emit(OnBoardingPagesState.laoding(supp));

    var user = supp.user;
    user = user.copyWith(
        email: email ?? user.email,
        name: name ?? user.name,
        gender: gender ?? user.gender,
        dateOfBirth: dateOfBirth ?? user.dateOfBirth,
        level: level ?? user.level,
        courseId: courseId ?? user.courseId,
        gradeId: gradeId ?? user.gradeId);

    supp = supp.copyWith(
      password: password ?? supp.password,
      confirmationPassword: confirmationPassword ?? supp.confirmationPassword,
      user: user,
    );
    emit(OnBoardingPagesState.content(supp));
  }

  _validate() {
    var supp = state.supplements;
    emit(OnBoardingPagesState.laoding(supp));

    final errors = <String, String?>{};

    errors['email'] = InputValidation.validateText(supp.user.email, 'Email');
    errors['password'] =
        InputValidation.validateText(supp.password, 'Password');
    errors['confirm_password'] = InputValidation.validateText(
        supp.confirmationPassword, 'Confirmation Password');
    if (errors['password'] == null && errors['confirm_password'] == null) {
      errors['confirm_password'] = InputValidation.checkIfPasswordsMatch(
          supp.password, supp.confirmationPassword);
    }

    supp = supp.copyWith(errors: errors);
    emit(OnBoardingPagesState.content(supp));
  }

  _validateWelcomeDetails() {
    var supp = state.supplements;
    emit(OnBoardingPagesState.laoding(supp));

    final errors = <String, String?>{};

    errors['name'] = InputValidation.validateText(supp.user.name, 'Name');
    supp = supp.copyWith(errors: errors);
    emit(OnBoardingPagesState.content(supp));
  }

  void saveWelcomeDetails() async {
    _validateWelcomeDetails();

    var supp = state.supplements;
    final hasErrors = InputValidation.checkErrors(supp.errors);
    if (hasErrors) return;

    emit(OnBoardingPagesState.success(supp));
  }

  void signUp() async {
    _validate();

    var supp = state.supplements;
    final hasErrors = InputValidation.checkErrors(supp.errors);
    if (hasErrors) return;

    try {
      //   await service.signup(email: supp.user.email, password: supp.password);
      emit(OnBoardingPagesState.success(supp));
    } on ApiError catch (e) {
      emit(OnBoardingPagesState.failed(supp, e.message));
    }
  }
}
