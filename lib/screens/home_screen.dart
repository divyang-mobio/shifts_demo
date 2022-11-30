import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shifts_demo/controller/sync_data_bloc/sync_data_bloc.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shift Demo'),
        actions: [
          IconButton(
              onPressed: () {
                print("object");
                BlocProvider.of<SyncDataBloc>(context).add(SyncAllData());
              },
              icon: const Icon(Icons.sync))
        ],
      ),
      body: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Center(
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/openShift');
              },
              child: Container(
                  alignment: Alignment.center,
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 255, 140, 0),
                      borderRadius: BorderRadius.circular(20)),
                  child: const Text(
                    'Shifts',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  )),
            ),
          ),
          BlocBuilder<SyncDataBloc, SyncDataState>(
            builder: (context, state) {
              if (state is SyncDataUploadingData) {
                return Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: const [
                          CircularProgressIndicator.adaptive(),
                          SizedBox(height: 10),
                          Text("Uploading...")
                        ],
                      ),
                    ));
              } else {
                return const SizedBox();
              }
            },
          ),
        ],
      ),
    );
  }
}
