import 'package:codeal/core/service_locator.dart';
import 'package:codeal/modules/user/cubit/user_cubit.dart';
import 'package:codeal/utils/display_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:codeal/modules/user/auth/pages/register_page1.dart';

class AutoLoginScreen extends StatelessWidget {
  const AutoLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserCubit()..preLoginProcessing(),
      child: BlocConsumer<UserCubit, UserState>(
        listener: (context, state) {
          if (state is UserError) {
            sl<AppToast>().error(state.errorMsg);
          } else if (state is TokenError) {
            Navigator.pushReplacementNamed(context, '/landing-page');
          } else if (state is TokenVerified) {
            Navigator.pushReplacementNamed(context, '/dashboard');
          }
        },
        builder: (context, state) {
          if (state is UserLoading) {
            return Center(child: SvgPicture.asset('assets/svg/logo.svg', fit: BoxFit.cover));
          } else if (state is UserInitial || state is TokenVerified) {
            return Center(child: SvgPicture.asset('assets/svg/logo.svg', fit: BoxFit.cover));
          } else {
            return Container();
          }
        },
      ),
    );
  }
}

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size scrSize = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(
          children: [
            SizedBox(
              height: scrSize.height,
              width: scrSize.width,
              child: SvgPicture.asset('assets/svg/landing-page.svg', fit: BoxFit.cover),
            ),
            Center(
              child: InkWell(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: const Color(0xFF2D3B8A),
                    ),
                    child: const Text('Get Started', style: TextStyle(color: Colors.white, fontSize: 18)),
                  ),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => RegisterPageOne()));
                  }),
            ),
            Positioned(
              left: 30,
              bottom: 30,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // login button
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/users/login');
                    },
                    child: const Text('Login', style: TextStyle(fontSize: 18, color: Color(0xFF903B96))),
                  ),
                  // contact us button
                  const SizedBox(height: 15),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Have an Issue?', style: TextStyle(color: Color(0xFF7D8888))),
                      Text('Contact Us', style: TextStyle(fontSize: 18, color: Color(0xFF055AFF))),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
