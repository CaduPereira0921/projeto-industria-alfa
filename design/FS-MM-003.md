# FS-MM-003 — Alerta Automático ao Responsável quando Estoque Atingir Ponto de Reposição

## 1. Identificação

| Código | FS-MM-003 |
|---|---|
| Versão | 0.1 — Rascunho |
| Autor | Equipe Ayesa – Consultoria SAP MM |
| Data | 02/07/2026 |
| Status | ⚠️ Em elaboração — Conflito em aberto (destinatário do alerta) |
| REQ de origem | REQ-MM-003 |
| Projeto | Projeto Indústria Alfa |
| Cliente | [VERIFICAR COM CLIENTE] |

## 2. Objetivo

Substituir o controle manual de ponto de reposição feito em planilha por um alerta automático gerado pelo SAP, reduzindo o risco de ruptura de estoque por falta de acompanhamento tempestivo.

## 3. Módulo e Transações SAP

| Módulos | MM |
|---|---|
| Transações envolvidas | [VERIFICAR COM CLIENTE] |
| Versão SAP | [VERIFICAR COM CLIENTE] |

## 4. Escopo

**Dentro do escopo:**

- Geração automática de alerta quando o saldo do material atingir ou ficar abaixo do ponto de reposição cadastrado no mestre de materiais.

- Envio do alerta ao responsável designado (notificação interna SAP e/ou e-mail).

**Fora do escopo:**

- Definição do destinatário final do alerta — CONFLITO EM ABERTO, ver Seção 10.

- Cálculo dinâmico do ponto de reposição (assume-se valor já cadastrado no mestre de materiais) [VERIFICAR COM CLIENTE].

## 5. Fluxo Principal (caminho feliz)

1. Sistema monitora o saldo de cada material com ponto de reposição configurado.

2. Saldo do material atinge ou fica abaixo do ponto de reposição.

3. Sistema identifica o responsável designado para o material/grupo de mercadorias [VERIFICAR COM CLIENTE — CONFLITO].

4. Sistema gera e envia o alerta (notificação SAP e/ou e-mail) ao responsável.

5. Alerta fica disponível para consulta/histórico.

## 6. Fluxos Alternativos

| Cenário | Tratamento esperado |
|---|---|
| Falha no envio do e-mail (bounce/servidor indisponível) [HERDADO DO URS] | [VERIFICAR COM CLIENTE] |
| Responsável não cadastrado no mestre de materiais [HERDADO DO URS] | [VERIFICAR COM CLIENTE] |
| Saldo oscila repetidamente em torno do ponto de reposição, gerando alertas duplicados em curto intervalo [HERDADO DO URS] | [VERIFICAR COM CLIENTE] |

## 7. Regras de Negócio

| ID | Regra |
|---|---|
| RN01 | O alerta deve ser disparado sempre que o saldo do material atingir ou ficar abaixo do ponto de reposição definido no mestre de materiais. |
| RN02 [CONFLITO — HERDADO DO URS] | Destinatário do alerta ainda não definido — Carlos (e-mail 09/06) indica "comprador responsável"; Roberto (e-mail 11/06) indica "analista de compras". Necessário workshop de alinhamento entre Logística e Compras. |
| RN03 | [VERIFICAR COM CLIENTE] — regra de supressão de alertas duplicados dentro de uma janela de tempo. |

## 8. Integrações

| De | Para | Comportamento em falha |
|---|---|---|
| MM | Servidor de e-mail (SMTP) [HERDADO DO URS] | Envio de alerta externo; comportamento em falha [VERIFICAR COM CLIENTE] |
| MM | MRP/Planejamento | Referência ao ponto de reposição cadastrado; [VERIFICAR COM CLIENTE] |

## 9. Critérios de Aceite

| # | Critério mensurável | Método de verificação |
|---|---|---|
| CA01 | Alerta gerado em até 5 minutos após o saldo atingir o ponto de reposição, ambiente de produção sob carga normal. | Comparação de timestamp do evento de saldo x timestamp do alerta. |
| CA02 | 100% dos materiais com ponto de reposição configurado geram alerta corretamente, nos primeiros 30 dias após go-live. | Relatório de materiais x alertas emitidos. |
| CA03 | "Zero alertas perdidos comparado ao controle em planilha" não é critério mensurável/verificável por QA — substituir por: 100% dos materiais elegíveis com alerta emitido, ambiente de produção. | Comparação entre lista de materiais elegíveis e alertas efetivamente emitidos. |

## 10. Pontos em Aberto

| # | Dúvida / Pendência | Responsável | Prazo |
|---|---|---|---|
| P01 [HERDADO DO URS] ⚠️ | CONFLITO: Quem é o destinatário correto do alerta — comprador responsável (Carlos) ou analista de compras (Roberto)? | Logística/Compras | [VERIFICAR COM CLIENTE] |
| P02 [HERDADO DO URS] | O ponto de reposição é fixo ou calculado dinamicamente (ex: média de consumo × lead time)? | Cliente | [VERIFICAR COM CLIENTE] |
| P03 [HERDADO DO URS] | O alerta deve ser apenas interno ao SAP ou também por e-mail externo? | Cliente | [VERIFICAR COM CLIENTE] |
| P04 [HERDADO DO URS] | Existe mestre de compradores/analistas já configurado ou será necessário criá-lo? | Cliente/TI | [VERIFICAR COM CLIENTE] |
| P05 [HERDADO DO URS] | O alerta deve ser por material, grupo de mercadorias ou depósito? | Cliente | [VERIFICAR COM CLIENTE] |

### Aprovações

| Analista Funcional | Líder de Projeto | Cliente |
|---|---|---|
|  |  |  |
| [Nome / Data] | [Nome / Data] | [Nome / Data] |
