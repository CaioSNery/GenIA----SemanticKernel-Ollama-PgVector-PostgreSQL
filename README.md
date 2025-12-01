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
-   Exõe tudo via **Minimal API em .NET 9**

------------------------------------------------------------------------

## 🧰 Tecnologias Utilizadas

  Tecnologia                        Descrição
  --------------------------------- -----------------------------------------
  **.NET 9 / C#**                   Backend com Minimal API
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
var textEmbeddingGenerationService = ollamaClient.AsTextEmbeddingGenerationService();
var embeddings = await textEmbeddingGenerationService.GenerateEmbeddingAsync(product.Category);
```

2️⃣ **Banco Vetorial (pgvector)** --- Os vetores são salvos em uma coluna
`vector(1024)`.

3️⃣ **Índice HNSW** --- Cria busca vetorial de alta performance:

``` sql
CREATE INDEX idx_recomendations ON recomendations USING HNSW (embedding vector_l2_ops);

```

4️⃣ **Busca Semântica** --- Retorna produtos mais parecidos:

``` csharp
.OrderBy(d => d.Embedding.CosineDistance(new Vector(embeddings.ToArray())))
```

5️⃣ **LLM (Llama 3.1)** complementa com explicações inteligentes.

6️⃣ **Prompt seguro** evita alucinação do modelo.

------------------------------------------------------------------------

## 🛡️ Prompt Engineering Anti-Alucinação

O sistema utiliza prompts reforçados para garantir que o modelo **não
invente informações**.

``` csharp
var prompt = $@"Você deve responder APENAS com base no CONTEXTO abaixo.
         Se a resposta não estiver presente no contexto, diga:
         Não encontrei informações suficientes no contexto.'

         NÃO invente informações.
         NÃO complete lacunas.
         NÃO faça suposições.

         CONTEXT:
        {context}

        QUESTION:
        {model.Prompt}

 Responda de forma objetiva e fiel ao contexto acima.";
```

------------------------------------------------------------------------

## 🌐 Endpoint Principal --- `/v1/prompt`

``` csharp
app.MapPost("/v1/prompt", async (
    QuestionRequest model,
    AppDbContext db,
    OllamaApiClient ollamaClient) =>
{
    var service = ollamaClient.AsTextEmbeddingGenerationService();
    var embeddings = await service.GenerateEmbeddingAsync(model.Prompt);

    var recomendations = await db.Recomendations
        .AsNoTracking()
        .OrderBy(d => d.Embedding.CosineDistance(new Vector(embeddings.ToArray())))
        .Take(3)
        .Select(x => new
        {
            x.Title,
            x.Category
        })
        .ToListAsync();

    var context = string.Join("\n", recomendations.Select(r => $"- {r.Title} ({r.Category})"));

    var prompt = $@"Você deve responder APENAS com base no CONTEXTO abaixo.
         Se a resposta não estiver presente no contexto, diga:
         Não encontrei informações suficientes no contexto.'

         NÃO invente informações.
         NÃO complete lacunas.
         NÃO faça suposições.

         CONTEXT:
        {context}

        QUESTION:
        {model.Prompt}

         Responda de forma objetiva e fiel ao contexto acima.";

    var request = new GenerateRequest
    {
        Model = "llama3.1:latest",
        Prompt = prompt
    };

    string answer = "";

    await foreach (var msg in ollamaClient.GenerateAsync(request))
    {
        if (msg != null && msg.Response != null)
            answer += msg.Response;
    }

    return Results.Ok(new
    {
        recomendations,
        answer
    });

});
```

------------------------------------------------------------------------

## 📦 Subindo Banco Vetorial com Docker PostgreSQL com PgVector

``` bash
docker run -d \
  --name pgvector-db \
  -e POSTGRES_DB=productsdb \
  -e POSTGRES_USER=postgres \
  -e POSTGRES_PASSWORD=123456 \
  -p 5432:5432 \
  -v pgdata:/var/lib/postgresql/data \
  ankane/pgvector
```

------------------------------------------------------------------------

## 🚀 Destaques Técnicos

✔️ IA aplicada ao backend .NET\
✔️ Busca vetorial com pgvector\
✔️ Índice HNSW para performance extrema\
✔️ Prompt anti-alucinação\
✔️ Llama 3.1 totalmente local via Ollama\
✔️ Minimal API simples e didática
