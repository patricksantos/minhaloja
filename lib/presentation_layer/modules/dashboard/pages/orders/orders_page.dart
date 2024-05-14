import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:minhaloja/infra/base.dart';
import 'package:minhaloja/infra/utils.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:skeletonizer/skeletonizer.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageViewState();
}

class _OrdersPageViewState extends State<OrdersPage> {
  late StoreCubit _controller;

  final List<PlutoColumn> columns = [];
  final List<PlutoRow> rows = [];

  @override
  void initState() {
    super.initState();
    _controller = Modular.get<StoreCubit>();
    _controller.getOrder();

    columns.addAll([
      PlutoColumn(
        title: 'Id',
        field: 'id',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        title: 'Documento',
        field: 'documento',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        title: 'Status',
        field: 'status',
        type: PlutoColumnType.select(<String>['Pago', 'Nāo Pago']),
      ),
      PlutoColumn(
        title: 'Envio',
        field: 'envio',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        title: 'Produtos',
        field: 'produtos',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        title: 'Quantidade',
        field: 'quantidade',
        type: PlutoColumnType.number(),
      ),
      PlutoColumn(
        title: 'Total da Compra',
        field: 'total',
        type: PlutoColumnType.currency(),
      ),
      PlutoColumn(
        title: 'Data do Pedido',
        field: 'date',
        type: PlutoColumnType.date(),
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    // final design = DesignSystem.of(context);
    final size = MediaQuery.of(context).size;
    return BlocBuilder<StoreCubit, StoreState>(
      bloc: _controller,
      builder: (context, state) {
        return LayoutBuilder(builder: (context, constraints) {
          return Skeletonizer(
            enabled: state.orderList.isEmpty,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20.width),
              height: size.height * .85,
              width: double.infinity,
              child: PlutoGrid(
                columns: columns,
                rows: state.orderList
                    .map(
                      (order) => PlutoRow(
                        cells: {
                          'id': PlutoCell(value: order.id),
                          'documento': PlutoCell(value: order.userCPF),
                          'status': PlutoCell(
                            value: order.paidOut == true ? 'Pago' : 'Nāo Pago',
                          ),
                          'envio': PlutoCell(value: order.storeType.name),
                          'produtos': PlutoCell(
                            value: order.products
                                .map((produto) => produto.name)
                                .toList()
                                .toString(),
                          ),
                          'quantidade': PlutoCell(value: order.products.length),
                          'total': PlutoCell(value: order.totalValue),
                          'date': PlutoCell(value: order.createdAt),
                        },
                      ),
                    )
                    .toList(),
                onLoaded: (PlutoGridOnLoadedEvent event) {
                  event.stateManager.setShowColumnFilter(true);
                },
                onChanged: (PlutoGridOnChangedEvent event) {
                  print(event);
                },
                configuration: PlutoGridConfiguration(
                  localeText: const PlutoGridLocaleText.brazilianPortuguese(),
                  columnFilter: PlutoGridColumnFilterConfig(
                    filters: const [
                      ...FilterHelper.defaultFilters,
                      // ClassYouImplemented(),
                    ],
                    resolveDefaultColumnFilter: (column, resolver) {
                      if (column.field == 'text') {
                        return resolver<PlutoFilterTypeContains>()
                            as PlutoFilterType;
                      } else if (column.field == 'number') {
                        return resolver<PlutoFilterTypeGreaterThan>()
                            as PlutoFilterType;
                      } else if (column.field == 'date') {
                        return resolver<PlutoFilterTypeEquals>()
                            as PlutoFilterType;
                      }
                      return resolver<PlutoFilterTypeContains>()
                          as PlutoFilterType;
                    },
                  ),
                ),
              ),
            ),
          );
        });
      },
    );
  }
}

class ClassYouImplemented implements PlutoFilterType {
  @override
  String get title => 'Custom contains';

  @override
  get compare => ({
        required String? base,
        required String? search,
        required PlutoColumn? column,
      }) {
        var keys = search!.split(',').map((e) => e.toUpperCase()).toList();

        return keys.contains(base!.toUpperCase());
      };

  const ClassYouImplemented();
}
