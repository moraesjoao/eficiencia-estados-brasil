USE projeto_indice_eficiencia;

DROP TABLE IF EXISTS base_analitica;

CREATE TABLE base_analitica AS
SELECT
p.cod_uf,
p.uf,

-- RESULTADOS ECONÔMICOS (IR)
p.valor / pop.valor AS pib_pc,
r.valor AS renda_pc,

-- MERCADO DE TRABALHO
d.valor AS desemprego,
inf.valor AS informalidade,

-- CAPITAL HUMANO
sup.valor / pop25.valor AS escolaridade,

-- ESTRUTURA PRODUTIVA
agro.valor / vab.valor AS agro_share,
ind.valor / vab.valor AS industria_share,
serv.valor / vab.valor AS servicos_share,
adm.valor / vab.valor AS adm_publica_share

FROM pib_uf p

JOIN pop_total pop 
ON p.cod_uf = pop.cod_uf

JOIN renda_pc r 
ON p.cod_uf = r.cod_uf

JOIN tx_desocupacao d 
ON p.cod_uf = d.cod_uf

JOIN tx_informalidade inf 
ON p.cod_uf = inf.cod_uf

JOIN pop_25mais_total pop25 
ON p.cod_uf = pop25.cod_uf

JOIN pop_25mais_superior sup 
ON p.cod_uf = sup.cod_uf

JOIN vab_total vab 
ON p.cod_uf = vab.cod_uf

JOIN vab_agro agro 
ON p.cod_uf = agro.cod_uf

JOIN vab_industria ind 
ON p.cod_uf = ind.cod_uf

JOIN vab_servicos serv 
ON p.cod_uf = serv.cod_uf

JOIN vab_adm_publica adm 
ON p.cod_uf = adm.cod_uf;