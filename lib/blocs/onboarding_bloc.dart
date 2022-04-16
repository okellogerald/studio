import '../errors/app_error.dart';
import '../manager/user/user_actions.dart';
import '../source.dart';

class OnBoardingPagesBloc extends Cubit<OnBoardingPagesState> {
  OnBoardingPagesBloc(this.service) : super(OnBoardingPagesState.initial());

  final UserService service;

  void init(Pages page) {
    if (page == Pages.coursesPage) return _initCoursesPageState();
    emit(OnBoardingPagesState.content(page, state.supplements));
  }

  void _initCoursesPageState() async {
    var supp = state.supplements;
    emit(OnBoardingPagesState.laoding(Pages.coursesPage, supp,
        message: 'fetching courses ...'));

    try {
      final courseList = await OnBoardingApi.getAllCategories();
      final courseTypes = _getCourseTypes(courseList);
      supp = supp.copyWith(courseList: courseList, courseTypes: courseTypes);
      emit(OnBoardingPagesState.content(state.page, supp));
    } on ApiError catch (_) {
      emit(OnBoardingPagesState.failed(
          state.page, supp, AppError.onBody(_.message)));
    }
  }

  void updateAttributes(
      {String? email,
      String? password,
      String? confirmationPassword,
      String? name,
      int? courseId,
      int? gradeId,
      String? level,
      String? gender,
      DateTime? dateOfBirth}) {
    var supp = state.supplements;
    emit(OnBoardingPagesState.laoding(state.page, supp));

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
    emit(OnBoardingPagesState.content(state.page, supp));
  }

  void saveWelcomeDetails() async {
    _validateWelcomeDetails();

    var supp = state.supplements;
    final hasErrors = InputValidation.checkErrors(supp.errors);
    if (hasErrors) return;

    emit(OnBoardingPagesState.success(state.page, supp));
  }

  void signUp() async {
    _validateSignUpDetails();

    var supp = state.supplements;
    final hasErrors = InputValidation.checkErrors(supp.errors);
    if (hasErrors) return;

    emit(OnBoardingPagesState.laoding(state.page, supp,
        message: 'creating account ...'));

    try {
      await service.signUp(user: supp.user, password: supp.password);
      emit(OnBoardingPagesState.success(state.page, supp));
    } on ApiError catch (e) {
      emit(OnBoardingPagesState.failed(state.page, supp, AppError(e.message)));
    }
  }

  void logIn() async {
    _validateLogInDetails();

    var supp = state.supplements;
    final hasErrors = InputValidation.checkErrors(supp.errors);
    if (hasErrors) return;

    emit(OnBoardingPagesState.laoding(state.page, supp,
        message: 'logging you in ...'));

    try {
      await service.logIn(email: supp.user.email, password: supp.password);
      emit(OnBoardingPagesState.success(
          state.page, OnBoardingSupplements.empty()));
    } on ApiError catch (e) {
      emit(OnBoardingPagesState.failed(state.page, supp, AppError(e.message)));
    }
  }

  void sendPasswordResetEmail() async {
    var supp = state.supplements;
    emit(OnBoardingPagesState.laoding(state.page, supp));

    final error = InputValidation.validateEmail(supp.user.email);
    if (error != null) {
      supp = supp.copyWith(errors: {'email': 'A valid email id is required'});
      emit(OnBoardingPagesState.content(state.page, supp));
      return;
    }

    //clearing errors
    supp = supp.copyWith(errors: {});

    emit(OnBoardingPagesState.laoding(state.page, supp,
        message: 'sending email with reset password link ...'));

    try {
      await service.sendPasswordResetEmail(supp.user.email);
      //condition for reseting vs logging-in
      supp = supp.copyWith(password: '');
      emit(OnBoardingPagesState.success(state.page, supp));
    } on ApiError catch (e) {
      emit(OnBoardingPagesState.failed(state.page, supp, AppError(e.message)));
    }
  }

  _validateSignUpDetails() {
    var supp = state.supplements;
    emit(OnBoardingPagesState.laoding(state.page, supp));

    final errors = <String, String?>{};

    errors['email'] = InputValidation.validateEmail(supp.user.email);
    errors['password'] =
        InputValidation.validateText(supp.password, 'Password');
    errors['confirm_password'] = InputValidation.validateText(
        supp.confirmationPassword, 'Confirmation Password');
    if (errors['password'] == null && errors['confirm_password'] == null) {
      errors['confirm_password'] = InputValidation.checkIfPasswordsMatch(
          supp.password, supp.confirmationPassword);
    }

    supp = supp.copyWith(errors: errors);
    emit(OnBoardingPagesState.content(state.page, supp));
  }

  _validateLogInDetails() {
    var supp = state.supplements;
    emit(OnBoardingPagesState.laoding(state.page, supp));

    final errors = <String, String?>{};

    errors['email'] = InputValidation.validateEmail(supp.user.email);
    errors['password'] =
        InputValidation.validateText(supp.password, 'Password');

    supp = supp.copyWith(errors: errors);
    emit(OnBoardingPagesState.content(state.page, supp));
  }

  _validateWelcomeDetails() {
    var supp = state.supplements;
    emit(OnBoardingPagesState.laoding(state.page, supp));

    final errors = <String, String?>{};

    errors['name'] = InputValidation.validateText(supp.user.name, 'Name');
    errors['gender'] = InputValidation.validateText(supp.user.gender, 'Gender');
    supp = supp.copyWith(errors: errors);
    emit(OnBoardingPagesState.content(state.page, supp));
  }

  List<String> _getCourseTypes(List<Course> courseList) {
    final types = <String>[];
    for (Course course in courseList) {
      if (!types.contains(course.type)) types.add(course.type);
    }
    return types;
  }
}
