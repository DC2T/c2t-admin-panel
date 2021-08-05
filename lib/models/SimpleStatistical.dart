class SimpleStatisticalInfo {
  final String? svgSrc, title;
  final int? total;

  SimpleStatisticalInfo({
    this.svgSrc,
    this.title,
    this.total,
  });
}

List demoSimpleStatisticalInfo = [
  SimpleStatisticalInfo(
    title: "Views this month",
    total: 1328,
    svgSrc: "assets/icons/visibility.svg",
  ),
  SimpleStatisticalInfo(
    title: "Movies added this month",
    total: 1328,
    svgSrc: "assets/icons/app.svg",
  ),
  SimpleStatisticalInfo(
    title: "New comments",
    total: 1328,
    svgSrc: "assets/icons/chat.svg",
  ),
  SimpleStatisticalInfo(
    title: "New reviews",
    total: 1328,
    svgSrc: "assets/icons/star.svg",
  ),
];
