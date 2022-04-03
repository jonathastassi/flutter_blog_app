import 'package:flutter/material.dart';
import 'package:flutter_blog_app/src/app/bloc/app_cubit.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends ModularState<SplashPage, AppCubit> {
  bool initialized = false;

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      cubit.checkUserLogged();
      Future.delayed(const Duration(milliseconds: 50)).then((_) {
        setState(() {
          initialized = true;
        });
      });
      ;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: AnimatedOpacity(
        duration: const Duration(milliseconds: 900),
        opacity: initialized ? 1 : 0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/together.gif',
                  gaplessPlayback: true,
                  fit: BoxFit.fill,
                  width: 220,
                ),
                const SizedBox(
                  height: 32,
                ),
                Hero(
                  tag: 'splash_title',
                  child: RichText(
                    text: TextSpan(
                      text: 'Together',
                      style: Theme.of(context).textTheme.headline4,
                      children: <TextSpan>[
                        TextSpan(
                          text: ' Blog',
                          style: Theme.of(context).textTheme.headline4!.copyWith(
                                fontWeight: FontWeight.normal,
                              ),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  'Feito por Jonathas Tassi e Silva',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                )
              ],
            ),
            Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).colorScheme.onSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
