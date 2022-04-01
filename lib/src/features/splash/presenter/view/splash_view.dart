import 'package:flutter/material.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  bool initialized = false;

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 50)).then((_) {
      setState(() {
        initialized = true;
      });
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
                RichText(
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
            const Center(
              child: CircularProgressIndicator(),
            ),
          ],
        ),
      ),
    );
  }
}
