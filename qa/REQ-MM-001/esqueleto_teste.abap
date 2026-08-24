*&---------------------------------------------------------------------*
*& Esqueleto ABAP Unit gerado por pipeline-qualidade-ayesa
*& Requisito: REQ-MM-001 -- Integracao automatica SAP <-> Sismat para eliminar dupla digitacao de Nota Fiscal: geracao automatica do documento contabil (FI) no SAP a partir da confirmacao da NF no Sismat, para fornecedores nacionais homologados.
*& Todos os metodos ficam com o marcador de pendencia -- logica de assert
*& e trabalho do desenvolvedor humano; o script apenas organiza o esqueleto.
*&---------------------------------------------------------------------*

CLASS ltc_req_mm_001 DEFINITION FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    METHODS:
      test_ok_geracao_automatica_do_doc FOR TESTING,
      test_erro_rejeicao_de_nf_de_fornece FOR TESTING,
      test_limite_processamento_automatico FOR TESTING,
      test_erro_reprocessamento_de_evento FOR TESTING,
      test_sla_sla_de_30_segundos_para_c FOR TESTING.
ENDCLASS.

CLASS ltc_req_mm_001 IMPLEMENTATION.

  METHOD test_ok_geracao_automatica_do_doc.
    " [IMPLEMENTAR] Geracao automatica do documento FI para fornecedor homologado
    " Tipo: positivo | Pre-condicao: NF confirmada no Sismat para fornecedor com status 'Ativo' no cadastro SAP (LFA1); valor da NF abaixo do limite de aprovacao manual (R$ 50.000,00).
  ENDMETHOD.

  METHOD test_erro_rejeicao_de_nf_de_fornece.
    " [IMPLEMENTAR] Rejeicao de NF de fornecedor nao cadastrado no SAP
    " Tipo: negativo | Pre-condicao: NF confirmada no Sismat para fornecedor sem status 'Ativo' na LFA1 (nao homologado ou inexistente no cadastro SAP).
  ENDMETHOD.

  METHOD test_limite_processamento_automatico.
    " [IMPLEMENTAR] Processamento automatico de NF no valor limite de R$ 50.000,00
    " Tipo: limite | Pre-condicao: Fornecedor homologado (status 'Ativo' na LFA1); NF com valor exatamente igual ao limite configurado no middleware (R$ 50.000,00 [VERIFICAR] valor sujeito a confirmacao final da Controladoria).
  ENDMETHOD.

  METHOD test_erro_reprocessamento_de_evento.
    " [IMPLEMENTAR] Reprocessamento de evento apos indisponibilidade do Sismat
    " Tipo: negativo | Pre-condicao: Sismat indisponivel no momento em que o evento de confirmacao de NF deveria ser publicado/consumido; fornecedor homologado.
  ENDMETHOD.

  METHOD test_sla_sla_de_30_segundos_para_c.
    " [IMPLEMENTAR] SLA de 30 segundos para criacao do documento FI
    " Tipo: nao_funcional | Pre-condicao: Fornecedor homologado; ambiente de teste com fila de eventos e ZTB_LOG_INTEGRACAO_MM001 disponiveis para registro de timestamp.
    " Lembrete: meça o tempo de execução com GET RUN TIME FIELD antes/depois
    " da chamada -- validar apenas o resultado funcional NAO cobre este requisito.
  ENDMETHOD.

ENDCLASS.
