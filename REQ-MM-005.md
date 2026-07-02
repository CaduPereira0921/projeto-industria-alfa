# REQ-MM-005 — Workflow de aprovação de pedido de compra por faixas de valor

## Identificação

| Campo | Valor |
|---|---|
| **REQ-ID** | REQ-MM-005 |
| **Tipo** | Funcional |
| **Status** | Em análise |
| **Módulo SAP** | MM |
| **Nível de Risco** | 🟡 Médio |
| **Origem** | email_roberto_11-06.txt |

---

## Ator

Sistema SAP (workflow automático)

---

## Gatilho

Criação ou alteração de pedido de compra (PO) no SAP.

---

## Descrição Funcional

O sistema deve implementar workflow automático de aprovação de pedidos de compra conforme faixas de valor:
- Até R$ 50.000 → aprovação pelo Supervisor de Compras
- De R$ 50.001 a R$ 200.000 → aprovação pelo Gerente
- Acima de R$ 200.000 → aprovação pelo Diretor de Compras

---

## Resultado Esperado

PO bloqueada para liberação até aprovação do nível correto; aprovadores notificados automaticamente; PO só liberada para fornecedor após aprovação completa.

---

## Critério de Aceite Mensurável

- 100% das POs roteadas para o aprovador correto conforme faixa de valor
- Zero POs aprovadas por nível abaixo do exigido
- Tempo de notificação ao aprovador inferior a 5 minutos após criação da PO

---

## Transações SAP Prováveis

[VERIFICAR]

---

## Tipo de Solução

Configuração — estratégia de liberação SAP standard

---

## Justificativa do Risco

🟡 Médio — estratégia de liberação (release strategy) é funcionalidade standard do SAP MM; confirmar se haverá delegação de aprovação em caso de ausência.

---

## Perguntas em Aberto

1. O que acontece se o aprovador estiver ausente (férias, afastamento)? Existe aprovador substituto?
2. As faixas de valor se aplicam ao valor total do PO ou ao valor por item?
3. Um PO que começa abaixo de R$ 50.000 e tem itens adicionados ultrapassando o limite deve reentrar no workflow?
4. Existe prazo máximo para aprovação? O que acontece se o prazo vencer sem aprovação?
5. As faixas de valor são fixas ou revisadas periodicamente?
