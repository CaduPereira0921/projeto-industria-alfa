# REQ-MM-002 — Bloqueio automático de saída de material com estoque zerado ou negativo

## Identificação

| Campo | Valor |
|---|---|
| **REQ-ID** | REQ-MM-002 |
| **Tipo** | Funcional |
| **Status** | Em análise |
| **Módulo SAP** | MM |
| **Nível de Risco** | 🔴 Alto |
| **Origem** | ata_blueprint_08-06.txt \| email_carlos_09-06.txt |

---

## Ator

Almoxarife / Sistema SAP

---

## Gatilho

Tentativa de lançamento de saída de material sem saldo disponível.

---

## Descrição Funcional

O sistema deve impedir automaticamente qualquer lançamento de saída de material quando o saldo do material estiver zerado ou negativo, exibindo mensagem de erro ao usuário e não permitindo a confirmação da operação.

---

## Resultado Esperado

Saída bloqueada; mensagem de erro exibida ao usuário; estoque não fica negativo.

---

## Critério de Aceite Mensurável

- Zero ocorrências de estoque negativo após go-live
- 100% das tentativas de saída sem saldo rejeitadas pelo sistema com código de erro rastreável

---

## Transações SAP Prováveis

[VERIFICAR]

---

## Tipo de Solução

Configuração / A verificar

---

## Justificativa do Risco

🔴 Alto — problema recorrente com impacto direto no fechamento mensal; requer validação se SAP standard resolve sem desenvolvimento Z.

---

## Perguntas em Aberto

1. Existem exceções legítimas em que a saída sem saldo deve ser permitida (ex: estorno, ajuste de inventário)?
2. Quais movimentos de material (tipos de movimento SAP) devem ser cobertos pelo bloqueio?
3. A versão SAP é ECC ou S/4HANA? (impacta configuração de tolerância negativa)
4. Quem deve ser notificado quando uma saída for bloqueada — o almoxarife, o supervisor ou ambos?
5. Existe necessidade de workflow de aprovação para liberar excepcionalmente uma saída bloqueada?
