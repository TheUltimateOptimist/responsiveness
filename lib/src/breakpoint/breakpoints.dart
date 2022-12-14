///holds the minimum widths of the breakpoints xs, sm, md, lg, xl and xxl
class Breakpoints {
  ///The values given specify the minimum width for the breakpoints xs, sm, md, lg, xl, xxl
  ///
  ///everyone of them except for [xs] can be spcified to your needs
  ///
  ///The minimum width for [xs] has to always remain zero as some form of left hook
  ///
  ///Added to that xxl > xl > lg > md > sm > xs needs to be true
  const Breakpoints({
    this.xs = 0,
    this.sm = 576,
    this.md = 768,
    this.lg = 992,
    this.xl = 1200,
    this.xxl = 1400,
  });

  ///minimum width for the Breakpoint xs
  final int xs;

  ///minimum width for the Breakpoint sm
  final int sm;

  ///minimum width for the Breakpoint md
  final int md;

  ///minimum width for the Breakpoint lg
  final int lg;

  ///minimum width for the Breakpoint xl
  final int xl;

  ///minimum width for the Breakpoint xxl
  final int xxl;
}