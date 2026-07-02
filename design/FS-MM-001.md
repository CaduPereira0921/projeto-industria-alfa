# FS-MM-001 — Entrada Única de Nota Fiscal no SAP com Eliminação do Sistema Legado Sismat

## 1. Identificação

| Código | FS-MM-001 |
|---|---|
| Versão | 0.1 — Rascunho |
| Autor | Equipe Ayesa – Consultoria SAP MM |
| Data | 02/07/2026 |
| Status | Em elaboração |
| REQ de origem | REQ-MM-001 |
| Projeto | Projeto Indústria Alfa |
| Cliente | [VERIFICAR COM CLIENTE] |

## 2. Objetivo

Eliminar o lançamento paralelo no sistema legado Sismat, concentrando o registro de entrada de mercadoria e a contabilização correspondente em uma única operação no SAP (MM-FI), reduzindo retrabalho manual, risco de divergência de estoque entre sistemas e tempo de fechamento contábil.

## 3. Módulo e Transações SAP

| Módulos | MM / FI |
|---|---|
| Transações envolvidas | [VERIFICAR COM CLIENTE] |
| Versão SAP | [VERIFICAR COM CLIENTE] — ECC 6.0 ou S/4HANA a confirmar (pergunta em aberto do URS) |

## 4. Escopo

**Dentro do escopo:**

- Lançamento de entrada de mercadoria (recebimento de NF) diretamente no SAP.

- Atualização automática de estoque no módulo MM.

- Geração automática do documento contábil correspondente no módulo FI a partir do lançamento MM.

- Descontinuação do lançamento paralelo no sistema Sismat para o processo de entrada de NF.

**Fora do escopo:**

- Migração de dados históricos do Sismat para o SAP [VERIFICAR COM CLIENTE].

- Desativação completa do Sismat para outros processos não relacionados a entrada de NF.

- Integração com sistemas fiscais/EDI de emissão de NF-e (assume-se NF já disponível para lançamento).

## 5. Fluxo Principal (caminho feliz)

1. Almoxarife recebe a nota fiscal física/eletrônica no depósito.

2. Almoxarife acessa a transação de entrada de mercadoria no SAP [VERIFICAR COM CLIENTE].

3. Sistema apresenta os dados do pedido de compra vinculado (se houver) para conferência de quantidade e preço.

4. Almoxarife confirma o lançamento de entrada.

5. Sistema atualiza o estoque do material automaticamente no módulo MM.

6. Sistema gera o documento contábil correspondente no módulo FI, sem lançamento manual.

7. Sistema disponibiliza número do documento de entrada e documento contábil para consulta.

## 6. Fluxos Alternativos

| Cenário | Tratamento esperado |
|---|---|
| NF sem pedido de compra vinculado [HERDADO DO URS] | [VERIFICAR COM CLIENTE] |
| Divergência de quantidade/preço entre NF e pedido de compra | [VERIFICAR COM CLIENTE] |
| Estorno/cancelamento de entrada já lançada | [VERIFICAR COM CLIENTE] |
| Tentativa de lançamento em período contábil fechado | [VERIFICAR COM CLIENTE] |
| Falha na geração automática do documento contábil (ex: conta não configurada) | [VERIFICAR COM CLIENTE] |

## 7. Regras de Negócio

| ID | Regra |
|---|---|
| RN01 | Toda entrada de mercadoria deve ser registrada exclusivamente no SAP; nenhum lançamento equivalente deve ser realizado no Sismat após o go-live. |
| RN02 | A geração do documento contábil deve ocorrer automaticamente e de forma síncrona ao lançamento da entrada de mercadoria, sem etapa manual intermediária. |
| RN03 | [VERIFICAR COM CLIENTE] — regra de conta contábil/centro de custo a ser debitada conforme grupo de mercadorias. |
| RN04 [HERDADO DO URS] | Critério para tratamento de dados históricos do Sismat ainda não definido — depende de definição do cliente. |

## 8. Integrações

| De | Para | Comportamento em falha |
|---|---|---|
| MM | FI | Geração automática de documento contábil na entrada de mercadoria; comportamento em falha [VERIFICAR COM CLIENTE] |
| MM | Compras (Pedido de Compra) [HERDADO DO URS] | Referência de PO na entrada, quando existente; comportamento em falha [VERIFICAR COM CLIENTE] |
| SAP | Sismat [HERDADO DO URS] | Interface de descontinuação/migração de saldo, se aplicável; comportamento em falha [VERIFICAR COM CLIENTE] |

## 9. Critérios de Aceite

| # | Critério mensurável | Método de verificação |
|---|---|---|
| CA01 | 100% das entradas de NF lançadas exclusivamente no SAP, nos primeiros 30 dias após go-live, ambiente de produção. | Relatório de lançamentos MM x ausência de registros no Sismat. |
| CA02 | Zero lançamentos duplicados no Sismat, nos primeiros 30 dias após go-live, ambiente de produção. | Auditoria de log de acesso ao Sismat. |
| CA03 | Documento contábil gerado em até 30 segundos após confirmação da entrada, ambiente de produção sob carga normal. | Comparação de timestamp entre documento MM e documento FI. |
| CA04 | [VERIFICAR COM CLIENTE] — definir critério de aceite para tratamento de dados históricos do Sismat, se aplicável. | [VERIFICAR COM CLIENTE] |

## 10. Pontos em Aberto

| # | Dúvida / Pendência | Responsável | Prazo |
|---|---|---|---|
| P01 [HERDADO DO URS] | Qual o prazo planejado para desativação definitiva do Sismat e existe dependência de outras áreas? | Cliente | [VERIFICAR COM CLIENTE] |
| P02 [HERDADO DO URS] | Há dados históricos no Sismat que precisam ser migrados para o SAP antes do go-live? | Cliente | [VERIFICAR COM CLIENTE] |
| P03 [HERDADO DO URS] | A versão SAP implantada é ECC ou S/4HANA? | Cliente/TI | [VERIFICAR COM CLIENTE] |
| P04 [HERDADO DO URS] | Quais perfis de usuário terão acesso à transação de entrada de mercadoria? | Cliente | [VERIFICAR COM CLIENTE] |
| P05 | Confirmar transações SAP a serem utilizadas para entrada de mercadoria (ex: MIGO). | Ayesa/Cliente | [VERIFICAR COM CLIENTE] |

### Aprovações

| Analista Funcional | Líder de Projeto | Cliente |
|---|---|---|
|  |  |  |
| [Nome / Data] | [Nome / Data] | [Nome / Data] |
