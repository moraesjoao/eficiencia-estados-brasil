## Dashboard interativo
https://lookerstudio.google.com/reporting/a5d23c9a-0b09-42a4-a8e8-11b072e41e9e

---

# Eficiência Econômica dos Estados Brasileiros  
### Uma análise baseada em estrutura produtiva e desempenho relativo

Este projeto analisa a eficiência econômica dos estados brasileiros, comparando o desempenho observado com o desempenho esperado dado sua estrutura produtiva (dados do IBGE/SIDRA).

A metodologia utiliza regressão linear para estimar o resultado esperado e calcula a eficiência como o desvio em relação a esse valor.

---

## Objetivo  
Identificar quais estados:

- Entregam acima do esperado dado sua estrutura  
- Possuem alto potencial não convertido  
- Apresentam baixa eficiência estrutural
  
---

## Metodologia

O modelo é baseado em dois índices principais:

### Índice de Estrutura (IE)
- Escolaridade  
- Formalidade  
- Baixa dependência do setor público  

### Índice de Resultado (IR)
- PIB per capita  
- Renda per capita  
- Emprego  

A relação entre IE e IR é modelada via regressão linear:


IR esperado = α + β × IE  
Eficiência = IR observado - IR esperado


---

## Pipeline de dados

```
SIDRA (IBGE)  
↓  
Tratamento inicial (CSV)  
↓  
MySQL  
↓  
Base analítica  
↓  
Normalização (Min-Max)  
↓  
Cálculo de índices (IE e IR)  
↓  
Regressão linear  
↓  
Eficiência (resíduo)  
↓  
Exportação para Google Sheets  
↓  
Dashboard no Looker Studio  
```


---

## Estrutura do projeto

```
dados_brutos/  
dados_tratamento1/  
sql/  
├── 01_criar_banco.sql  
├── 02_criar_tabelas.sql  
├── 03_importar_dados.sql  
├── 04_criar_base_analitica.sql  
├── 05_criar_base_normalizada.sql  
├── 06_criar_base_eficiencia.sql  
└── 07_criar_base_eficiencia_export.sql  
```

---

## Dashboard

Acesse o dashboard interativo:

https://lookerstudio.google.com/reporting/a5d23c9a-0b09-42a4-a8e8-11b072e41e9e

---

## Principais insights

- Estados do Norte apresentam alta eficiência relativa mesmo com baixa estrutura  
- Estados do Sudeste possuem alta estrutura, mas nem sempre convertem isso em eficiência  
- Existe uma relação clara entre estrutura produtiva e resultado econômico, com variações relevantes  

---

## Tecnologias utilizadas

- MySQL  
- Google Sheets  
- Looker Studio  
- SQL  

## Fontes  

- PIB_UF: https://sidra.ibge.gov.br/Tabela/5938  
- Pop_total: https://sidra.ibge.gov.br/tabela/6415  
- renda_pc: https://sidra.ibge.gov.br/tabela/7531  
- Tx_desocupacao: https://sidra.ibge.gov.br/tabela/4562  
- Pop_25_anos_mais_total: https://sidra.ibge.gov.br/tabela/7135  
- Pop_25_anos_mais_superior: https://sidra.ibge.gov.br/tabela/7135  
- VAB_administracao_publica: https://sidra.ibge.gov.br/Tabela/5938  
- VAB_agropecuaria: https://sidra.ibge.gov.br/Tabela/5938  
- VAB_industria: https://sidra.ibge.gov.br/Tabela/5938  
- VAB_servicos_mercado: https://sidra.ibge.gov.br/Tabela/5938  
- VAB_total: https://sidra.ibge.gov.br/Tabela/5938  
- SQL: https://sidra.ibge.gov.br/Tabela/5938  
- Tx_informalidade: https://sidra.ibge.gov.br/tabela/4708  
