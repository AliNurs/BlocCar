part of '../cars_screen.dart';

class _AppBar extends StatefulWidget with PreferredSizeWidget {
  const _AppBar({Key? key}) : super(key: key);

  @override
  State<_AppBar> createState() => __AppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(60);
}

class __AppBarState extends State<_AppBar> {
  List<String> filters = [
    'По году',
    'По цене',
    'По названию',
  ];

  String? filterValue;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: SizedBox(
        height: 45,
        child: TextField(
          onChanged: (text) {
            BlocProvider.of<CarBloc>(context).add(SearchCars(text));
          },
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            fillColor: Colors.white,
            filled: true,
          ),
        ),
      ),
      actions: [
        const SizedBox(width: 16),
        DropdownButton<String>(
          value: filterValue,
          items: filters
              .map(
                (e) => DropdownMenuItem(
                  value: e,
                  child: Text(e),
                ),
              )
              .toList(),
          onChanged: (value) {
            switch (value) {
              case 'По году':
                BlocProvider.of<CarBloc>(context)
                    .add(FilterCars(Filters.byYear));
                break;
              case 'По цене':
                BlocProvider.of<CarBloc>(context)
                    .add(FilterCars(Filters.byPrice));
                break;
              case 'По названию':
                BlocProvider.of<CarBloc>(context)
                    .add(FilterCars(Filters.byName));
                break;
              default:
            }

            filterValue = value;
            setState(() {});
          },
        ),
      ],
    );
  }
}
