import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_blog_app/src/core/validators/name_validator.dart';
import 'package:flutter_blog_app/src/core/validators/email_validator.dart';
import 'package:flutter_blog_app/src/core/validators/password_validator.dart';
import 'package:flutter_blog_app/src/features/auth/presenter/bloc/register_cubit.dart';
import 'package:flutter_blog_app/src/features/auth/presenter/bloc/register_state.dart';
import 'package:flutter_blog_app/src/shared/widgets/outlined_button_custom.dart';
import 'package:flutter_modular/flutter_modular.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends ModularState<RegisterPage, RegisterCubit>
    with EmailValidator, PasswordValidator, NameValidator {
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
        title: const Text("Criar uma conta"),
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
                child: BlocConsumer<RegisterCubit, RegisterState>(
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
                              key: const Key('registerPage_email'),
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
                              key: const Key('registerPage_name'),
                              enabled: !state.loading,
                              validator: validateName,
                              decoration: InputDecoration(
                                labelText: 'Nome',
                                errorText:
                                    state.error == '' ? null : state.error,
                              ),
                              onChanged: bloc.setName,
                            ),
                            TextFormField(
                              key: const Key('registerPage_password'),
                              enabled: !state.loading,
                              validator: validatePassword,
                              decoration: const InputDecoration(
                                labelText: 'Senha',
                              ),
                              obscureText: true,
                              onChanged: bloc.setPassword,
                            ),
                            TextFormField(
                              key: const Key('registerPage_confirmPassword'),
                              enabled: !state.loading,
                              validator: (value) => validateConfirmPassword(
                                value,
                                state.password,
                              ),
                              decoration: const InputDecoration(
                                labelText: 'Confirmar Senha',
                              ),
                              obscureText: true,
                              onChanged: bloc.setConfirmPassword,
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            OutlinedButtonCustom(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  bloc.register();
                                }
                              },
                              child: const Text('Criar conta'),
                              loading: bloc.state.loading,
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            TextButton(
                              onPressed: bloc.backToLogin,
                              child: const Text('Voltar para o login'),
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
