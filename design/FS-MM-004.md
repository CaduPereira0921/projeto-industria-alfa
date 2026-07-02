# FS-MM-004 — Geração Automática de Solicitação de Compra ao Atingir Ponto de Reposição

## 1. Identificação

| Código | FS-MM-004 |
|---|---|
| Versão | 0.1 — Rascunho |
| Autor | Equipe Ayesa – Consultoria SAP MM |
| Data | 02/07/2026 |
| Status | Em elaboração |
| REQ de origem | REQ-MM-004 |
| Projeto | Projeto Indústria Alfa |
| Cliente | [VERIFICAR COM CLIENTE] |

## 2. Objetivo

Automatizar a criação de solicitações de compra quando o estoque atingir o ponto de reposição, eliminando a ação manual do comprador e reduzindo o risco de ruptura de estoque por atraso na reposição.

## 3. Módulo e Transações SAP

| Módulos | MM |
|---|---|
| Transações envolvidas | [VERIFICAR COM CLIENTE] |
| Versão SAP | [VERIFICAR COM CLIENTE] |

## 4. Escopo

**Dentro do escopo:**

- Criação automática de Solicitação de Compra (SC) via MRP/planejamento quando o saldo atingir o ponto de reposição.

- Encaminhamento da SC ao fluxo de aprovação configurado (ver FS-MM-005).

**Fora do escopo:**

- Definição do fornecedor preferencial e regras de cotação [VERIFICAR COM CLIENTE].

- Configuração do próprio workflow de aprovação de PO (tratado na FS-MM-005).

## 5. Fluxo Principal (caminho feliz)

1. Job de MRP/planejamento é executado [VERIFICAR COM CLIENTE — periodicidade a confirmar].

2. Sistema identifica materiais com saldo igual ou abaixo do ponto de reposição.

3. Sistema gera automaticamente a Solicitação de Compra (SC) para o material identificado.

4. Sistema define a quantidade da SC conforme parâmetro de planejamento (lote padrão ou cálculo MRP) [VERIFICAR COM CLIENTE].

5. SC é disponibilizada para o analista de compras responsável.

## 6. Fluxos Alternativos

| Cenário | Tratamento esperado |
|---|---|
| Material sem fornecedor preferencial cadastrado [HERDADO DO URS] | [VERIFICAR COM CLIENTE] |
| Job de MRP não executado no dia (falha de batch) [HERDADO DO URS] | [VERIFICAR COM CLIENTE] |
| SC gerada automaticamente é cancelada manualmente pelo comprador | [VERIFICAR COM CLIENTE] |
| Material com ponto de reposição não cadastrado para todos os centros/depósitos [HERDADO DO URS] | [VERIFICAR COM CLIENTE] |

## 7. Regras de Negócio

| ID | Regra |
|---|---|
| RN01 | A SC deve ser criada automaticamente, sem intervenção manual, sempre que o saldo do material atingir o ponto de reposição cadastrado. |
| RN02 | [VERIFICAR COM CLIENTE] — regra de definição de fornecedor na SC (preferencial pré-definido vs. em aberto para cotação). |
| RN03 | [VERIFICAR COM CLIENTE] — regra de cálculo de quantidade da SC (lote padrão vs. cálculo MRP). |

## 8. Integrações

| De | Para | Comportamento em falha |
|---|---|---|
| MM | Job Scheduler SAP (execução periódica do MRP) [HERDADO DO URS] | [VERIFICAR COM CLIENTE] |
| MM | Compras/Fornecedores (vínculo de fornecedor preferencial) [HERDADO DO URS] | [VERIFICAR COM CLIENTE] |
| MM | FS-MM-005 (Workflow de aprovação de PO) | SC segue para conversão em PO conforme regras da FS-MM-005. |

## 9. Critérios de Aceite

| # | Critério mensurável | Método de verificação |
|---|---|---|
| CA01 | 100% dos materiais com ponto de reposição atingido geram SC automaticamente em até 10 minutos após execução do job de MRP, ambiente de produção. | Comparação entre lista de materiais elegíveis e SCs geradas. |
| CA02 | "Zero criações manuais de SC motivadas por estoque abaixo do ponto de reposição" não é diretamente auditável (motivação subjetiva) — substituir por: número de SCs manuais para materiais com ponto de reposição configurado deve ser zero, nos 30 dias após go-live. | Relatório de SCs manuais x SCs automáticas por material. |

## 10. Pontos em Aberto

| # | Dúvida / Pendência | Responsável | Prazo |
|---|---|---|---|
| P01 [HERDADO DO URS] | O cálculo do ponto de reposição já está definido para todos os materiais ou precisa ser levantado? | Cliente | [VERIFICAR COM CLIENTE] |
| P02 [HERDADO DO URS] | A SC deve ser gerada para fornecedor preferencial pré-definido ou em aberto para cotação? | Cliente/Compras | [VERIFICAR COM CLIENTE] |
| P03 [HERDADO DO URS] | A quantidade da SC deve ser o lote padrão de compra ou calculada pelo MRP? | Cliente | [VERIFICAR COM CLIENTE] |
| P04 [HERDADO DO URS] | O MRP já está ou será configurado no projeto? | Cliente/TI | [VERIFICAR COM CLIENTE] |
| P05 [HERDADO DO URS] | Quem é o "analista de compras responsável" — existe vínculo no mestre de materiais? | Cliente | [VERIFICAR COM CLIENTE] |

### Aprovações

| Analista Funcional | Líder de Projeto | Cliente |
|---|---|---|
|  |  |  |
| [Nome / Data] | [Nome / Data] | [Nome / Data] |
