import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:optymoney/Calculators/Components/CalculatorLogics.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    double windowHeight = MediaQuery.of(context).size.height;
    double windowWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.white,
        toolbarHeight: 50,
        title: Align(
          alignment: Alignment.centerLeft,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                'assets/icons/2.png',
                height: windowHeight * 0.06,
              ),
              Text(
                'Manage Your Finances',
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Column(
                children: [
                  SizedBox(
                    height: windowHeight * 0.03,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Life Goals',
                        style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: windowHeight * 0.01,
                  ),
                  Container(
                    height: windowHeight * 0.2,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        LifeGoalsCard(
                          windowHeight: windowHeight,
                          windowWidth: windowWidth,
                          title: 'Retire Rich',
                          image: 'assets/images/retire.png',
                          press: () {},
                        ),
                        LifeGoalsCard(
                          windowHeight: windowHeight,
                          windowWidth: windowWidth,
                          title: 'Own A Car',
                          image: 'assets/images/car.png',
                          press: () {},
                        ),
                        LifeGoalsCard(
                          windowHeight: windowHeight,
                          windowWidth: windowWidth,
                          title: 'Buy Your House',
                          image: 'assets/images/house.png',
                          press: () {},
                        ),
                        LifeGoalsCard(
                          windowHeight: windowHeight,
                          windowWidth: windowWidth,
                          title: 'Higher Education',
                          image: 'assets/images/education.png',
                          press: () {},
                        ),
                        LifeGoalsCard(
                          windowHeight: windowHeight,
                          windowWidth: windowWidth,
                          title: 'Grand Wedding',
                          image: 'assets/images/wedding.png',
                          press: () {},
                        ),
                        LifeGoalsCard(
                          windowHeight: windowHeight,
                          windowWidth: windowWidth,
                          title: 'Plan A Vacation',
                          image: 'assets/images/vacation.png',
                          press: () {},
                        ),
                        LifeGoalsCard(
                          windowHeight: windowHeight,
                          windowWidth: windowWidth,
                          title: 'Emergency Fund',
                          image: 'assets/images/emergencyfund.png',
                          press: () {},
                        ),
                        LifeGoalsCard(
                          windowHeight: windowHeight,
                          windowWidth: windowWidth,
                          title: 'Unique Goal',
                          image: 'assets/images/uniquegoal.png',
                          press: () {},
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: windowHeight * 0.03,
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Financial Calculators',
                        style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: windowHeight * 0.01,
                  ),
                  Row(
                    children: [
                      FinancialCalculatorsTiles(
                        windowHeight: windowHeight,
                        windowWidth: windowWidth,
                        letter: 'E',
                        name: 'EMI Home Loan',
                        navigationRoute: EmiHomeLoanCalcForm(),
                      ),
                      FinancialCalculatorsTiles(
                        windowHeight: windowHeight,
                        windowWidth: windowWidth,
                        letter: 'S',
                        name: 'SIP   Calculator',
                        navigationRoute: SipCalcFrom(),
                      ),
                      FinancialCalculatorsTiles(
                        windowHeight: windowHeight,
                        windowWidth: windowWidth,
                        letter: 'S',
                        name: 'Sukanya Samriddhi ',
                        navigationRoute: SukanyaSamriddhiCalcForm(),
                      ),
                    ],
                  ),
                  SizedBox(height: windowHeight * 0.01),
                  Row(
                    children: [
                      FinancialCalculatorsTiles(
                        windowHeight: windowHeight,
                        windowWidth: windowWidth,
                        letter: 'L',
                        name: 'Lump Sum',
                        navigationRoute: LumpSumCalcFrom(),
                      ),
                      FinancialCalculatorsTiles(
                        windowHeight: windowHeight,
                        windowWidth: windowWidth,
                        letter: 'E',
                        name: 'EMI Car Loan',
                        navigationRoute: EmiCarLoanCalcForm(),
                      ),
                      FinancialCalculatorsTiles(
                        windowHeight: windowHeight,
                        windowWidth: windowWidth,
                        letter: 'H',
                        name: 'House Rent',
                        navigationRoute: HraCalcFrom(),
                      ),
                    ],
                  ),
                  SizedBox(height: windowHeight * 0.01),
                  Row(
                    children: [
                      FinancialCalculatorsTiles(
                        windowHeight: windowHeight,
                        windowWidth: windowWidth,
                        letter: 'T',
                        name: 'Tax   Calculator',
                        navigationRoute: TaxCalculator(),
                      ),
                      FinancialCalculatorsTiles(
                        windowHeight: windowHeight,
                        windowWidth: windowWidth,
                        letter: 'E',
                        name: 'EMI Personal Loan',
                        navigationRoute: EmiPersonalLoanCalcForm(),
                      ),
                      FinancialCalculatorsTiles(
                        windowHeight: windowHeight,
                        windowWidth: windowWidth,
                        letter: 'S',
                        name: 'SIP Installment',
                        navigationRoute: SipInstallmentCalcForm(),
                      ),
                    ],
                  ),
                  SizedBox(height: windowHeight * 0.01),
                  Row(
                    children: [
                      FinancialCalculatorsTiles(
                        windowHeight: windowHeight,
                        windowWidth: windowWidth,
                        letter: 'F',
                        name: 'Fixed Deposit Calculator',
                        navigationRoute: FixedDepositCalcForm(),
                      ),
                      FinancialCalculatorsTiles(
                        windowHeight: windowHeight,
                        windowWidth: windowWidth,
                        letter: 'P',
                        name: 'PPF  Calculator',
                        navigationRoute: PpfCalcFrom(),
                      ),
                      FinancialCalculatorsTiles(
                        windowHeight: windowHeight,
                        windowWidth: windowWidth,
                        letter: 'T',
                        name: 'Tax Regime Comparision',
                        navigationRoute: OldVsNewTax(),
                      ),
                    ],
                  ),
                  SizedBox(height: windowHeight * 0.01),
                  Row(
                    children: [
                      FinancialCalculatorsTiles(
                        windowHeight: windowHeight,
                        windowWidth: windowWidth,
                        letter: 'R',
                        name: 'Recurring Deposit',
                        navigationRoute: RecurringDepositCalcForm(),
                      ),
                      FinancialCalculatorsTiles(
                        windowHeight: windowHeight,
                        windowWidth: windowWidth,
                        letter: 'N',
                        name: 'NPS Calculator',
                        navigationRoute: NpsCalcForm(),
                      ),
                      Expanded(
                        child: Card(),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FinancialCalculatorsTiles extends StatelessWidget {
  const FinancialCalculatorsTiles({
    Key? key,
    required this.windowHeight,
    required this.windowWidth,
    required this.letter,
    required this.name,
    this.navigationRoute,
  }) : super(key: key);

  final double windowHeight;
  final double windowWidth;
  final String letter;
  final String name;
  final Widget? navigationRoute;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          showCupertinoModalBottomSheet(
            expand: false,
            isDismissible: true,
            enableDrag: true,
            bounce: true,
            duration: Duration(milliseconds: 400),
            context: context,
            builder: (context) => Scaffold(
              body: navigationRoute,
            ),
          );
        },
        child: Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: SizedBox(
            height: windowHeight * 0.15,
            width: windowWidth * 0.3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  letter,
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF5B16D0).withOpacity(0.8),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: Text(
                    name,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LifeGoalsCard extends StatelessWidget {
  const LifeGoalsCard({
    Key? key,
    required this.windowHeight,
    required this.windowWidth,
    required this.title,
    required this.image,
    required this.press,
  }) : super(key: key);

  final double windowHeight;
  final double windowWidth;
  final String title;
  final String image;
  final Function press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => press as void Function(),
      child: Padding(
        padding: const EdgeInsets.only(right: 0.0),
        child: Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: SizedBox(
            height: windowHeight * 0.07,
            width: windowWidth * 0.4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  image,
                  height: windowHeight * 0.13,
                  width: windowWidth * 0.5,
                ),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
