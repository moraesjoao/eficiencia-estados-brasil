USE projeto_indice_eficiencia;

DROP TABLE IF EXISTS base_normalizada;

CREATE TABLE base_normalizada AS

WITH base_tratada AS (
    SELECT
        cod_uf,
        uf,

        pib_pc,
        renda_pc,

        -- Ajuste de escala (% → proporção)
        desemprego / 100 AS desemprego,
        informalidade / 100 AS informalidade,
        adm_publica_share, -- já parece proporção
        escolaridade,

        -- Correções (quanto maior = melhor)
        (1 - (desemprego / 100)) AS emprego,
        (1 - adm_publica_share) AS dep_privada,
        (1 - (informalidade / 100)) AS formalidade

    FROM base_analitica
),

normalizado AS (
    SELECT
        cod_uf,
        uf,

        pib_pc,
        renda_pc,
        emprego,
        escolaridade,
        dep_privada,
        formalidade,

        -- Normalização Min-Max
        (pib_pc - MIN(pib_pc) OVER()) / NULLIF(MAX(pib_pc) OVER() - MIN(pib_pc) OVER(), 0) AS pib_n,
        (renda_pc - MIN(renda_pc) OVER()) / NULLIF(MAX(renda_pc) OVER() - MIN(renda_pc) OVER(), 0) AS renda_n,
        (emprego - MIN(emprego) OVER()) / NULLIF(MAX(emprego) OVER() - MIN(emprego) OVER(), 0) AS emprego_n,

        (escolaridade - MIN(escolaridade) OVER()) / NULLIF(MAX(escolaridade) OVER() - MIN(escolaridade) OVER(), 0) AS escolaridade_n,
        (dep_privada - MIN(dep_privada) OVER()) / NULLIF(MAX(dep_privada) OVER() - MIN(dep_privada) OVER(), 0) AS dep_privada_n,
        (formalidade - MIN(formalidade) OVER()) / NULLIF(MAX(formalidade) OVER() - MIN(formalidade) OVER(), 0) AS formalidade_n

    FROM base_tratada
)

SELECT * FROM normalizado;