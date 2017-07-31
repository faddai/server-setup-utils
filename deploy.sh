#!/bin/bash

ENV=$1
BRANCH="develop"
DIR="intalekt-micro"

if [ ${ENV} == "production" ]; then
    BRANCH="master"
    DIR="intalektmicro.betternowfinance.co.zm"
fi

# deploy changes
cd ${DIR}
git pull origin ${BRANCH}
composer install --no-dev

# if there is some seeding to be done, it must
# done manually in the production environment
if [[ ${ENV} == sandbox ]]; then
    php artisan migrate --seed
fi

bower install
