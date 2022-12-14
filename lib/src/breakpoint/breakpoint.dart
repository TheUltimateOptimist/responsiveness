import 'package:flutter/material.dart' show StatelessWidget, Widget, BuildContext, MediaQuery, Container, InheritedWidget;
import 'breakpoints.dart';
import '../internals/build_data.dart';

export 'breakpoints.dart';
part 'breakpoint_provider.dart';

///{@template breakpoint}
///the current [Breakpoint]
///
///it can be retrived from the [BuildContext] using
///```dart 
///Breakpoint.of(context)
///```
///it exposes the [index] and the [value] of the current [Breakpoint]
///
///{@endtemplate}
///{@macro index}
///{@macro value}
class Breakpoint extends InheritedWidget{

  ///{@macro breakpoint}
  ///{@macro index}
  ///{@macro value}
  Breakpoint(this.index, this.value, {required super.child});

  ///the index of the current breakpoint
  ///
  ///{@template index}
  ///the [index] car range from 0 to 5: xs -> 0, sm -> 1, md -> 2, lg -> 3, xl -> 4, xxl -> 5
  ///
  ///using the [index] you can do something like:
  ///```dart
  ///if(Breakpoint.of(context).index == Breakpoint.xs){
  ///
  ///}
  ///```
  ///or
  ///```dart
  ///switch(Breakpoint.of(context).index){
  ///   case Breakpoint.xs: throw UnimplementedError();
  ///   case Breakpoint.sm: throw UnimplementedError();
  ///   case Breakpoint.md: throw UnimplementedError();
  ///   case Breakpoint.lg: throw UnimplementedError();
  ///   case Breakpoint.xl: throw UnimplementedError();
  ///   case Breakpoint.xxl: throw UnimplementedError();
  /// }
  ///```
  ///{@endtemplate}
  final int index;

  ///{@template value}
  ///the [value] provides you with the minimum with for the currently active [Breakpoint]
  ///
  ///if for example [xxl] is the current [Breakpoint], [value] will equal 1400, unless different minimum widths
  ///were specified in the [BreakpointProvider] that sits on top of the widget tree
  ///{@endtemplate}
  final int value;

  ///index of the [Breakpoint] xs
  static const xs = 0;

  ///index of the [Breakpoint] sm
  static const sm = 1;

  ///index of the [Breakpoint] md
  static const md = 2;

  ///index of the [Breakpoint] lg
  static const lg = 3;

  ///index of the [Breakpoint] xl
  static const xl = 4;

  ///index of the [Breakpoint] xxl
  static const xxl = 5;

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return index != (oldWidget as Breakpoint).index;
  }

  ///retrieves the current [Breakpoint] from the given [BuildContext]
  factory Breakpoint.of(BuildContext context){
    switch(Breakpoint.of(context).index){
      case Breakpoint.xs: throw UnimplementedError();
      case Breakpoint.sm: throw UnimplementedError();
      case Breakpoint.md: throw UnimplementedError();
      case Breakpoint.lg: throw UnimplementedError();
      case Breakpoint.xl: throw UnimplementedError();
      case Breakpoint.xxl: throw UnimplementedError();
    }
    final result = context.dependOnInheritedWidgetOfExactType<Breakpoint>();
    assert(result != null, "No Breakpoint found in context. Please make sure to add the BreakpointProvider at the top of your widget tree");
    return result as Breakpoint;
  }

  factory Breakpoint._fromBuildData(BuildData buildData){
    if(buildData.width >= buildData.breakpoints.xxl){
      return Breakpoint(Breakpoint.xxl, buildData.breakpoints.xxl, child: buildData.child);
    }
    if(buildData.width >= buildData.breakpoints.xl){
      return Breakpoint(Breakpoint.xl, buildData.breakpoints.xl, child: buildData.child);
    }
    if(buildData.width >= buildData.breakpoints.lg){
      return Breakpoint(Breakpoint.lg, buildData.breakpoints.lg, child: buildData.child);
    }
    if(buildData.width >= buildData.breakpoints.md){
      return Breakpoint(Breakpoint.md, buildData.breakpoints.md, child: buildData.child);
    }
    if(buildData.width >= buildData.breakpoints.sm){
      return Breakpoint(Breakpoint.sm, buildData.breakpoints.sm, child: buildData.child);
    }
    return Breakpoint(Breakpoint.xs, buildData.breakpoints.xs, child: buildData.child);
  }
}