namespace BookGraph.Api.Models;

public class Book
{
    public string Id { get; set; } = string.Empty;

    public string Title { get; set; } = string.Empty;

    public string Description { get; set; } = string.Empty;

    public int PublishedYear { get; set; }

    public double Rating { get; set; }
}