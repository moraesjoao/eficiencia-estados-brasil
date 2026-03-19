USE projeto_indice_eficiencia;

DROP TABLE IF EXISTS base_eficiencia_export;

CREATE TABLE base_eficiencia_export AS
SELECT
    cod_uf,
    uf,

    -- transforma 0.219762 em '0,219762' para Sheets BR
    REPLACE(ROUND(eficiencia + 1, 6), '.', ',') AS eficiencia,
    REPLACE(ROUND(IE, 6), '.', ',') AS IE,
    REPLACE(ROUND(IR, 6), '.', ',') AS IR,

    quadrante,

    REPLACE(ROUND(pib_pc, 2), '.', ',') AS pib_pc,
    REPLACE(ROUND(renda_pc, 2), '.', ',') AS renda_pc,
    REPLACE(ROUND(emprego, 4), '.', ',') AS emprego,
    REPLACE(ROUND(escolaridade, 4), '.', ',') AS escolaridade,
    REPLACE(ROUND(dep_privada, 4), '.', ',') AS dep_privada,
    REPLACE(ROUND(formalidade, 4), '.', ',') AS formalidade

FROM base_eficiencia;