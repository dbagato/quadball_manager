import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quadball_manager/router/app_routes.dart';
import 'package:quadball_manager/services/auth_cubit.dart';
import 'package:quadball_manager/widgets/widgets.dart';

class LoginView extends StatelessWidget {
  final String text;
  final String imagePath;

  const LoginView({Key? key, required this.text, required this.imagePath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Image.asset(
            imagePath,
            height: 200,
            width: 200,
          ),
          Expanded(
            child: Container(
              alignment: Alignment.topCenter,
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: Theme.of(context).primaryTextTheme.bodyLarge,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 30,
            ),
            child: Column(
              children: [
                const SizedBox(height: 8),
                ButtonLogin(
                  textButton: "Sing up using Google",
                  iconButton: Icons.g_mobiledata,
                  colorButton: Colors.red,
                  colorText: Colors.white,
                  onTap: () => context.read<AuthCubit>().singInWithGoogle(),
                ),
                const SizedBox(height: 8),
                ButtonLogin(
                  textButton: "Sing up using Email",
                  iconButton: Icons.mail,
                  colorButton: Colors.grey,
                  colorText: Colors.white,
                  onTap: () {
                    context.read<AuthCubit>().reset();
                    Navigator.pushNamed(context, AppRoutes.loginAccount);
                  },
                ),
                const SizedBox(height: 50),
                OutlinedButton(
                    onPressed: () {
                      context.read<AuthCubit>().reset();
                      Navigator.pushNamed(context, AppRoutes.createAccount);
                    },
                    child: const Text("Create Account")),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
