part of 'screen_size.dart';

///{@template screen_size_provider}
///provides its child with the current [ScreenSize]
///
///it needs to sit on top of the widget tree in order to use the widgets inside the responsiveness package
///{@endtemplate}
class ScreenSizeProvider extends StatelessWidget {
  ///{@macro screen_size_provider}
  ///
  ///it is possible to customize the minimum width for the breakpoints xs, sm, md, lg, xl and xxl by specifying the [breakpoints] property.
  ///Nevertheless I strongly advise against it as the default values have been well thought through
  const ScreenSizeProvider(
      {super.key, this.child, this.minimumWidths = const MinimumWidths()});

  ///the subtree to provide the current [ScreenSize] to
  final Widget? child;

  ///holds the minimum widths for the the screen sizes xs, sm, md, lg, xl, xxl.
  final MinimumWidths minimumWidths;

  @override
  Widget build(BuildContext context) {
    final buildData = BuildData(
      width: MediaQuery.of(context).size.width,
      minimumWidths: minimumWidths,
      child: child ?? Container(),
    );
    return ScreenSize._fromBuildData(buildData);
  }
}
