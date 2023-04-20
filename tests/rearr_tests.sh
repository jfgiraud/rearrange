#!/bin/bash

cd $(dirname $(readlink -f $0))

total=0
ok=0
ko=0

function assert_equals() {
    total=$((total+1))
    expected="$1"
    actual="$2"
    message="$3"
    if [[ "$expected" == "$actual" ]]; then
        ok=$((ok+1))
        echo "OK: ${message}" >&2
    else
        ko=$((ko+1))
        echo "KO: ${message}" >&2
        echo "   expects: ${expected}" >&2
        echo "   but receives: ${actual}" >&2
    fi
}

function assert_exec_equals() {
    command="${1}"
    actual=$(eval "${command}")
    expected="${2}"
    assert_equals "${expected}" "${actual}" "${command}"

}

read -r -d '' EXPECTED <<'EOF'
region;code_departement;nom_departement;prefecture_departement;superficie_km2;nombre_habitants
Auvergne-Rhône-Alpes;01;Ain;Bourg-en-Bresse;5762;655171
Hauts-de-France;02;Aisne;Laon;7369;528016
Auvergne-Rhône-Alpes;03;Allier;Moulins;7340;332882
Provence-Alpes-Côte d'Azur;04;Alpes-de-Haute-Provence;Digne-les-Bains;6925;16692
Provence-Alpes-Côte d'Azur;05;Hautes-Alpes;Gap;5548;145631
Provence-Alpes-Côte d'Azur;06;Alpes-Maritimes;Nice;4299;1082989
Auvergne-Rhône-Alpes;07;Ardèche;Privas;5566;326336
Grand Est;08;Ardennes;Charleville-Mézières;5225;271251
Occitanie;09;Ariège;Foix;4890;155697
EOF

assert_exec_equals \
    "cd .. ; ./bin/rearr -f4,1:3,-2: -d, -o';' tests/departements.csv | head" \
     "${EXPECTED}"

echo "${ok}/${total} (${ko} errors)"

if [[ ${ok} -ne ${total} ]]; then
    exit 1
else
    exit 0
fi
