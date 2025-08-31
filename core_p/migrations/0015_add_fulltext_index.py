from django.db import migrations

class Migration(migrations.Migration):
    dependencies = [
        ('core_p', '0014_discount_discountusage_and_more'),
    ]

    operations = [
        migrations.RunSQL(
            sql=(
                "CREATE FULLTEXT INDEX ft_product_name_description "
                "ON `core_p_product` (`productName`, `productDescription`);"
            ),
            reverse_sql=(
                "DROP INDEX ft_product_name_description ON `core_p_product`;"
            )
        ),
    ]
