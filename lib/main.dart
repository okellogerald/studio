import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'app.dart';
import 'source.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  final directory = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  await Hive.openBox(Constants.userDataBox);

  final _auth = FirebaseAuth.instance;

  final myApp = MultiProvider(
    providers: [
      Provider(create: (_) => OnBoardingPagesBloc(UserService(_auth))),
      Provider(create: (_) => CoursesService(_auth)),
    ],
    child: const MyApp(),
  );

  runApp(myApp);
}
