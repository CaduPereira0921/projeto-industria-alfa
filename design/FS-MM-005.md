# FS-MM-005 — Workflow de Aprovação de Pedido de Compra por Faixas de Valor

## 1. Identificação

| Código | FS-MM-005 |
|---|---|
| Versão | 0.1 — Rascunho |
| Autor | Equipe Ayesa – Consultoria SAP MM |
| Data | 02/07/2026 |
| Status | Em elaboração |
| REQ de origem | REQ-MM-005 |
| Projeto | Projeto Indústria Alfa |
| Cliente | [VERIFICAR COM CLIENTE] |

## 2. Objetivo

Garantir que todo Pedido de Compra seja aprovado pelo nível hierárquico correto conforme seu valor, por meio de estratégia de liberação automática no SAP, evitando aprovações fora de alçada.

## 3. Módulo e Transações SAP

| Módulos | MM |
|---|---|
| Transações envolvidas | [VERIFICAR COM CLIENTE] |
| Versão SAP | [VERIFICAR COM CLIENTE] |

## 4. Escopo

**Dentro do escopo:**

- Roteamento automático de PO para aprovação conforme faixas de valor: até R$ 50.000 (Supervisor de Compras), R$ 50.001–200.000 (Gerente), acima de R$ 200.000 (Diretor de Compras).

- Bloqueio de liberação da PO ao fornecedor até aprovação completa.

- Notificação automática ao aprovador.

**Fora do escopo:**

- Delegação de aprovação em caso de ausência do aprovador [VERIFICAR COM CLIENTE].

- Revisão periódica das faixas de valor (processo de governança, fora do escopo técnico desta FS).

## 5. Fluxo Principal (caminho feliz)

1. Usuário cria ou altera um Pedido de Compra (PO) no SAP.

2. Sistema calcula o valor total da PO e identifica a faixa de aprovação aplicável.

3. Sistema bloqueia a liberação da PO para o fornecedor até aprovação.

4. Sistema notifica automaticamente o aprovador correspondente à faixa de valor.

5. Aprovador aprova a PO no nível exigido.

6. Sistema libera a PO para envio ao fornecedor após aprovação completa.

## 6. Fluxos Alternativos

| Cenário | Tratamento esperado |
|---|---|
| Aprovador ausente (férias/afastamento) sem substituto definido [HERDADO DO URS] | [VERIFICAR COM CLIENTE] |
| PO reprovada pelo aprovador | [VERIFICAR COM CLIENTE] |
| Itens adicionados a uma PO após criação elevam o valor para faixa superior [HERDADO DO URS] | [VERIFICAR COM CLIENTE] |
| Prazo de aprovação expira sem decisão do aprovador [HERDADO DO URS] | [VERIFICAR COM CLIENTE] |

## 7. Regras de Negócio

| ID | Regra |
|---|---|
| RN01 | PO com valor total até R$ 50.000,00 deve ser aprovada pelo Supervisor de Compras. |
| RN02 | PO com valor total entre R$ 50.001,00 e R$ 200.000,00 deve ser aprovada pelo Gerente. |
| RN03 | PO com valor total acima de R$ 200.000,00 deve ser aprovada pelo Diretor de Compras. |
| RN04 | [VERIFICAR COM CLIENTE] — se as faixas de valor se aplicam ao valor total da PO ou por item (impacta configuração da estratégia de liberação). |
| RN05 [HERDADO DO URS] | Regra de reentrada no workflow quando PO ultrapassa faixa após alteração ainda não definida. |

## 8. Integrações

| De | Para | Comportamento em falha |
|---|---|---|
| MM | SAP Business Workflow (notificação ao aprovador) [HERDADO DO URS] | [VERIFICAR COM CLIENTE] |
| MM | E-mail/Fiori (canal de notificação e aprovação mobile) [HERDADO DO URS] | [VERIFICAR COM CLIENTE] |

## 9. Critérios de Aceite

| # | Critério mensurável | Método de verificação |
|---|---|---|
| CA01 | 100% das POs roteadas para o aprovador correto conforme faixa de valor, nos primeiros 30 dias após go-live, ambiente de produção. | Relatório de estratégia de liberação. |
| CA02 | Zero POs aprovadas por nível abaixo do exigido, nos primeiros 30 dias após go-live, ambiente de produção. | Auditoria de log de aprovação. |
| CA03 | Tempo de notificação ao aprovador inferior a 5 minutos após criação da PO, ambiente de produção. | Comparação de timestamp de criação da PO x timestamp de envio da notificação. |

## 10. Pontos em Aberto

| # | Dúvida / Pendência | Responsável | Prazo |
|---|---|---|---|
| P01 [HERDADO DO URS] | O que acontece se o aprovador estiver ausente (férias, afastamento)? Existe aprovador substituto? | Cliente | [VERIFICAR COM CLIENTE] |
| P02 [HERDADO DO URS] | As faixas de valor se aplicam ao valor total do PO ou ao valor por item? | Cliente | [VERIFICAR COM CLIENTE] |
| P03 [HERDADO DO URS] | PO que inicia abaixo de R$ 50.000 e recebe itens que ultrapassam o limite deve reentrar no workflow? | Cliente | [VERIFICAR COM CLIENTE] |
| P04 [HERDADO DO URS] | Existe prazo máximo para aprovação? O que ocorre se o prazo vencer sem aprovação? | Cliente | [VERIFICAR COM CLIENTE] |
| P05 [HERDADO DO URS] | As faixas de valor são fixas ou revisadas periodicamente? | Cliente | [VERIFICAR COM CLIENTE] |

### Aprovações

| Analista Funcional | Líder de Projeto | Cliente |
|---|---|---|
|  |  |  |
| [Nome / Data] | [Nome / Data] | [Nome / Data] |
