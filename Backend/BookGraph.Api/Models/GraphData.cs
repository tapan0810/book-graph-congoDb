namespace BookGraph.Api.Models;

public class GraphData
{
    public List<GraphNode> Nodes { get; set; } = [];

    public List<GraphRelationship> Relationships { get; set; } = [];
}

public class GraphNode
{
    public long Id { get; set; }

    public List<string> Labels { get; set; } = [];

    public Dictionary<string, object> Properties { get; set; } = [];
}

public class GraphRelationship
{
    public long Id { get; set; }

    public long StartNodeId { get; set; }

    public long EndNodeId { get; set; }

    public string Type { get; set; } = string.Empty;
}