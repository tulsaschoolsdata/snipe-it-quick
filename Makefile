SHELL = /bin/bash
DUMP_FILE = .tmp/all-databases.sql

default:
	@make docker-up
	@make wait-for-it
	@echo Now open: 'http://127.0.0.1:3051'

docker-up:
	docker-compose up -d

docker-down:
	docker-compose down

clean:
	docker-compose down -v

wait-for-it: docker-up
	docker-compose exec -T snipe-mysql /scripts/wait-for-it.sh 127.0.0.1:3306

dump: wait-for-it
	@mkdir -p $(shell dirname '$(DUMP_FILE)')
	docker-compose exec -T snipe-mysql sh -c 'exec mysqldump --all-databases -uroot -proot' > $(DUMP_FILE)

restore: wait-for-it
	docker-compose exec -T snipe-mysql sh -c 'exec mysql -uroot -proot' < $(DUMP_FILE)

snipe-it-bash: wait-for-it
	docker-compose exec snipe-it bash

snipe-it-throttle: wait-for-it
	@(echo '$(limit)' | grep -q -E '^[0-9]+$$') || (>&2 echo 'invalid limit must be integer'; exit 1)
	docker-compose exec snipe-it sed -i'' s/throttle:[0-9]\\+/throttle:$(limit)/ app/Http/Kernel.php
