import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../controller/open_shift_bloc/open_shift_bloc.dart';
import '../controller/sync_data_bloc/sync_data_bloc.dart';

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
          BlocConsumer<SyncDataBloc, SyncDataState>(
            listener: (context, state) {
              if (state is NoInternet) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(const SnackBar(content: Text('No Internet')));
              }
              if (state is SyncDataSuccess) {
                BlocProvider.of<OpenShiftBloc>(context).add(DataSynced());
              }
            },
            builder: (context, state) {
              if (state is SyncDataUploadingData) {
                return Container(
                    alignment: AlignmentDirectional.center,
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
                          Flexible(child: Text("Uploading..."))
                        ],
                      ),
                    ));
              } else if (state is SyncDataGettingData) {
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
                          Flexible(child: Text("Getting..."))
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
