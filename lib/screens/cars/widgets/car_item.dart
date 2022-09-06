part of '../cars_screen.dart';

class _CarItem extends StatelessWidget {
  const _CarItem({
    Key? key,
    required this.model,
  }) : super(key: key);

  final CarModel model;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (model.localimage != null)
          Container(
            height: 200,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: FileImage(model.localimage!),
              ),
            ),
            width: double.infinity,
          ),
        if (model.urlImage != null || model.urlImage!.isNotEmpty)
          CachedNetworkImage(
            imageUrl: model.urlImage!,
            imageBuilder: (context, imageProvider) => Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            placeholder: (context, url) => const SizedBox(
                height: 200, child: Center(child: CircularProgressIndicator())),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${model.brand} ${model.model}',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              '${model.year} год',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.blue,
              ),
            ),
          ],
        ),
        Text(
          '${model.price} \$',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Colors.blue,
          ),
        ),
      ],
    );
  }
}
