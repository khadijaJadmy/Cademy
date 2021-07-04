import 'package:crypto_wallet/bloc/student.action.dart';
import 'package:crypto_wallet/bloc/student.bloc.dart';
import 'package:crypto_wallet/bloc/student.state.dart';
import 'package:crypto_wallet/ui/details/details_screen.dart';
import 'package:crypto_wallet/ui/home/components/item_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';

class ProfessorsPage extends StatelessWidget {
  // Pharmacy pharmacy;
  // List<Pharmacy> pharmacies;
  // PharmaciesPage({this.pharmacies});
  @override
  Widget build(BuildContext context) {
    //  this.pharmacy = ModalRoute.of(context).settings.arguments;
    context.read<ProfessorsBloc>().add(LoadAllProfessorsEvents());
    return Scaffold(
       
        body: BlocBuilder<ProfessorsBloc, ProfessorsState>(
            builder: (context, state) {
          return Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: GridView.builder(
                      itemCount: state.pharmacies.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        childAspectRatio: 0.75,
                      ),
                      itemBuilder: (context, index) => ItemCard(
                          product: state.pharmacies[index].course,
name:state.pharmacies[index].name,
                          press: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => 
                                  //MyMapPage(),
                                  DetailsScreen(
                                    product: state.pharmacies[index],
                                  ),
                                ));
                          })),
                ),
              ),
            ],
          );},
        ));
  }
}

class PharmaciesByContactEvent {}
