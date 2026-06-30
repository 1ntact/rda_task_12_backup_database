#! /bin/bash

#Делаем бек-ап текущей базыданных. | Create back-up for current database.
mysqldump -u"$DB_USER" -p"$DB_PASSWORD"  ShopDB --result-file=ShopDB_full_backup.sql

#Заменяем наш старый бек-ап на текущий который мы только что сделали.
#Replace our old back-up with new one that we have just created.
mysql -u"$DB_USER" -p"$DB_PASSWORD" ShopDBReserve < ShopDB_full_backup.sql

#Снова создаем бек-ап "ShopDB" базыданных чтоб обновить базуданных в среде для разработки.
#One more time create back-up "ShopDB" databaser to update database in development environment.
mysqldump -u"$DB_USER" -p"$DB_PASSWORD" ShopDB --result-file=ShopDB_data_backup.sql --no-create-info

#Обновляем среду разработки. | Update development environment.
mysql -u"$DB_USER" -p"$DB_PASSWORD" ShopDBDevelopment < ShopDB_data_backup.sql