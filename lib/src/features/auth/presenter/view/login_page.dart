import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_blog_app/src/features/auth/presenter/bloc/login_cubit.dart';
import 'package:flutter_blog_app/src/features/auth/presenter/bloc/login_state.dart';
import 'package:flutter_blog_app/src/shared/widgets/outlined_button_custom.dart';
import 'package:flutter_modular/flutter_modular.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ModularState<LoginPage, LoginCubit> {
  late FocusNode _emailFocus;

  @override
  void initState() {
    super.initState();

    _emailFocus = FocusNode();
  }

  @override
  void dispose() {
    _emailFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: AppBar(
        title: const Text('Realize o login'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(
              height: 90,
            ),
            RichText(
              textAlign: TextAlign.center,
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
              height: 24,
            ),
            Card(
              margin: const EdgeInsets.all(16),
              color: Theme.of(context).colorScheme.secondary,
              child: BlocConsumer<LoginCubit, LoginState>(
                listener: (context, state) {
                  if (state.error != '') {
                    _emailFocus.requestFocus();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.error),
                      ),
                    );
                  }
                },
                bloc: cubit,
                builder: (context, state) {
                  return Form(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          TextFormField(
                            focusNode: _emailFocus,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              labelText: 'E-mail',
                              errorText: state.error == '' ? null : state.error,
                            ),
                            onChanged: bloc.setEmail,
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Senha',
                            ),
                            obscureText: true,
                            onChanged: bloc.setPassword,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          OutlinedButtonCustom(
                            onPressed: bloc.login,
                            child: const Text('Acessar'),
                            loading: bloc.state.loading,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          TextButton(
                            onPressed: bloc.register,
                            child: const Text('Criar uma conta'),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
