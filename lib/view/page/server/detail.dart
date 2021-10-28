import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toolbox/data/model/server.dart';
import 'package:toolbox/data/model/server_status.dart';
import 'package:toolbox/data/provider/server.dart';

class ServerDetailPage extends StatefulWidget {
  const ServerDetailPage(this.id, {Key? key}) : super(key: key);

  final String id;

  @override
  _ServerDetailPageState createState() => _ServerDetailPageState();
}

class _ServerDetailPageState extends State<ServerDetailPage> {
  late MediaQueryData _media;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _media = MediaQuery.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ServerProvider>(builder: (_, provider, __) {
      return _buildMainPage(
          provider.servers.firstWhere((e) => e.client.id == widget.id));
    });
  }

  Widget _buildMainPage(ServerInfo si) {
    return Scaffold(
      appBar: AppBar(
        title: Text(si.info.name ?? 'Server Detail'),
      ),
      body: ListView(
        children: [_buildCPUView(si.status), _buildMemView(si.status)],
      ),
    );
  }

  Widget _buildCPUView(ServerStatus ss) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: _media.size.height * 0.3),
      child: ListView.builder(
        itemBuilder: (ctx, idx) {
          return Text('$idx ${ss.cpu2Status.usedPercent(coreIdx: idx)}');
        },
        itemCount: ss.cpu2Status.now.length,
      ),
    );
  }

  Widget _buildMemView(ServerStatus ss) {
    return Text(ss.memList.length.toString());
  }
}
