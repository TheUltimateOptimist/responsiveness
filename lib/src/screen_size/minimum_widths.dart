///Holds the minimum widths of the screen sizes xs, sm, md, lg, xl and xxl.
class MinimumWidths {
  ///The values given specify the minimum width of the screen sizes xs, sm, md, lg, xl, xxl.
  ///
  ///everyone of them except for [xs] can be spcified to your needs
  ///
  ///The minimum width for [xs] has to always remain zero as some form of left hook.
  ///
  ///Added to that xxl > xl > lg > md > sm > xs needs to be true.
  const MinimumWidths({
    this.xs = 0,
    this.sm = 576,
    this.md = 768,
    this.lg = 992,
    this.xl = 1200,
    this.xxl = 1400,
  });

  ///minimum width of the [ScreenSize] xs
  final int xs;

  ///minimum width of the [ScreenSize] sm
  final int sm;

  ///minimum width of the [ScreenSize] md
  final int md;

  ///minimum width of the [ScreenSize] lg
  final int lg;

  ///minimum width of the [ScreenSize] xl
  final int xl;

  ///minimum width of the [ScreenSize] xxl
  final int xxl;
}
