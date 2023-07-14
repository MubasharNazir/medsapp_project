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
    title: "Introduction To MeDsApp",
    image: "assets/images/image2.png",
    desc:
        "This medicine donator project is to prepare a portal for the collection of unused medicine for further utilization by a needy person",
  ),
  OnboardingContents(
    title: "Donate Unused Medicine ",
    image: "assets/images/3.png.png",
    desc:
        "The Medicine Donation system proposed here aims at providing an online platform for donating medicines or unused medicines to needy people..",
  ),
  OnboardingContents(
    title: " Improve the Health Sector",
    image: "assets/images/image3.png",
    desc:
        "It helps poor people for medication.It will help to maintain records of medicines.Many needy people will get cured.",
  ),
];
