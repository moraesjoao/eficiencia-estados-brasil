USE projeto_indice_eficiencia;

-- =========================================================
-- SCRIPT 06 - CRIAÇÃO DA BASE DE EFICIÊNCIA
-- Objetivo:
-- Calcular a eficiência relativa dos estados brasileiros
-- com base na diferença entre resultado observado (IR)
-- e resultado esperado (via regressão sobre IE)
-- =========================================================

DROP TABLE IF EXISTS base_eficiencia;

CREATE TABLE base_eficiencia AS

-- =========================================================
-- 1) CTE: indices
-- Cria os índices sintéticos de:
-- IR (Índice de Resultado) → Outputs
-- IE (Índice de Estrutura) → Inputs
-- =========================================================
WITH indices AS (
    SELECT
        cod_uf,
        uf,

        -- Variáveis originais (para análise posterior)
        pib_pc,
        renda_pc,
        emprego,
        escolaridade,
        dep_privada,
        formalidade,

        -- -------------------------------------------------
        -- IR (Índice de Resultado)
        -- Representa o desempenho econômico do estado
        -- Média simples de:
        -- - PIB per capita
        -- - Renda
        -- - Emprego
        -- (todas já normalizadas previamente)
        -- -------------------------------------------------
        (pib_n + renda_n + emprego_n) / 3 AS IR,

        -- -------------------------------------------------
        -- IE (Índice de Estrutura)
        -- Representa a capacidade estrutural do estado
        -- Média simples de:
        -- - Escolaridade
        -- - Dependência privada
        -- - Formalidade
        -- -------------------------------------------------
        (escolaridade_n + dep_privada_n + formalidade_n) / 3 AS IE

    FROM base_normalizada
),

-- =========================================================
-- 2) CTE: stats
-- Calcula estatísticas agregadas necessárias para
-- estimar a regressão linear (forma fechada)
-- =========================================================
stats AS (
    SELECT
        -- Média da estrutura (IE)
        AVG(IE) AS avg_IE,

        -- Média dos resultados (IR)
        AVG(IR) AS avg_IR,

        -- Média do produto IE * IR
        -- Usado para calcular covariância
        AVG(IE * IR) AS avg_IE_IR,

        -- Média do quadrado de IE
        -- Usado para calcular variância
        AVG(IE * IE) AS avg_IE2

    FROM indices
),

-- =========================================================
-- 3) CTE: regressao
-- Calcula os coeficientes da regressão linear:
--
-- IR = alpha + beta * IE
--
-- Onde:
-- beta  → sensibilidade do resultado à estrutura
-- alpha → intercepto (nível base)
-- =========================================================
regressao AS (
    SELECT

        -- -------------------------------------------------
        -- Beta (inclinação da reta)
        -- Fórmula:
        -- Cov(IE, IR) / Var(IE)
        -- -------------------------------------------------
        (avg_IE_IR - avg_IE * avg_IR) 
        / NULLIF((avg_IE2 - avg_IE * avg_IE), 0) AS beta,

        -- -------------------------------------------------
        -- Alpha (intercepto da reta)
        -- Fórmula:
        -- média(IR) - beta * média(IE)
        -- -------------------------------------------------
        (avg_IR - (
            (avg_IE_IR - avg_IE * avg_IR) 
            / NULLIF((avg_IE2 - avg_IE * avg_IE), 0)
        ) * avg_IE) AS alpha,
        
        -- Mantemos a média de IE para classificar os quadrantes
        avg_IE

    FROM stats
)

-- =========================================================
-- 4) RESULTADO FINAL
-- Calcula a eficiência de cada estado
-- =========================================================
SELECT
    i.cod_uf,
    i.uf,

    -- -----------------------------------------------------
    -- EFICIÊNCIA
    -- Diferença entre:
    -- Resultado real (IR)
    -- e Resultado esperado pela regressão
    --
    -- Interpretação:
    -- > 0 → estado entrega mais do que o esperado
    -- < 0 → estado entrega menos do que o esperado
    -- -----------------------------------------------------
    (i.IR - (r.alpha + r.beta * i.IE)) AS eficiencia,

    -- Índices principais
    i.IE,
    i.IR,
    
    -- ------------------------------------------------------
    -- CLASSIFICAÇÃO EM QUADRANTES
    --
    -- Lógica:
    -- Eixo X → IE (estrutura), comparado à média nacional
    -- Eixo Y → eficiência, comparada a zero
    --
    -- Objetivo:
    -- Segmentar os estados conforme:
    --
    -- 1. Motores econômicos:
    --    Alta estrutura + Alta eficiência
    --
    -- 2. Produtivos escondidos:
    --    Baixa estrutura + Alta eficiência
    --
    -- 3. Ricos ineficientes:
    --    Alta estrutura + Baixa eficiência
    --
    -- 4. Economias frágeis:
    --    Baixa estrutura + Baixa eficiência
    --
    -- Essa classificação permite identificar padrões
    -- estratégicos de desempenho relativo entre estados
    -- =====================================================
    CASE
        WHEN i.IE >= r.avg_IE AND (i.IR - (r.alpha + r.beta * i.IE)) >= 0
            THEN 'Alta performance'

        WHEN i.IE < r.avg_IE AND (i.IR - (r.alpha + r.beta * i.IE)) >= 0
            THEN 'Alta eficiência com baixa estrutura'

        WHEN i.IE >= r.avg_IE AND (i.IR - (r.alpha + r.beta * i.IE)) < 0
            THEN 'Alto potencial não convertido'

        ELSE 'Baixa estrutura e baixa eficiência'
    END AS quadrante,

    -- Variáveis originais (para diagnóstico)
    i.pib_pc,
    i.renda_pc,
    i.emprego,
    i.escolaridade,
    i.dep_privada,
    i.formalidade

-- CROSS JOIN:
-- Aplica os coeficientes da regressão (únicos)
-- para todos os estados
FROM indices i
CROSS JOIN regressao r;