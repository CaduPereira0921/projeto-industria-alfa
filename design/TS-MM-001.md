# Especificação Técnica — TS-MM-001

## 1. Identificação
| Campo | Valor |
|---|---|
| Documento | TS-MM-001 |
| Cliente | [cliente] |
| Módulo | MM / FI (integração) |
| FS de origem | FS-MM-001 (v1.2, aprovada) |
| Autor | Juliana Ramos (Consultora Ayesa) |
| Versão | 1.0 |
| Status | Em revisão técnica |

## 2. Visão Geral da Solução
A integração usa um middleware externo que consome o evento de
confirmação de NF publicado pelo Sismat via fila assíncrona (padrão
pub/sub). O middleware valida o fornecedor contra o cadastro SAP (tabela
LFA1) e aciona a criação do documento FI. Acima do limite de valor
configurado, a NF é desviada para fila de aprovação manual, fora do
escopo técnico desta integração automática.

## 3. Objetos Técnicos SAP

| Objeto | Tipo | Descrição | Complexidade | Estimativa (dev + teste unit.) |
|---|---|---|---|---|
| [VERIFICAR] — BAPI ou transação de lançamento FI | Standard ou Custom (a definir) | Mecanismo de criação do documento contábil a partir do evento de NF confirmada. Prioridade: usar BAPI standard antes de propor desenvolvimento Z. | M | 24h (sujeito a confirmação do mecanismo) |
| ZFM_VALIDA_FORNECEDOR_MM001 | Custom (Function Module) | Valida se o fornecedor da NF está com status "Ativo" na LFA1 antes de liberar o processamento automático. | P | 8h |
| Fila de eventos (middleware, fora do SAP) | Configuração externa | Não é objeto ABAP — configuração no middleware para consumo do evento Sismat. Fora do escopo de desenvolvimento ABAP, mas impacta o design do FM de validação. | — | — |
| ZTB_LOG_INTEGRACAO_MM001 | Custom (Tabela Z) | Tabela de log de toda transação de integração, para fins de auditoria e troubleshooting de SLA. | P | 6h |
| ZFM_GERA_DOC_FI_MM001 | Custom (Function Module) | Orquestra a chamada ao mecanismo de lançamento FI (linha 1 desta tabela) e grava o log de tempo de execução na ZTB_LOG_INTEGRACAO_MM001. | M | 20h |

**Total estimado (antes de buffer):** 58h
**Buffer de 20% (padrão Ayesa):** 11,6h
**Total com buffer:** ~70h

## 4. Regras Técnicas de Implementação
- RT-01: o `ZFM_GERA_DOC_FI_MM001` deve registrar o timestamp de início
  (recebimento do evento) e de fim (confirmação da criação do documento
  FI) na `ZTB_LOG_INTEGRACAO_MM001`, para permitir auditoria posterior do
  SLA de 30 segundos definido na FS-MM-001 (CA-01).
- RT-02: a validação de fornecedor (`ZFM_VALIDA_FORNECEDOR_MM001`) deve
  rodar antes de qualquer tentativa de criação do documento FI — nunca
  criar documento parcial e reverter depois (custo de rollback é maior
  que o de validar antes).
- RT-03: o limite de valor de R$ 50.000,00 (fluxo A2 da FS) fica
  parametrizado em tabela de configuração, nunca hardcoded no código —
  permite ajuste futuro sem nova transporte de código.

## 5. Riscos Técnicos
- Risco de performance: se o volume de NFs simultâneas no horário de
  pico exceder a capacidade do middleware, o SLA de 30s pode não ser
  atingido — recomenda-se teste de carga antes de ir para produção
  (relacionado ao requisito não-funcional de volumetria, REQ-MM-005).
- Risco de autorização: o usuário técnico usado pelo middleware para
  chamar o mecanismo de lançamento FI precisa ter perfil de autorização
  compatível — [VERIFICAR] se o perfil já existe ou precisa ser criado.
- Dependência de upgrade: se o mecanismo de lançamento FI escolhido for
  standard, confirmar compatibilidade com a versão atual do SAP ECC 6.0
  antes de assumir que está disponível.

## 6. Pontos Abertos
- [VERIFICAR] Confirmar com Basis/ABAP o mecanismo exato de criação do
  documento FI (linha 1 da tabela de objetos) antes de iniciar o
  desenvolvimento — impacta diretamente a estimativa de 24h.
- [VERIFICAR] Perfil de autorização do usuário técnico do middleware.
- Validar limite de R$ 50.000,00 junto à Controladoria antes de
  parametrizar (ver RT-03).
