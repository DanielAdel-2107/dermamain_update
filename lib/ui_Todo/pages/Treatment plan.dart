import 'package:derma/models/treatment_plan.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'Doctor_instructions.dart';

class Treatmentplan extends StatelessWidget {
  List<TreatmentPlanModel> treatmentPlanList =[];
   Treatmentplan({super.key,required this.treatmentPlanList});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar:AppBar(
        toolbarHeight: 80,

        title:  Text(
        "All treatment plans".tr(),
        textAlign: TextAlign.left,
        style: const TextStyle(
        fontSize: 20,
        color: Color.fromRGBO(63, 59, 108, 1),
    fontFamily: 'poe',
      ),),
        automaticallyImplyLeading: false,
        actions: [
          Container(
            margin: const EdgeInsets.fromLTRB(0, 0, 16, 0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).colorScheme.primary,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 7,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            width: 32,
            height: 32,
            child: IconButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const Doctor_instructions(),
                  ),
                );
              },
              icon: const Icon(
                Icons.arrow_back_ios_outlined,
                size: 20,
                color: Colors.white,
              ),
              padding: const EdgeInsets.all(4),
            ),
          ),
        ],
      ),
      body:
      SizedBox(
        height: 780,
        child:ListView.builder(
            itemCount: treatmentPlanList.length,
            itemBuilder: (context,index){
              return Container(
                width: size.width * 0.9,
                height: 70,
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(size.width * 0.03),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 4,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    const SizedBox(width: 20),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          treatmentPlanList[index].quantity??"",
                          // "3 Times",
                          style: TextStyle(
                            fontSize: 20,
                            color: Color(0xFF454571),
                            fontFamily: 'Releway',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Per day",
                          style: TextStyle(
                            color: Color(0xFF454571),
                            fontFamily: 'Releway',
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 10),
                    Container(
                      height: size.height * 0.1,
                      width: 2,
                      color: Colors.grey.shade300,
                    ),
                    const SizedBox(width: 10),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: size.width * 0.6,
                          child:  Text(
                            treatmentPlanList[index].medicineName??"",
                            // "panadol extra",
                            maxLines: 4,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 20,
                              color: Color(0xFF454571),
                              fontFamily: 'Releway',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: size.width * 0.6,
                          child:  Text(
                            treatmentPlanList[index].frequency??"",
                            // "For 10 Days",
                            maxLines: 4,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 15,
                              color: Color(0xFF454571),
                              fontFamily: 'Releway',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            })),

    );
  }
}
