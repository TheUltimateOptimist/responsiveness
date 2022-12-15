import 'package:flutter/material.dart';
import 'package:responsiveness/responsiveness.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const MyHomePage(),
      builder: (context, child) => ScreenSizeProvider(child: child),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  static const containerSize = ResponsiveValue<Size>(
    xs: Size(double.infinity, 700),
    sm: Size(double.infinity, 300),
  );

  static const actions = ResponsiveValue<List<Widget>>(
    xs: [_MyPopupMenuButton()],
    sm: [_Page1Button(), _Page2Button()],
  );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Responsiveness Example"),
          actions: actions.of(context),
        ),
        body: ResponsiveParent(
          //for screen sizes xs, xl, xxl light theme
          //for screen sizes sm, md, lg dart theme
          xs: (child) => Theme(data: ThemeData.light(), child: child),
          sm: (child) => Theme(data: ThemeData.dark(), child: child),
          xxl: (child) => Theme(data: ThemeData.light(), child: child),
          child: Builder(
            builder: (context) {
              final textStyle = Theme.of(context).textTheme.bodyMedium;
              return Container(
                color: Theme.of(context).cardColor,
                width: containerSize.of(context).width,
                height: containerSize.of(context).height,
                margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Center(
                  child: ResponsiveChild(
                    xs: Text("Screen Size xs", style: textStyle),
                    sm: Text("Screen Size sm", style: textStyle),
                    md: Text("Screen Size md", style: textStyle),
                    lg: Text("Screen Size lg", style: textStyle),
                    xl: Text("Screen Size xl", style: textStyle),
                    xxl: Text("Screen Size xxl", style: textStyle),
                  ),
                ),
              );
            }
          ),
        ),
      ),
    );
  }
}

class _Page1Button extends StatelessWidget {
  const _Page1Button();

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      child: const _LinkText("Page One"),
    );
  }
}

class _Page2Button extends StatelessWidget {
  const _Page2Button();

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      child: const _LinkText("Page Two")
    );
  }
}

class _MyPopupMenuButton extends StatelessWidget {
  const _MyPopupMenuButton();

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: (context) {
        return [
          PopupMenuItem(
            onTap: () {},
            child: const Text("Page One"),
          ),
          PopupMenuItem(
            onTap: () {},
            child: const Text("Page Two"),
          ),
        ];
      },
    );
  }
}

class _LinkText extends StatelessWidget {
  const _LinkText(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(color: Colors.white),
    );
  }
}