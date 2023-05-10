class OnboardingContents {
  final String title;
  final String image;
  final String desc;

  OnboardingContents({
    required this.title,
    required this.image,
    required this.desc,
  });
}

List<OnboardingContents> contents = [
  OnboardingContents(
    title: "One stop solution",
    image: "assets/images/image1.jpg",
    desc: " A place where you can Buy, Renew , Claim insurances",
  ),
  OnboardingContents(
    title: "Health Insurance",
    image: "assets/images/image2.jpg",
    desc: "Working at providing the best premium and the best insurance that will be suitable for an individual/family.",
  ),
  OnboardingContents(
    title: "Life insurance",
    image: "assets/images/image3.jpg",
    desc: "Working at providing the best premium and the best insurance that will be suitable for an individual/family.",
  ),
];