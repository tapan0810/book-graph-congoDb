namespace BookGraph.Api.Models;

public class BookDetails
{
    public Book Book { get; set; } = new();

    public Author? Author { get; set; }

    public Genre? Genre { get; set; }

    public List<Tag> Tags { get; set; } = [];
}