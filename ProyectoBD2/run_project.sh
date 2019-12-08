#!/bin/bash
#
# Autores: 
# Marco Benitez		13-10137
# Neil Villamizar	15-11523
#
# Script para correr el proyecto
#
sudo -u postgres psql -f create_db.sql;
echo 'Data Base created';
echo 'Creating tables';
sudo -u postgres psql -f create.sql;
echo 'Creating procedure Bid'
sudo -u postgres psql -f procedureBid.sql; 
echo 'Creating procedure undoLastBid'
sudo -u postgres psql -f procedureUndoLastBid.sql;
echo 'Creating trigger'
sudo -u postgres psql -f trigger_es_hoja.sql;
echo 'Inserting data into tables';
sudo -u postgres psql -f insert.sql;
echo 'Query 1:'
sudo -u postgres psql -f query1.sql;
echo 'Query 2:'
sudo -u postgres psql -f query2.sql;