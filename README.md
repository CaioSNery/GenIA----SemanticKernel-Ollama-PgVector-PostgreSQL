# 🧠 Sistema de Recomendação de Produtos com IA

*Recomendações inteligentes usando .NET, LLMs, Embeddings e Banco
Vetorial*

Este projeto demonstra como aplicar **Inteligência Artificial** em um
sistema de recomendação moderno utilizando **embeddings**, **busca
vetorial**, **LLMs** e **prompt engineering anti-alucinação**.\
O foco é criar uma base inteligente capaz de entender **significado**,
não apenas texto literal.

------------------------------------------------------------------------

## 🎯 Objetivo

Construir um sistema de recomendação que:

-   Representa produtos como **vetores (embeddings)**\
-   Encontra similaridades usando **pgvector + HNSW**\
-   Usa **Llama 3.1** para explicar recomendações e gerar textos\
-   Aplica **Prompt Engineering anti-alucinação**\
-   Exõe tudo via **Minimal API em .NET 8**

------------------------------------------------------------------------

## 🧰 Tecnologias Utilizadas

  Tecnologia                        Descrição
  --------------------------------- -----------------------------------------
  **.NET 8 / C#**                   Backend com Minimal API
  **Semantic Kernel**               Integração com IA, orquestração e fluxo
  **Ollama**                        Execução local da IA
  **Llama 3.1**                     LLM usado para explicações
  **mxbai-embed-large**             Modelo de embeddings
  **PostgreSQL + pgvector**         Armazenamento vetorial
  **HNSW Index**                    Busca vetorial rápida e eficiente
  **Docker (pgvector + pgAdmin)**   Ambiente isolado para testes

------------------------------------------------------------------------

## 🔍 Arquitetura da Solução

1️⃣ **Embeddings** --- Cada produto é transformado em vetor:

``` csharp
var service = ollamaClient.AsTextEmbeddingGenerationService();
var embedding = await service.GenerateEmbeddingAsync(product.Description);
```

2️⃣ **Banco Vetorial (pgvector)** --- Os vetores são salvos em uma coluna
`vector(1024)`.

3️⃣ **Índice HNSW** --- Cria busca vetorial de alta performance:

``` sql
CREATE INDEX idx_products_embedding_hnsw
ON products
USING hnsw (embedding vector_cosine_ops)
WITH (m = 16, ef_construction = 64);
```

4️⃣ **Busca Semântica** --- Retorna produtos mais parecidos:

``` csharp
.OrderBy(p => p.Embedding.CosineDistance(queryEmbedding))
```

5️⃣ **LLM (Llama 3.1)** complementa com explicações inteligentes.

6️⃣ **Prompt seguro** evita alucinação do modelo.

------------------------------------------------------------------------

## 🛡️ Prompt Engineering Anti-Alucinação

O sistema utiliza prompts reforçados para garantir que o modelo **não
invente informações**.

``` csharp
var prompt = $@"
Você é um assistente especializado em recomendação.
Responda SOMENTE com base nos produtos fornecidos.
Se não houver dados suficientes, diga: 'Não há informações disponíveis.'

Produtos: {JsonSerializer.Serialize(recomendations)}
";
```

------------------------------------------------------------------------

## 🌐 Endpoint Principal --- `/v1/prompt`

``` csharp
app.MapPost("/v1/prompt", async (
    QuestionRequest model,
    AppDbContext db,
    OllamaApiClient ollamaClient) =>
{
    // 1. Gerar embedding da pergunta
    var embedService = ollamaClient.AsTextEmbeddingGenerationService();
    var queryEmbedding = await embedService.GenerateEmbeddingAsync(model.Prompt);

    // 2. Buscar similaridade no banco vetorial
    var recomendations = await db.Products
        .OrderBy(p => p.Embedding.CosineDistance(queryEmbedding.ToArray()))
        .Take(3)
        .Select(x => new { x.Title, x.Category })
        .ToListAsync();

    // 3. Criar prompt anti-alucinação
    var prompt = $@"
Baseado somente nos produtos abaixo, gere insights curtos e objetivos.
Se não houver dados, diga que não há informações.

Produtos: {JsonSerializer.Serialize(recomendations)}
";

    // 4. Chamada para o LLM (Llama 3.1)
    var response = await ollamaClient.GenerateAsync("llama3.1", prompt);

    return Results.Ok(new {
        recomendations,
        llmMessage = response.Response
    });
});
```

------------------------------------------------------------------------

## 📦 Subindo Banco Vetorial com Docker

``` bash
docker compose up -d
```

------------------------------------------------------------------------

## 🚀 Destaques Técnicos

✔️ IA aplicada ao backend .NET\
✔️ Busca vetorial com pgvector\
✔️ Índice HNSW para performance extrema\
✔️ Prompt anti-alucinação\
✔️ Llama 3.1 totalmente local via Ollama\
✔️ Minimal API simples e didática
