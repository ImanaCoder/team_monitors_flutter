import 'package:team_monitor/core/service_locator.dart';
import 'package:team_monitor/helpers/color_extension.dart';
import 'package:team_monitor/helpers/size__config.dart';
import 'package:team_monitor/modules/user/cubit/user_cubit.dart';
import 'package:team_monitor/shared/widgets/dropdown.dart';
import 'package:team_monitor/shared/widgets/gradient_button.dart';
import 'package:team_monitor/utils/display_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:team_monitor/modules/user/auth/pages/register_page1.dart';

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
            return Center(
                child:
                    SvgPicture.asset('assets/svg/logo.svg', fit: BoxFit.cover));
          } else if (state is UserInitial || state is TokenVerified) {
            return Center(
                child:
                    SvgPicture.asset('assets/svg/logo.svg', fit: BoxFit.cover));
          } else {
            return Container();
          }
        },
      ),
    );
  }
}

class LandingPage extends StatelessWidget {
  LandingPage({super.key});

  final List<String> items = [
    'All Members',
    'App Not Install',
    'Yet to Start',
    'Currently Working',
    'Stopped Work',
    'On Leave',
    'Currently In Break'
  ];

  void onItemSelected(String value, BuildContext context) {
    switch (value) {
      case 'App Not Install':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LandingPage()),
        );
        break;
      case 'Currently In Break':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LandingPage()),
        );
        break;
      case 'Currently Working':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LandingPage()),
        );
        break;
      case 'On Leave':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LandingPage()),
        );
        break;
      case 'Stopped Work':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LandingPage()),
        );
        break;
      case 'Yet to Start':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LandingPage()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/svg/logo.png',
                    height: 260,
                    width: 260,
                  ),
                  const SizedBox(height: 220),
                  GradientButton(
                      buttonText: 'Get Started',
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LandingPage()));
                      }),
                  const SizedBox(height: 20),

                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/users/login');
                    },
                    child: const Text('Login',
                        style:
                            TextStyle(fontSize: 18, color: Color(0xFF903B96))),
                  ),
                  // contact us button
                  const SizedBox(height: 15),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Have an Issue?',
                          style: TextStyle(color: TeamMonitorColor.gray)),
                      const Text('Contact Us',
                          style: TextStyle(
                              fontSize: 18, color: Color(0xFF055AFF))),
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
