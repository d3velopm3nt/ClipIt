import 'package:flutter/material.dart';
import 'package:flutter_my_clipboard/navigation/app.navigation.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:provider/provider.dart';

import '../../../app/app.config.dart';
import '../../../settings/services/settings_service.dart';
import '../../display_manager.dart';

class IntroView extends StatefulWidget {
  const IntroView({Key? key}) : super(key: key);

  @override
  State<IntroView> createState() => _IntroViewState();
}

class _IntroViewState extends State<IntroView> {
  final introKey = GlobalKey<IntroductionScreenState>();
  SettingsService settingService = SettingsService();

  Widget _buildImage(String assetName, [double width = 350]) {
    return Image.asset(
      'assets/$assetName',
      width: width,
      filterQuality: FilterQuality.high,
    );
  }

  openClipboard(bool done) async {
    if (done) {
      settingService.appSettings.setupDone = true;
    } else {
      AppConfig.introSkipped = true;
    }
    await DisplayManager.clipboardView();
    AppNavigation.navigateToRoute(AppRoutes.home);
  }

  @override
  Widget build(BuildContext context) {
    settingService = Provider.of<SettingsService>(context);
    const bodyStyle = TextStyle(fontSize: 19.0, color: Colors.black);

    const pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(
          fontSize: 28.0, fontWeight: FontWeight.w700, color: Colors.black),
      bodyTextStyle: bodyStyle,
      bodyPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      key: introKey,
      globalBackgroundColor: Colors.white,
      globalHeader: Align(
        alignment: Alignment.topRight,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 16, right: 16),
            child: _buildImage('app_icon.png', 50),
          ),
        ),
      ),
      globalFooter: Container(
        width: double.infinity,
        height: 60,
        color: const Color.fromARGB(255, 159, 33, 243),
        child: ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                  const Color.fromARGB(255, 159, 33, 243))),
          child: const Text(
            'Skip Intro',
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
          onPressed: () => openClipboard(false),
        ),
      ),
      pages: [
        PageViewModel(
          title: "Copy Smarter",
          body:
              "Manage you clipboard in a new way with quick access and hot keys copy/paste the clippets that matter most",
          image: _buildImage('intro/copy.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Save and Search Text Copied",
          body:
              "Store all clippets in a local secure database and search all clips at the same time",
          image: _buildImage('intro/database.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Organize your Clipboard",
          body:
              "Manage your clippets with tags to organize and categorise the stuff that make sense.",
          image: _buildImage('intro/tag.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Customize your Clipboard",
          body:
              "Change the theme of your app to suite your mood. Make changes to how the clipboard react to copy events",
          image: _buildImage('intro/settings.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Create your own Hotkeys",
          body:
              "Assign shortcut keys to selected clippets to copy/paste instantly",
          image: _buildImage('intro/hotkey.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Are you ready for your new clipboard?",
          bodyWidget: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              //Text("Click on ", style: bodyStyle),
              // Icon(Icons.edit),
              //Text(" to edit a post", style: bodyStyle),
            ],
          ),
          decoration: pageDecoration,
          image: _buildImage('intro/completed.png'),
          //reverse: true,
        ),
      ],
      onDone: () => openClipboard(true),
      //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: false,
      skipOrBackFlex: 0,
      nextFlex: 0,
      showBackButton: true,
      //rtl: true, // Display as right-to-left
      back: const Icon(Icons.arrow_back),
      skip: const Text('Skip', style: TextStyle(fontWeight: FontWeight.w600)),
      next: const Icon(Icons.arrow_forward),
      done: const Icon(Icons
          .check_circle), //Text('Done', style: TextStyle(fontWeight: FontWeight.w600)),
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: const EdgeInsets.all(16),
      controlsPadding: const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
      dotsContainerDecorator: const ShapeDecoration(
        // color: Colors.black87,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
      ),
    );
  }
}
