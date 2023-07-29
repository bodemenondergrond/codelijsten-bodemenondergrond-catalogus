#!/bin/bash

sparql --data=../resources/be/vlaanderen/bodemenondergrond/data/id/catalog/codelijsten-bodemenondergrond-catalogus/catalog.ttl --query ../sparql/catalog_visualisatie.sparql --results=TURTLE | rdf2dot  | dot -Tpng > ../sparql/catalog_visualisatie.png
pushd  ../../..
git pull
mvn clean install
jar=`ls target/*.jar | grep -v sources | grep -v original`
unzip $jar -d target
find target/be  | grep ttl | xargs riot --formatted=TURTLE > /tmp/catalog.ttl
popd
sparql --data=/tmp/catalog.ttl --query ../sparql/catalog_visualisatie.sparql --results=TURTLE | rdf2dot  | sed -e 's/digraph {/digraph {rankdir="LR"/' | dot -Tpng > ../sparql/volledige_catalog_visualisatie.png


