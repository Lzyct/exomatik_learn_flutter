import 'package:exomatik_learn_flutter/features/auth/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final conEmail = TextEditingController();
    final conPassword = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: conEmail,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Username',
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 10),
              TextField(
                controller: conPassword,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  context.read<LoginCubit>().login(
                        LoginParams(
                          email: conEmail.text,
                          password: conPassword.text,
                        ),
                      );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text("Login"),
                      Icon(Icons.login),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
              BlocBuilder<LoginCubit, LoginState>(builder: (_, state) {
                return state.when(
                  initial: () => const Text("Initial"),
                  loading: () => const CircularProgressIndicator(),
                  success: (data) => Text(data.token ?? "-"),
                  failure: (message) => Text(message),
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}
