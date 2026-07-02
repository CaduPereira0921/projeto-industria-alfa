# REQ-MM-001 — Entrada única de NF no SAP com eliminação do sistema legado Sismat

## Identificação

| Campo | Valor |
|---|---|
| **REQ-ID** | REQ-MM-001 |
| **Tipo** | Funcional |
| **Status** | Em análise |
| **Módulo SAP** | MM / FI |
| **Nível de Risco** | 🔴 Alto |
| **Origem** | ata_blueprint_08-06.txt \| email_carlos_09-06.txt |

---

## Ator

Almoxarife

---

## Gatilho

Chegada de nota fiscal no depósito.

---

## Descrição Funcional

Ao registrar a entrada de mercadoria no SAP, o sistema deve atualizar o estoque automaticamente e gerar o documento contábil correspondente em uma única operação, sem necessidade de lançamento paralelo no sistema Sismat.

---

## Resultado Esperado

Estoque atualizado + documento contábil gerado em uma única operação no SAP, sem lançamento no Sismat.

---

## Critério de Aceite Mensurável

- 100% das entradas de NF registradas exclusivamente no SAP
- Zero registros duplicados no Sismat após go-live
- Documento contábil gerado em até 30 segundos após lançamento de entrada

---

## Transações SAP Prováveis

[VERIFICAR]

---

## Tipo de Solução

Configuração / A verificar

---

## Justificativa do Risco

🔴 Alto — envolve desativação de sistema legado em uso ativo e integração MM-FI crítica para fechamento.

---

## Perguntas em Aberto

1. Qual é o prazo planejado para desativação definitiva do Sismat? Existe dependência de outros módulos ou áreas?
2. Há dados históricos no Sismat que precisam ser migrados para o SAP antes do go-live?
3. A versão SAP implantada é ECC ou S/4HANA?
4. Existe algum processo que ainda exige o Sismat que não foi mapeado nesta reunião?
5. Quais perfis de usuário terão acesso à transação de entrada de mercadoria?

---

## Histórico de Alterações

| Data | Alteração | Origem |
|---|---|---|
| 02/07/2026 | SLA de geração do documento contábil alterado de 60s para 30s | Solicitação do cliente |
