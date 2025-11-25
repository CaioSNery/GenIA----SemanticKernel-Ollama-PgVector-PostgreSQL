
using Pgvector;

namespace Demo7.Models
{
    public class Recomendation
    {
     public int Id { get; set; }
    public string Title { get; set; } = string.Empty;
    public string Category { get; set; } = string.Empty;
    public Vector Embedding { get; set; } = null!;
    }
}