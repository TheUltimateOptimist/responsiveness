A minimal, easy to use responsive framework for building UI for all screen sizes using the [Boostrap](https://getbootstrap.com/docs/5.0/layout/breakpoints/) breakpoints by default.

- [1. Background](#background)
- [2. Breakpoints](#breakpoints)
- [3. Creating the UI](#creatingtheui)
- [4. Custom Breakpoints](#custombreakpoints)
- [5. Usage](#usage)

##  1. <a name='background'></a>Background

When I was first given the task to develop a flutter application for all screen sizes I was overwhelmed and clueless.  
Even though flutter provides widgets like ```LayoutBuilder``` or ```MediaQuery``` to enable responsive UI development, I found making use of those widgets in an easy, readable, predictable manner quite difficult.<br>
Because you still need to figure out:<br>
- What brekpoints you want to use
- How to identify the current breakpoint given the screen width
- How to define a UI based on the current breakpoint in an easy, readable manner

This package is the result of me trying to answer the above mentioned questions and offers thereby an oppionated approach for developing responsive UI using flutter.

##  2. <a name='breakpoints'></a>Breakpoints

This package uses the [Boostrap](https://getbootstrap.com/docs/5.0/layout/breakpoints/) breakpoints by default:

|short name|long name   |minimum width|devices         |
|----------|------------|-------------|----------------|
|xs        |extra small |0            |portrait phones |
|sm        |small       |576          |landscape phones|
|md        |medium      |768          |tablets         |
|lg        |large       |992          |destkops        |
|xl        |extra large |1200         |large destkops  |
|xxl       |xx-large    |1400         |larger destkops |

You can also provide custom breakpoints instead of using the default ones, as shown [here](#custombreakpoints).

##  3. <a name='creatingtheui'></a>Creating the UI

The following three widgets can be used to defina a responsive UI in an easy, readable manner.

- ### ResponsiveValue
  The ```ResponsiveValue``` allows you to provide different values based on the current screen size.  
  The value it provides can be anything from a ```double``` to a ```Widget```.

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

  Note that you do not need to specify a value for every screen size.  
  You need to only provide at least the one for the screen size xs, but can also provide more than one or all.  
  If you didn't provide a value for a screen size, the value from the next smaller defined screen size will be used.

  For example consider:
  ```dart
  static const fontSize = ResponsiveValue<double>(xs: 20.0, sm,: 21.0, md: 22.0);
  ```
  In this case only values for the screen sizes xs, sm and md were specified.  
  Nevertheless for the screen sizes lg, xl, and xxl the value from the screen size md will be used as it is the nearest smaller screen size to the three.

- ### ResponsiveChild
  ```The ResponsiveChild``` widget allows you to provide different widgets based on the current screen size.  
  Just like in the case of ```ResponsiveValue```, you do not need to specify a widget for every single one of the six differnt possible screen sizes.  
  Only the widget for the screen size xs is mandatory.
  
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
  To wrap the ```Object``` that you provided using the ```child``` parameter, you need to specify a callback for at least the screen size xs.  
  This callback receives the given ```child```  as a parameter and returns a new ```Widget```.  
  Inside the callback you can for example wrap the ```child``` with a ```Column``` or ```Row``` and return the newly created ```Widget```.  
  Just like in the case of ```ResponsiveValue``` and ```ResponsiveChild```, the callback of the nearest smaller defined screen size will be used if it was not provided for a particular screen size.
  
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

  In the above example, a ```Column``` will be displayed for the screen sizes xs and sm whereas a ```Row``` will be displayed for the screen sizes md - xxl.  

### Additional Values/Widgets
Besides accepting one widget/value for each screen size of the predefined screen sizes, ```ResponsiveValue```, ```ResponsiveChild``` and ```ResponsiveParent``` also allow you to specify addional values/widgets for different screen sizes.  
All of the additional widgets/values need to be put in a map, in which every entry's key is the minimum width to which the corresponding value or widget should be applied.

In code:
```dart
static const fontSize = ResponsiveValue<double>(
  xs: 20,
  md: 30,
  additionalValues: <int, double>{
    2000: 50,
  },
);
@override
Widget build(BuildContext context) {
  final textStyle = TextStyle(fontSize: fontSize.of(context));
  return ResponsiveChild(
    xs: Text("xs,sm", style: textStyle),
    md: Text("md, lg, xl, xxl", style: textStyle),
    additionalWidgets: <int, Widget>{
      2000: Text(">= 2000", style: textStyle),
    },
  );
}
```
In the above code snippet adjustments have been also made for screens wider than 2000 logical pixels even though such a screen size is not part of the predefined screen sizes.

### Current ```ScreenSize```
Even though ```ResponsiveValue```, ```ResponsiveChild``` and ```ResponsiveParent``` should usually be enough, it is also possible to determine the current screen size and perform custom logic based on the result.  
Given the ```BuildContext``` you can use ```ScreenSize.of(context)``` to get the current ```ScreenSize```.  
Apart from the default fields that an enum exposes, the ```ScreenSize``` enum exposes the ```minimumWidth``` field. If ```xxl``` is the current ```ScreenSize``` for example, the ```minimumWidth``` field will be equal to 1400.

The ```ScreenSize``` enum could be used like so:
```dart
@override
Widget build(BuildContext context){
  final screenSize = ScreenSize.of(context);
  if(screenSize == ScreenSize.xs){
     return Text(screenSize.minimumWidth)//same as Text("0")
  }
   else if(screenSize == ScreenSize.sm){
     return Text(screenSize.minimumWidth)//same as Text("576")
   }
   else{
     return Text("some text")
  }
 }
```

##  4. <a name='custombreakpoints'></a>Custom Breakpoints

Instead of using the default ones, you can provide custom breakpoints with the help of code generation.  
In the following, I will show you how to do this with the screen sizes small, medium, large as an example.
- At the root of your project, create a file called 'screen_sizes.json'.
- Inside 'screen_sizes.json' you need to define the different screen sizes inside a map.  
  The key is the name of the screen size and the value is the minimum width for that screen size.  
  The key needs to   be a String whereas the value needs to be an int.

  Example screen_sizes.json:
  ```json
  {
    "small": 0,
    "medium": 500,
    "large": 1000
  }
  ```

- Run the command ```dart run responsiveness``` from the root of your project.  
  This will generate a file called 'responsiveness.dart' under the lib directory of your project.
- Instead of importing this package at the top of your files, import the file, generated in the previous step:
  ```dart
  import "package:<your-project-name>/responsiveness.dart";
  ```

##  5. <a name='usage'></a>Usage

The tools described above allow you to build responsive UI for all screen sizes easily. But how can you best apply them. Here is my recommendation.

The biggest hurdle to fast and easy application development is complexity.  
That is why at its core software development is about breaking up big problems into smaller and smaller ones until they can easily be handled one at a time.  
The same principle should be used to build responsive UI in my opinion.  
First, you just focus on building the UI for mobile phones(e.g screen size xs).  
And only after you have completed that step, you start to worry about the other screen sizes.  
Now that you have already completed the UI for mobile phones you can run it on other screen sizes, see how it looks like and use the tools from the [Creating the UI](#creatingtheui) section to make the proper adjustments for larger screen sizes.

This should provide you with a fairly simple approach for building UI for all screen sizes using flutter. 

I wish you best of luck for your software project.