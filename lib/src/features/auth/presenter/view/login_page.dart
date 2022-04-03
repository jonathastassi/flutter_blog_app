import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_blog_app/src/core/validators/email_validator.dart';
import 'package:flutter_blog_app/src/core/validators/password_validator.dart';
import 'package:flutter_blog_app/src/features/auth/presenter/bloc/login_cubit.dart';
import 'package:flutter_blog_app/src/features/auth/presenter/bloc/login_state.dart';
import 'package:flutter_blog_app/src/shared/widgets/outlined_button_custom.dart';
import 'package:flutter_modular/flutter_modular.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ModularState<LoginPage, LoginCubit>
    with EmailValidator, PasswordValidator {
  late FocusNode _emailFocus;
  late GlobalKey<FormState> _formKey;

  @override
  void initState() {
    super.initState();

    _emailFocus = FocusNode();
    _formKey = _formKey = GlobalKey<FormState>();
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
      ),
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(
                height: 90,
              ),
              Hero(
                tag: 'splash_title',
                child: RichText(
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
                      key: _formKey,
                      autovalidateMode: AutovalidateMode.always,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            TextFormField(
                              enabled: !state.loading,
                              focusNode: _emailFocus,
                              keyboardType: TextInputType.emailAddress,
                              validator: validateEmail,
                              decoration: InputDecoration(
                                labelText: 'E-mail',
                                errorText:
                                    state.error == '' ? null : state.error,
                              ),
                              onChanged: bloc.setEmail,
                            ),
                            TextFormField(
                              enabled: !state.loading,
                              validator: validatePassword,
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
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  bloc.login();
                                }
                              },
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
      ),
    );
  }
}
