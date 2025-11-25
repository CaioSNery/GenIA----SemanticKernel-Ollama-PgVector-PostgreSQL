using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Demo7.Models
{
    public class Product
    {
    public int Id { get; set; }
    public string Title { get; set; } = string.Empty;
    public string Category { get; set; } = string.Empty;
    public string Summary { get; set; } = string.Empty;
    public string Description { get; set; } = string.Empty;
    }
}