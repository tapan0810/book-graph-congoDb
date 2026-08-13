using BookGraph.Api.Data;
using BookGraph.Api.Models;
using Neo4j.Driver;
using GraphDatabase = BookGraph.Api.Data.GraphDatabase;

namespace BookGraph.Api.Services;

public class BookService
{
    private readonly GraphDatabase _database;

    public BookService(GraphDatabase database)
    {
        _database = database;
    }

    // ============================================================
    // GET ALL BOOKS
    // ============================================================

    public async Task<List<Book>> GetAllBooksAsync()
    {
        const string query = """
            MATCH (b:Book)
            RETURN b
            ORDER BY b.title
            """;

        await using var session = _database.Driver.AsyncSession();

        var result = await session.RunAsync(query);

        var records = await result.ToListAsync();

        return records
            .Select(record => MapBook(record["b"].As<INode>()))
            .ToList();
    }


    // ============================================================
    // SEARCH BOOKS
    // ============================================================

    public async Task<List<Book>> SearchBooksAsync(string search)
    {
        const string query = """
            MATCH (b:Book)
            WHERE toLower(b.title) CONTAINS toLower($search)
            RETURN b
            ORDER BY b.title
            """;

        await using var session = _database.Driver.AsyncSession();

        var result = await session.RunAsync(
            query,
            new { search });

        var records = await result.ToListAsync();

        return records
            .Select(record => MapBook(record["b"].As<INode>()))
            .ToList();
    }


    // ============================================================
    // GET BOOK DETAILS
    // ============================================================

    public async Task<BookDetails?> GetBookDetailsAsync(string bookId)
    {
        const string query = """
            MATCH (b:Book {id: $bookId})

            OPTIONAL MATCH (a:Author)-[:WROTE]->(b)

            OPTIONAL MATCH (b)-[:BELONGS_TO]->(g:Genre)

            OPTIONAL MATCH (b)-[:HAS_TAG]->(t:Tag)

            RETURN
                b,
                head(collect(DISTINCT a)) AS author,
                head(collect(DISTINCT g)) AS genre,
                collect(DISTINCT t) AS tags
            """;

        await using var session = _database.Driver.AsyncSession();

        var result = await session.RunAsync(
            query,
            new { bookId });

        var records = await result.ToListAsync();

        if (records.Count == 0)
        {
            return null;
        }

        var record = records[0];


        // ========================================================
        // BOOK
        // ========================================================

        var bookNode = record["b"].As<INode>();

        var book = MapBook(bookNode);


        // ========================================================
        // AUTHOR
        // ========================================================

        Author? author = null;

        var authorValue = record["author"];

        if (authorValue is INode authorNode)
        {
            author = new Author
            {
                Id = authorNode.Properties["id"].As<string>(),
                Name = authorNode.Properties["name"].As<string>()
            };
        }


        // ========================================================
        // GENRE
        // ========================================================

        Genre? genre = null;

        var genreValue = record["genre"];

        if (genreValue is INode genreNode)
        {
            genre = new Genre
            {
                Id = genreNode.Properties["id"].As<string>(),
                Name = genreNode.Properties["name"].As<string>()
            };
        }


        // ========================================================
        // TAGS
        // ========================================================

        var tags = new List<Tag>();

        var tagValue = record["tags"];

        if (tagValue is IEnumerable<object> tagObjects)
        {
            foreach (var tagObject in tagObjects)
            {
                if (tagObject is not INode tagNode)
                {
                    continue;
                }

                tags.Add(new Tag
                {
                    Id = tagNode.Properties["id"].As<string>(),
                    Name = tagNode.Properties["name"].As<string>()
                });
            }
        }


        // ========================================================
        // RETURN RESULT
        // ========================================================

        return new BookDetails
        {
            Book = book,
            Author = author,
            Genre = genre,
            Tags = tags
        };
    }

    public async Task<List<Book>> GetRelatedBooksAsync(string bookId)
    {
        const string query = """
        MATCH (b:Book {id: $bookId})
              -[:BELONGS_TO]->(g:Genre)
              <-[:BELONGS_TO]-(related:Book)
        WHERE related.id <> $bookId
        RETURN related
        ORDER BY related.rating DESC
        """;

        await using var session = _database.Driver.AsyncSession();

        var result = await session.RunAsync(
            query,
            new { bookId });

        var records = await result.ToListAsync();

        return records
            .Select(record => MapBook(record["related"].As<INode>()))
            .ToList();
    }

    // ============================================================
    // MULTI-HOP GRAPH EXPLORATION
    // ============================================================

    public async Task<GraphData> GetGraphAsync(string bookId)
    {
        const string query = """
        MATCH path =
            (b:Book {id: $bookId})
            -[:BELONGS_TO]->(g:Genre)
            <-[:BELONGS_TO]-(related:Book)
            <-[:WROTE]-(author:Author)
        RETURN path
        """;

        await using var session = _database.Driver.AsyncSession();

        var result = await session.RunAsync(
            query,
            new { bookId });

        var records = await result.ToListAsync();

        var graph = new GraphData();

        foreach (var record in records)
        {
            var path = record["path"].As<IPath>();

            // Add nodes
            foreach (var node in path.Nodes)
            {
                if (graph.Nodes.Any(n => n.Id == node.Id))
                {
                    continue;
                }

                graph.Nodes.Add(new GraphNode
                {
                    Id = node.Id,
                    Labels = node.Labels.ToList(),
                    Properties = node.Properties.ToDictionary(
                        property => property.Key,
                        property => property.Value.As<object>())
                });
            }

            // Add relationships
            foreach (var relationship in path.Relationships)
            {
                if (graph.Relationships.Any(r => r.Id == relationship.Id))
                {
                    continue;
                }

                graph.Relationships.Add(new GraphRelationship
                {
                    Id = relationship.Id,
                    StartNodeId = relationship.StartNodeId,
                    EndNodeId = relationship.EndNodeId,
                    Type = relationship.Type
                });
            }
        }

        return graph;
    }


    // ============================================================
    // MAP BOOK NODE
    // ============================================================

    private static Book MapBook(INode node)
    {
        return new Book
        {
            Id = node.Properties["id"].As<string>(),
            Title = node.Properties["title"].As<string>(),
            Description = node.Properties["description"].As<string>(),
            PublishedYear = node.Properties["publishedYear"].As<int>(),
            Rating = node.Properties["rating"].As<double>()
        };
    }
}