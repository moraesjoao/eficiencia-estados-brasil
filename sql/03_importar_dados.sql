USE projeto_indice_eficiencia;

LOAD DATA LOCAL INFILE
'C:/Users/desktop1/Documents/projeto_indice_eficiencia/dados_tratamento1/IR/pib_uf.csv'
INTO TABLE pib_uf
FIELDS TERMINATED BY ';'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(cod_uf, uf, valor);

LOAD DATA LOCAL INFILE
'C:/Users/desktop1/Documents/projeto_indice_eficiencia/dados_tratamento1/IR/pop_total.csv'
INTO TABLE pop_total
FIELDS TERMINATED BY ';'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(cod_uf, uf, valor);

LOAD DATA LOCAL INFILE
'C:/Users/desktop1/Documents/projeto_indice_eficiencia/dados_tratamento1/IR/renda_pc.csv'
INTO TABLE renda_pc
FIELDS TERMINATED BY ';'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(cod_uf, uf, valor);

LOAD DATA LOCAL INFILE
'C:/Users/desktop1/Documents/projeto_indice_eficiencia/dados_tratamento1/IR/tx_desocupacao.csv'
INTO TABLE tx_desocupacao
FIELDS TERMINATED BY ';'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(cod_uf, uf, valor);

LOAD DATA LOCAL INFILE
'C:/Users/desktop1/Documents/projeto_indice_eficiencia/dados_tratamento1/IE/pop_25mais_total.csv'
INTO TABLE pop_25mais_total
FIELDS TERMINATED BY ';'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(cod_uf, uf, valor);

LOAD DATA LOCAL INFILE
'C:/Users/desktop1/Documents/projeto_indice_eficiencia/dados_tratamento1/IE/pop_25mais_superior.csv'
INTO TABLE pop_25mais_superior
FIELDS TERMINATED BY ';'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(cod_uf, uf, valor);

LOAD DATA LOCAL INFILE
'C:/Users/desktop1/Documents/projeto_indice_eficiencia/dados_tratamento1/IE/tx_informalidade.csv'
INTO TABLE tx_informalidade
FIELDS TERMINATED BY ';'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(cod_uf, uf, valor);

LOAD DATA LOCAL INFILE
'C:/Users/desktop1/Documents/projeto_indice_eficiencia/dados_tratamento1/IE/vab_agro.csv'
INTO TABLE vab_agro
FIELDS TERMINATED BY ';'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(cod_uf, uf, valor);

LOAD DATA LOCAL INFILE
'C:/Users/desktop1/Documents/projeto_indice_eficiencia/dados_tratamento1/IE/vab_industria.csv'
INTO TABLE vab_industria
FIELDS TERMINATED BY ';'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(cod_uf, uf, valor);

LOAD DATA LOCAL INFILE
'C:/Users/desktop1/Documents/projeto_indice_eficiencia/dados_tratamento1/IE/vab_servicos.csv'
INTO TABLE vab_servicos
FIELDS TERMINATED BY ';'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(cod_uf, uf, valor);

LOAD DATA LOCAL INFILE
'C:/Users/desktop1/Documents/projeto_indice_eficiencia/dados_tratamento1/IE/vab_adm_publica.csv'
INTO TABLE vab_adm_publica
FIELDS TERMINATED BY ';'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(cod_uf, uf, valor);

LOAD DATA LOCAL INFILE
'C:/Users/desktop1/Documents/projeto_indice_eficiencia/dados_tratamento1/IE/vab_total.csv'
INTO TABLE vab_total
FIELDS TERMINATED BY ';'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(cod_uf, uf, valor);