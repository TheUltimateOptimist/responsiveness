part of 'breakpoint.dart';

///{@template breakpoint_provider}
///provides its child with the current [Breakpoint]
///
///it needs to sit on top of the widget tree in order to use the widgets inside the responsiveness package
///{@endtemplate}
class BreakpointProvider extends StatelessWidget {
  ///{@macro breakpoint_provider}
  ///
  ///it is possible to customize the minimum width for the breakpoints xs, sm, md, lg, xl and xxl by specifying the [breakpoints] property.
  ///Nevertheless I strongly advise against it as the default values have been well thought through
  const BreakpointProvider(
      {super.key, this.child, this.breakpoints = const Breakpoints()});

  ///the subtree to provide the current [Breakpoint] to
  final Widget? child;

  ///holds the minimum widths for the breakpoints
  final Breakpoints breakpoints;

  @override
  Widget build(BuildContext context) {
    final buildData = BuildData(
      width: MediaQuery.of(context).size.width,
      breakpoints: breakpoints,
      child: child ?? Container(),
    );
    return Breakpoint._fromBuildData(buildData);
  }
}
