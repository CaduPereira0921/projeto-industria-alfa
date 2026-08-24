# Especificação Funcional — FS-MM-001

## 1. Identificação
| Campo | Valor |
|---|---|
| Documento | FS-MM-001 |
| Cliente | [cliente] |
| Módulo | MM / FI (integração) |
| Requisito de origem | REQ-MM-001 |
| Autor | Juliana Ramos (Consultora Ayesa) |
| Versão | 1.2 |
| Status | Aprovado pelo cliente |

## 2. Objetivo
Eliminar a dupla digitação de Nota Fiscal (NF) entre o SAP e o sistema
legado Sismat, atualmente realizada manualmente pelo time de Compras e
conferida pela Controladoria. A integração deve gerar automaticamente o
documento contábil (FI) correspondente no SAP a partir da confirmação da
NF no Sismat, eliminando o retrabalho e o risco de divergência entre os
dois sistemas.

## 3. Módulo e Transações
- Módulo funcional: MM (Compras), com geração automática de lançamento em FI.
- Transações SAP envolvidas na criação manual atual (processo hoje):
  ME23N (exibição de pedido), MIRO (lançamento de fatura manual).
- Transação(ões) que a integração deve acionar automaticamente para gerar
  o documento FI: [VERIFICAR] — não confirmado ainda com o time de
  Basis/ABAP se será via BAPI de lançamento contábil ou transação
  transacional direta; validar antes do início do desenvolvimento técnico.

## 4. Escopo
**Incluso:**
- Integração assíncrona SAP ↔ Sismat para NFs de fornecedores nacionais
  já homologados no cadastro SAP.
- Geração automática do documento FI a partir da confirmação da NF.

**Fora de escopo (nesta fase):**
- NFs de fornecedores estrangeiros (processo de importação será tratado
  em requisito futuro, REQ-MM-006).
- Estorno automático de documento FI gerado incorretamente — hoje
  permanece manual via transação padrão SAP.

## 5. Fluxo Principal
1. Usuário de Compras confirma o recebimento físico da mercadoria e a NF
   correspondente é lançada no Sismat.
2. O Sismat publica um evento de confirmação de NF na fila de integração.
3. O middleware consome o evento, valida o fornecedor contra o cadastro
   SAP, e aciona a criação do documento FI.
4. O documento FI é criado no SAP, vinculado ao pedido de compra de
   origem, sem necessidade de digitação manual pela Controladoria.
5. O usuário de Compras e o Controller recebem confirmação de que o
   lançamento foi concluído.

**Critério de aceite de tempo:** os passos 2 a 4 devem ser concluídos em
até 30 segundos (SLA de negócio, definido com a Controller da área,
Patricia Souza).

## 6. Fluxos Alternativos
- **A1 — Fornecedor não cadastrado no SAP:** a integração rejeita a NF,
  não gera documento FI parcial, e notifica o time de Compras para
  regularizar o cadastro antes de reprocessar.
- **A2 — NF acima do limite de valor configurado:** a NF é encaminhada
  para aprovação manual em vez de processamento automático (limite exato
  em configuração de middleware — hoje R$ 50.000,00, sujeito a revisão).
- **A3 — Sismat indisponível no momento da confirmação:** o evento fica
  em fila e é reprocessado automaticamente quando o Sismat voltar,
  respeitando o SLA a partir do momento em que a fila é liberada.

## 7. Regras de Negócio
- RN-01: a integração só processa NFs de fornecedores já homologados no
  cadastro SAP (status "Ativo").
- RN-02: NFs de fornecedor não cadastrado devem ser rejeitadas com
  mensagem de erro clara, nunca processadas parcialmente (documento FI
  incompleto é considerado erro crítico).
- RN-03: o SLA de 30 segundos é medido do evento de confirmação da NF no
  Sismat até a criação efetiva do documento FI no SAP — não inclui o
  tempo de digitação da NF pelo usuário no Sismat.

## 8. Integrações
- SAP ↔ Sismat via middleware assíncrono, consumindo fila de eventos.
- Middleware ↔ SAP: mecanismo de chamada [VERIFICAR] (ver seção 3).
- Notificação ao usuário de Compras e à Controladoria: canal
  [VERIFICAR] — a definir se será e-mail automático ou notificação
  dentro do próprio Sismat.

## 9. Critérios de Aceite
- CA-01: documento FI gerado automaticamente em até 30 segundos após
  confirmação da NF, para fornecedor homologado.
- CA-02: NF de fornecedor não cadastrado é rejeitada, sem gerar
  documento FI parcial, com mensagem de erro visível ao usuário.
- CA-03: NF no limite máximo de valor configurado é processada
  normalmente pela via automática (não deve cair em aprovação manual por
  erro de arredondamento ou comparação).

## 10. Pontos Abertos
- [VERIFICAR] Transação/mecanismo técnico exato de criação do documento
  FI (BAPI vs. transação direta) — pendente de validação com Basis/ABAP.
- [VERIFICAR] Canal de notificação ao usuário (e-mail vs. dentro do
  Sismat).
- Confirmar com a Controladoria se o limite de R$ 50.000,00 (fluxo A2)
  é valor final ou ainda sujeito a revisão pela diretoria financeira.
