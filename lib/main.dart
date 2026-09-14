import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'src/src_export.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final localStorage = await LocalStorageService.init();
  runApp(
    ProviderScope(
      overrides: [
        localStorageServiceProvider.overrideWithValue(localStorage),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Barcode Scanner',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      routerConfig: AppRouter.router,
    );
  }
}