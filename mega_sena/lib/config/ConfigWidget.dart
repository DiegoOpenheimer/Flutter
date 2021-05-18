import 'package:flutter/material.dart';
import 'package:mega_sena/shared/services/ConfigService.dart';


class ConfigWidget extends StatelessWidget {

  final ConfigService _configService = ConfigService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
            title: Text(
              'Configuração',
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: _body(context),
      ),
    );
  }

  Widget _body(context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Tema da aplicação: ', style: Theme.of(context).textTheme.headline6,),
            _buildDropDownTheme(),
          ],
        )
      ],
    );
  }

  Widget _buildDropDownTheme() {
    return StreamBuilder(
      stream: _configService.currentTheme.stream,
      builder: (context, _) {
        return DropdownButton<String>(
              onChanged: (value) {
                _configService.currentTheme.add(value!);
              },
              value: _configService.currentValue,
              items: _configService.items
              .map<DropdownMenuItem<String>>((item) => DropdownMenuItem<String>(
                child: Text(item),
                value: item
              )).toList(),
            );
      },
    );
  }

}