A minimal, easy to use responsive framework for building UI for all screen sizes using the [Boostrap](https://getbootstrap.com/docs/5.0/layout/breakpoints/) breakpoints.

- [1. Background](#Background)
- [2. Breakpoints](#Breakpoints)
- [3. Getting started](#Gettingstarted)
- [4. Creating the UI](#CreatingtheUI)
- [5. Current screen size](#currentscreensize)

##  1. <a name='Background'></a>Background

When I was first given the task to develop a flutter application for all screen sizes I was overwhelmed and clueless. Even though flutter provides widgets like ```LayoutBuilder``` or ```MediaQuery``` to enable responsive UI development, I found making use of those widgets in an easy, readable, predictable manner quite difficult.<br>
Because you still need to figure out:<br>
- What brekpoints you want to use
- How to identify the current breakpoint given the screen width
- How to define a UI based on the current breakpoint in an easy, readable manner

This package is the result of me trying to answer the above mentioned questions and offers thereby an oppionated approach for developing responsive UI using flutter.

##  2. <a name='Breakpoints'></a>Breakpoints

This package uses the [Boostrap](https://getbootstrap.com/docs/5.0/layout/breakpoints/) breakpoints:

|short name|long name   |minimum width|devices         |
|----------|------------|-------------|----------------|
|xs        |extra small |0            |portrait phones |
|sm        |small       |576          |landscape phones|
|md        |medium      |768          |tablets         |
|lg        |large       |992          |destkops        |
|xl        |extra large |1200         |large destkops  |
|xxl       |xx-large    |1400         |larger destkops |

The minimum widths in the above table are used by default, but you can also customize them, as shown [here](#minimumWidths).

##  3. <a name='Gettingstarted'></a>Getting started

To use this package in your app you need to wrap you widget tree with ```ScreenSizeProvider``` like so:
```dart
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const MyHomePage(),
      builder: (context, child) {
        return ScreenSizeProvider(child: child);
      },
    );
  }
}
```
The ```ScreenSizeProvider``` identifys the current screen size and provides that information to the subtree.

<a name='minimumWidths'></a>By setting the ```minimumWidths``` parameter of the ```ScreenSizeProvider``` you can customize the minimum widths of the six screen sizes xs, sm, md, lg, xl and xxl.
```dart
BreakpointProvider(
  breakpoints: Breakpoints(
    xs: 0, //has to always remain 0
    sm: 577,//default is 576
    md: 800,//default is 768
    lg: 1000,//default is 992
    xl: 1201,//default is 1200
    xxl: 1402,//default is 1400
  ),
  child: child,
)
```
Nevertheless, I advise you to use the default values as they have been well thought through and have proven themselves over time.

##  4. <a name='CreatingtheUI'></a>Creating the UI

The following three Classes can be used to defina a responsive UI in an easy, readable manner.

- ### ResponsiveValue
  The ```ResponsiveValue``` allows you to provide different values based on the curren screen size. The value it provides can be anything from a ```double``` to a ```Widget```.

  Definition:
  ```dart
  static const fontSize = ResponsiveValue<double>(xs: 20.0, sm,: 21.0, md: 22.0);
  static const fontColor = ResponsiveValue<Color>(md: Colors.green, lg: Colors.red);
  ```

  Usage:
  ```dart
    @override
    Widget build(BuildContext context) {
    return Text(
        "Hello World",
        style: TextStyle(
          fontSize: fontSize.of(context),
          color: fontColor.of(context),
        ),
    );
  ```

  Note that you do not need to specify a value for every screen size. You need to only provide at least one, but can also provide more than one or all. If you didn't provide a value for a screen size, the value from the nearest one will be used.

  For example consider:
  ```dart
  static const fontSize = ResponsiveValue<double>(xs: 20.0, sm,: 21.0, md: 22.0);
  ```
  In this case only values for the screen sizes xs, sm and md were specified. Nevertheless for the screen sizes lg, xl, and xxl the value from the screen size md will be used as it is the nearest screen size to the three.

  Next take a look at:
  ```dart
  static const fontSize = ResponsiveValue<double>(xs: 20.0, md: 22.0);
  ```
  In this case no value is specified for the screen size ```sm``` which is between ```xs``` and ```md```. The above mentioned rule of using the value of the nearest screen size would not work in this example as there are two nearest screen sizes. So in that case the value of the smaller screen size will be used. In this example that would be the value of the screen size ```xs```.

- ### ResponsiveChild
  ```The ResponsiveChild``` widget allows you to provide different widgets based on the current screen size. Just like in the case of ```ResponsiveValue```, you do not need to specify a widget for every single one of the six differnt possible screen sizes. A widget for at least on screen size needs to be given.
  
  In code:
  ```dart
  @override
  Widget build(BuildContext context) {
    return ResponsiveChild(
      xs: Text("show when screen size is xs"),
      sm: Text("show when screen size is sm"),
      md: Text("show when screen size is md"),
      lg: Text("show when screen size is lg"),
      xl: Text("show when screen size is xl"),
      xxl: Text("show when screen size is xxl"),
    );
  ```

- ### ResponsiveParent
  ```The ResponsiveParent``` widget allows you to wrap a given ```Object``` with different ```Widget```s based on the current screen size.   
  To wrap the ```Object``` that you provided using the ```child``` parameter, you need to specify a callback for at least one of the six different possible screen sizes. This callback receives the given ```child```  as a parameter and returns a new ```Widget```. Inside the callback you can for example wrap the ```child``` with a ```Column``` or ```Row``` and return the newly created ```Widget```
  Just like in the case of ```ResponsiveValue``` and ```ResponsiveChild``` the callback of the nearest screen size will be used if it is not defined for a particular screen size.
  
  In code:
  ```dart
  //displays a column or row based on the current scren size
  @override
  Widget build(BuildContext context) {
    return ResponsiveParent<List<Widget>>(
      xs: (child) => Column(children: child),
      md: (child) => Row(children: child),
      child: [], //some children Widgets
    );
  ```

##  5. <a name='currentscreensize'></a>Current ```ScreenSize```

Even though the classes from the [Creating the UI](#CreatingtheUI) section should usually be enough, it is also possible to determine the current screen size and perform custom logic based on the result.

Given the ```BuildContext``` you can use ```ScreenSize.of(context)``` to get the current ```ScreenSize```.

The ```ScreenSize``` object exposes the ```index``` and the ```minimumWidth``` field.

The index field ranges from 0 to 5 and tells you the current screen size.

0 -> ```xs```, 1 -> ```sm```, 2 -> ```md```, 3 -> ```lg```, 4 -> ```xl```, 5 -> ```xxl```.

In code:
```dart
@override
Widget build(BuildContext context){
  final index = ScreenSize.of(context).index;
  if(index == ScreenSize.xs){
    //return some widget
  }
  else if(index == ScreenSize.sm){
    //return some widget
  }
  else{
    //return some widget
  }
}
```

The ```minimumWidth``` field exposes the minimum width of the current screen size. 

Whenever the curren screen size is ```lg``` for example, ```minimumWidth``` will be equal to ```992```.

In code:
```dart
@override
Widget build(BuildContext context){
  final screenSize = ScreenSize.of(context);
  if(screenSize == ScreenSize.lg){
    return Text(screenSize.minimumWidth.toString()) //same as Text('992')
  }
  return Text("other text")
}
```

##  5. <a name='usage'></a>Usage

The tools described above allow you to build responsive UI for all screen sizes easily. But how can you best apply them. Here is my recommendation.

The biggest hurdle to fast and easy application development is complexity. That is why at its core software development is about breaking up big problems into smaller and smaller ones until they can easily be handled on at a time.

The same principle should be used to build responsive UI in my opinion.

First, you just focus on building the UI for mobile phones(e.g screen size xs). And only after you have completed that step, you start to worry about the other screen sizes. Now that you have already completed the UI for mobile phones you can run it on other screen sizes, see how it looks like and use the tools from the [Creating the UI](#CreatingtheUI) section to make the proper adjustments for larger screen sizes.

This should provide you with a fairly simple approach for building UI for all screen sizes using flutter. 

I wish you best of luck for your software project.



