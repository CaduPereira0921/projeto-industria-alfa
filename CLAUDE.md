# CLAUDE.md — Projeto Indústria Alfa S.A.
## Instruções para o Claude Code

---

## CONTEXTO DO PROJETO

**Cliente:** Indústria Alfa S.A.
**Consultoria:** Ayesa Brasil
**Escopo:** Implementação SAP ECC 6.0 — Módulos MM + FI
**Fase atual:** Especificação Funcional → Especificação Técnica

---

## REGRA OBRIGATÓRIA — LEITURA ANTES DE AGIR

Antes de qualquer ação neste repositório, leia sempre:
1. Todos os arquivos em `/requirements/` — requisitos de origem (URS aprovado)
2. Todos os arquivos em `/design/` — Especificações Funcionais atuais

Nunca gere código, proponha mudanças ou responda perguntas
sem ter lido esses arquivos primeiro.

---

## ESTRUTURA DO REPOSITÓRIO

```
projeto-industria-alfa/
├── CLAUDE.md                    ← este arquivo (leia primeiro)
├── requirements/                ← todos os REQs do projeto
│   ├── REQ-MM-001.md
│   ├── REQ-MM-002.md
│   ├── REQ-MM-003.md
│   ├── REQ-MM-004.md
│   └── REQ-MM-005.md
├── design/                      ← todas as FSs do projeto
│   ├── FS-MM-001.md
│   ├── FS-MM-002.md
│   ├── FS-MM-003.md
│   ├── FS-MM-004.md
│   └── FS-MM-005.md
└── src/                         ← código ABAP
    └── ZMM_NOTIF_GR_FI.abap
```

---

## PADRÕES OBRIGATÓRIOS

### Rastreabilidade
- Toda mudança em `/design/` deve referenciar o REQ de origem em `/requirements/`
- Todo objeto ABAP em `/src/` deve referenciar a seção da FS que o originou
- Nunca implemente algo que não esteja em `/design/`

### Quando um requisito mudar
1. Atualizar o arquivo correspondente em `/requirements/` com a mudança e a data
2. Identificar impacto nos arquivos de `/design/`
3. Propor diff nos arquivos de `/design/` antes de tocar em `/src/`
4. Só alterar `/src/` após diff de `/design/` aprovado

### Transações SAP
- Nunca invente transações SAP — marque [VERIFICAR COM CLIENTE]
- Versão SAP: ECC 6.0 (confirmar se migração S/4HANA está no escopo)

### Campos [VERIFICAR COM CLIENTE]
- Não assuma valores para campos marcados como [VERIFICAR COM CLIENTE]
- Liste-os explicitamente antes de qualquer geração de código

---

## STAKEHOLDERS DO PROJETO

| Nome | Cargo | Módulo |
|---|---|---|
| Carlos Mendes | Gerente de Logística | MM |
| Patricia Souza | Controller Financeiro | FI |
| Roberto Lima | Diretor de Compras | MM / Compras |

---

## CONFLITO EM ABERTO — ATENÇÃO

**REQ-MM-003:** destinatário do alerta de estoque mínimo não definido.
- Carlos (09/06): "comprador responsável"
- Roberto (11/06): "analista de compras"
- Status: aguardando workshop de alinhamento entre Logística e Compras
- **Não implemente esse requisito até o conflito ser resolvido**
