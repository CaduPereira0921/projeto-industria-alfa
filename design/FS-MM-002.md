# FS-MM-002 — Bloqueio Automático de Saída de Material com Estoque Zerado ou Negativo

## 1. Identificação

| Código | FS-MM-002 |
|---|---|
| Versão | 0.1 — Rascunho |
| Autor | Equipe Ayesa – Consultoria SAP MM |
| Data | 02/07/2026 |
| Status | Em elaboração |
| REQ de origem | REQ-MM-002 |
| Projeto | Projeto Indústria Alfa |
| Cliente | [VERIFICAR COM CLIENTE] |

## 2. Objetivo

Impedir a ocorrência de estoque negativo por meio de bloqueio automático de saídas de material sem saldo disponível, eliminando o impacto recorrente no fechamento mensal causado por divergências de estoque.

## 3. Módulo e Transações SAP

| Módulos | MM |
|---|---|
| Transações envolvidas | [VERIFICAR COM CLIENTE] |
| Versão SAP | [VERIFICAR COM CLIENTE] |

## 4. Escopo

**Dentro do escopo:**

- Validação automática de saldo disponível no momento do lançamento de saída de material.

- Bloqueio da confirmação da operação quando o saldo for zero ou insuficiente.

- Exibição de mensagem de erro rastreável ao usuário.

**Fora do escopo:**

- Workflow de aprovação para liberação excepcional de saída bloqueada [VERIFICAR COM CLIENTE].

- Ajustes de inventário e estornos (tratados como fluxo alternativo, não como escopo principal desta FS).

## 5. Fluxo Principal (caminho feliz)

1. Almoxarife inicia lançamento de saída de material no SAP.

2. Sistema verifica o saldo disponível do material no depósito/centro informado.

3. Se saldo suficiente, sistema permite a confirmação da saída.

4. Sistema atualiza o estoque automaticamente.

5. Sistema registra o documento de saída.

## 6. Fluxos Alternativos

| Cenário | Tratamento esperado |
|---|---|
| Saldo zerado ou insuficiente para a quantidade solicitada | Sistema bloqueia a confirmação e exibe mensagem de erro com código rastreável; saída não é registrada. |
| Estorno de saída/ajuste de inventário exigindo movimentação com saldo negativo temporário [HERDADO DO URS] | [VERIFICAR COM CLIENTE] |
| Liberação excepcional de saída bloqueada mediante aprovação [HERDADO DO URS] | [VERIFICAR COM CLIENTE] |
| Tipo de movimento não coberto pela regra de bloqueio [HERDADO DO URS] | [VERIFICAR COM CLIENTE] |

## 7. Regras de Negócio

| ID | Regra |
|---|---|
| RN01 | O sistema não deve permitir a confirmação de saída de material quando o saldo resultante for negativo, salvo tipos de movimento expressamente excluídos [VERIFICAR COM CLIENTE]. |
| RN02 | Toda tentativa de saída bloqueada deve gerar mensagem de erro com código identificável para fins de auditoria. |
| RN03 | [VERIFICAR COM CLIENTE] — definição de tolerância negativa (se aplicável em cenários específicos, ex: S/4HANA). |

## 8. Integrações

| De | Para | Comportamento em falha |
|---|---|---|
| MM | Notificação (e-mail/SAP Inbox) ao supervisor [HERDADO DO URS] | Notificação em caso de bloqueio recorrente; comportamento em falha [VERIFICAR COM CLIENTE] |
| MM | WM/EWM (se depósito gerenciado) [HERDADO DO URS] | [VERIFICAR COM CLIENTE] |

## 9. Critérios de Aceite

| # | Critério mensurável | Método de verificação |
|---|---|---|
| CA01 | Zero ocorrências de estoque negativo, medido nos 90 dias após go-live, ambiente de produção. | Relatório de saldo de estoque [VERIFICAR COM CLIENTE — ex: MB52]. |
| CA02 | 100% das tentativas de saída sem saldo suficiente rejeitadas com código de erro rastreável, ambiente de produção. | Log de mensagens do sistema. |
| CA03 | [VERIFICAR COM CLIENTE] — definir critério mensurável para tratamento de exceções legítimas (estorno/ajuste de inventário), caso aplicável. | [VERIFICAR COM CLIENTE] |

## 10. Pontos em Aberto

| # | Dúvida / Pendência | Responsável | Prazo |
|---|---|---|---|
| P01 [HERDADO DO URS] | Existem exceções legítimas em que a saída sem saldo deve ser permitida (estorno, ajuste de inventário)? | Cliente | [VERIFICAR COM CLIENTE] |
| P02 [HERDADO DO URS] | Quais tipos de movimento SAP devem ser cobertos pelo bloqueio? | Cliente | [VERIFICAR COM CLIENTE] |
| P03 [HERDADO DO URS] | SAP é ECC ou S/4HANA (impacta configuração de tolerância negativa)? | Cliente/TI | [VERIFICAR COM CLIENTE] |
| P04 [HERDADO DO URS] | Quem deve ser notificado quando uma saída for bloqueada — almoxarife, supervisor ou ambos? | Cliente | [VERIFICAR COM CLIENTE] |
| P05 [HERDADO DO URS] | Existe necessidade de workflow de aprovação para liberação excepcional de saída bloqueada? | Cliente | [VERIFICAR COM CLIENTE] |

### Aprovações

| Analista Funcional | Líder de Projeto | Cliente |
|---|---|---|
|  |  |  |
| [Nome / Data] | [Nome / Data] | [Nome / Data] |
