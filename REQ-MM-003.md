# REQ-MM-003 — Alerta automático ao responsável quando estoque atingir ponto de reposição

## Identificação

| Campo | Valor |
|---|---|
| **REQ-ID** | REQ-MM-003 |
| **Tipo** | Funcional |
| **Status** | ⚠️ Conflito |
| **Módulo SAP** | MM |
| **Nível de Risco** | 🟡 Médio |
| **Origem** | email_carlos_09-06.txt \| email_roberto_11-06.txt |

---

## Ator

Sistema SAP

---

## Gatilho

Saldo de material atinge ou cai abaixo do ponto de reposição cadastrado.

---

## Descrição Funcional

O sistema deve gerar e enviar automaticamente um alerta (notificação interna SAP e/ou e-mail) para o responsável designado quando o estoque de qualquer material atingir o ponto de reposição definido no mestre de materiais.

---

## Resultado Esperado

Alerta enviado automaticamente ao responsável; ponto de reposição visível e configurável no mestre de materiais.

---

## Critério de Aceite Mensurável

- Alerta gerado em até 5 minutos após o saldo atingir o ponto de reposição
- 100% dos materiais com ponto de reposição configurado recebem alerta
- Zero alertas perdidos comparado ao controle atual em planilha

---

## Transações SAP Prováveis

[VERIFICAR]

---

## Tipo de Solução

Configuração / Desenvolvimento Z / A verificar

---

## Justificativa do Risco

🟡 Médio — funcionalidade provavelmente disponível no SAP standard via MRP/planejamento; confirmar antes de desenvolver.

---

## ⚠️ Conflito Identificado

Carlos (email_carlos_09-06) indica que o alerta vai ao **"comprador responsável"**.
Roberto (email_roberto_11-06) afirma que o destinatário deve ser o **"analista de compras"**.
Realizar workshop de alinhamento entre Logística e Compras para definir o destinatário correto.

---

## Perguntas em Aberto

1. ⚠️ CONFLITO: quem é o destinatário correto do alerta — comprador responsável ou analista de compras?
2. O ponto de reposição é fixo ou calculado dinamicamente (ex: média de consumo × lead time)?
3. O alerta deve ser apenas interno ao SAP ou também por e-mail externo?
4. Existe um mestre de compradores/analistas já configurado ou será necessário criá-lo?
5. O alerta deve ser por material, por grupo de mercadorias ou por depósito?
