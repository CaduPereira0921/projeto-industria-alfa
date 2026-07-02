# REQ-MM-004 — Geração automática de solicitação de compra ao atingir ponto de reposição

## Identificação

| Campo | Valor |
|---|---|
| **REQ-ID** | REQ-MM-004 |
| **Tipo** | Funcional |
| **Status** | Em análise |
| **Módulo SAP** | MM |
| **Nível de Risco** | 🟡 Médio |
| **Origem** | email_roberto_11-06.txt |

---

## Ator

Sistema SAP (automático via MRP/planejamento)

---

## Gatilho

Saldo de material atinge ou cai abaixo do ponto de reposição no mestre de materiais.

---

## Descrição Funcional

O sistema deve criar automaticamente uma solicitação de compra (SC) no SAP quando o estoque de qualquer material atingir o ponto de reposição definido, sem necessidade de ação manual do comprador, e encaminhar a SC para o fluxo de aprovação configurado.

---

## Resultado Esperado

Solicitação de compra gerada automaticamente; SC disponível para o analista de compras responsável; nenhuma ação manual necessária para criação da SC.

---

## Critério de Aceite Mensurável

- 100% dos materiais com ponto de reposição atingido geram SC automaticamente em até 10 minutos
- Zero criações manuais de SC motivadas por estoque abaixo do ponto de reposição após go-live

---

## Transações SAP Prováveis

[VERIFICAR]

---

## Tipo de Solução

Configuração / A verificar — funcionalidade MRP possivelmente standard

---

## Justificativa do Risco

🟡 Médio — geração automática de SC via MRP é funcionalidade standard SAP MM; confirmar parâmetros de planejamento antes de configurar.

---

## Perguntas em Aberto

1. O cálculo do ponto de reposição já está definido para todos os materiais ou precisa ser levantado?
2. A SC deve ser gerada para um fornecedor preferencial pré-definido ou em aberto para cotação?
3. A quantidade da SC deve ser o lote padrão de compra ou calculada pelo MRP?
4. O MRP já está ou será configurado no projeto?
5. Quem é o "analista de compras responsável" referenciado por Roberto — existe vínculo no mestre de materiais?
