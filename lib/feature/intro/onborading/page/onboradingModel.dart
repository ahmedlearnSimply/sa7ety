class Onboradingmodel {
  final String title;
  final String description;
  final String image;
  Onboradingmodel(
      {required this.title, required this.description, required this.image});
}

//* List of Onborading
List<Onboradingmodel> onboardingPages = [
  Onboradingmodel(
    title: "ابحث عن دكتور متخصص",
    description:
        "اكتشف مجموعة واسعة من الأطباء الخبراء والمتخصصين في مختلف المجالات",
    image: "assets/images/on1.svg",
  ),
  Onboradingmodel(
    title: "سهولة الحجز",
    description: "احجز المواعيد بضغطة زرار في أي وقت وفي أي مكان.",
    image: "assets/images/on2on1.svg",
  ),
  Onboradingmodel(
    title: "آمن وسري",
    description: "'كن مطمئنًا لأن خصوصيتك وأمانك هما أهم أولوياتنا.",
    image: "assets/images/on3.svg",
  ),
];
