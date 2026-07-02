*&---------------------------------------------------------------------*
*& Programa    : ZMM_NOTIF_GR_FI
*& Descrição   : Notificação de Entrada de Mercadoria e Integração MM-FI
*& REQ Origem  : REQ-MM-001
*& FS Origem   : FS-MM-001 (design.md — seções 5, 7 e 8)
*& Autor       : Ayesa Brasil
*& Data        : [VERIFICAR COM CLIENTE]
*& Versão      : 0.1 — Rascunho (aguardando validação de transações SAP)
*&---------------------------------------------------------------------*
*& ATENÇÃO: Este esqueleto foi gerado a partir da FS-MM-001.
*& Não alterar sem atualizar o design.md primeiro.
*& Transações SAP pendentes de confirmação — ver seção 3 do design.md
*&---------------------------------------------------------------------*

REPORT zmm_notif_gr_fi.

*----------------------------------------------------------------------*
* TIPOS E ESTRUTURAS
*----------------------------------------------------------------------*
" [VERIFICAR COM CLIENTE] — estruturas de dados a definir após
" confirmação das transações SAP envolvidas (seção 3 da FS)

TYPES:
  BEGIN OF ty_nota_fiscal,
    nr_nf       TYPE [VERIFICAR],   " Número da nota fiscal
    dt_emissao  TYPE [VERIFICAR],   " Data de emissão
    vl_total    TYPE [VERIFICAR],   " Valor total da NF
    cd_material TYPE matnr,         " Código do material
    qt_entrada  TYPE menge_d,       " Quantidade recebida
    nr_pedido   TYPE ebeln,         " Pedido de compra vinculado
  END OF ty_nota_fiscal.

*----------------------------------------------------------------------*
* VARIÁVEIS GLOBAIS
*----------------------------------------------------------------------*
DATA:
  gs_nota_fiscal  TYPE ty_nota_fiscal,
  gv_doc_material TYPE mblnr,    " Documento de material gerado (MM)
  gv_doc_contabil TYPE belnr_d,  " Documento contábil gerado (FI)
  gv_erro         TYPE xfeld,    " Flag de erro
  gv_mensagem     TYPE string.   " Mensagem de retorno ao usuário

*----------------------------------------------------------------------*
* INÍCIO DO PROGRAMA
*----------------------------------------------------------------------*
START-OF-SELECTION.

  " Passo 1 — FS seção 5.1: Almoxarife acessa transação de entrada
  " [VERIFICAR COM CLIENTE] — transação a confirmar (MIGO ou custom)
  PERFORM f_receber_dados_entrada
    CHANGING gs_nota_fiscal.

  " Passo 2 — FS seção 5.3: Validar contra pedido de compra
  PERFORM f_validar_pedido_compra
    USING    gs_nota_fiscal
    CHANGING gv_erro
             gv_mensagem.

  IF gv_erro IS NOT INITIAL.
    " Fluxo alternativo — FS seção 6: divergência de quantidade/valor
    PERFORM f_tratar_divergencia
      USING gv_mensagem.
    RETURN.
  ENDIF.

  " Passo 3 — FS seção 5.5: Atualizar estoque no módulo MM
  PERFORM f_atualizar_estoque_mm
    USING    gs_nota_fiscal
    CHANGING gv_doc_material
             gv_erro.

  IF gv_erro IS NOT INITIAL.
    " Fluxo alternativo — FS seção 6: falha na atualização de estoque
    PERFORM f_tratar_erro_mm
      USING gv_mensagem.
    RETURN.
  ENDIF.

  " Passo 4 — FS seção 5.6 + Regra RN01: Gerar documento contábil FI
  " RN01: documento FI obrigatório na mesma transação — nunca separado
  PERFORM f_gerar_documento_fi
    USING    gv_doc_material
             gs_nota_fiscal
    CHANGING gv_doc_contabil
             gv_erro.

  IF gv_erro IS NOT INITIAL.
    " Fluxo alternativo — FS seção 6: falha na integração MM-FI
    " ATENÇÃO: estoque já foi atualizado — rollback necessário
    " [VERIFICAR COM CLIENTE] — mecanismo de rollback a definir
    PERFORM f_tratar_erro_integracao_fi
      USING    gv_doc_material
      CHANGING gv_erro.
    RETURN.
  ENDIF.

  " Passo 5 — FS seção 5.7: Confirmar ao usuário
  PERFORM f_confirmar_usuario
    USING gv_doc_material
          gv_doc_contabil.

  " RN02 — Garantir zero lançamentos no Sismat após go-live
  " [VERIFICAR COM CLIENTE] — mecanismo de bloqueio do Sismat a definir
  PERFORM f_verificar_sismat_inativo.

*----------------------------------------------------------------------*
* FORMS (esqueletos — implementação após validação da FS)
*----------------------------------------------------------------------*
FORM f_receber_dados_entrada
  CHANGING cs_nota_fiscal TYPE ty_nota_fiscal.
  " [IMPLEMENTAR] — seção 5.1 e 5.2 da FS
ENDFORM.

FORM f_validar_pedido_compra
  USING    us_nota_fiscal TYPE ty_nota_fiscal
  CHANGING cv_erro        TYPE xfeld
           cv_mensagem    TYPE string.
  " [IMPLEMENTAR] — seção 5.3 e RN03 da FS
  " Tolerância de divergência PO x NF: [VERIFICAR COM CLIENTE]
ENDFORM.

FORM f_atualizar_estoque_mm
  USING    us_nota_fiscal  TYPE ty_nota_fiscal
  CHANGING cv_doc_material TYPE mblnr
           cv_erro         TYPE xfeld.
  " [IMPLEMENTAR] — seção 5.5 da FS
ENDFORM.

FORM f_gerar_documento_fi
  USING    uv_doc_material TYPE mblnr
           us_nota_fiscal  TYPE ty_nota_fiscal
  CHANGING cv_doc_contabil TYPE belnr_d
           cv_erro         TYPE xfeld.
  " [IMPLEMENTAR] — seção 5.6 + RN01 da FS
  " SLA: documento FI em até 30s — CA03 da FS (atualizado em 02/07/2026, conforme requirements.md)
ENDFORM.

FORM f_tratar_divergencia
  USING uv_mensagem TYPE string.
  " [IMPLEMENTAR] — seção 6 da FS: divergência quantidade/valor
ENDFORM.

FORM f_tratar_erro_mm
  USING uv_mensagem TYPE string.
  " [IMPLEMENTAR] — seção 6 da FS: falha na atualização de estoque
ENDFORM.

FORM f_tratar_erro_integracao_fi
  USING    uv_doc_material TYPE mblnr
  CHANGING cv_erro         TYPE xfeld.
  " [IMPLEMENTAR] — seção 6 da FS: falha MM-FI + rollback
  " [VERIFICAR COM CLIENTE] — mecanismo de rollback e reprocessamento
ENDFORM.

FORM f_confirmar_usuario
  USING uv_doc_material TYPE mblnr
        uv_doc_contabil TYPE belnr_d.
  " [IMPLEMENTAR] — seção 5.7 da FS
ENDFORM.

FORM f_verificar_sismat_inativo.
  " [IMPLEMENTAR] — RN02 da FS
  " [VERIFICAR COM CLIENTE] — mecanismo de bloqueio do Sismat
ENDFORM.
