using Neo4j.Driver;

namespace BookGraph.Api.Data;

public class GraphDatabase : IAsyncDisposable
{
    private readonly IDriver _driver;

    public GraphDatabase(IConfiguration configuration)
    {
        var uri = configuration["CognoDB:Uri"]
                  ?? throw new InvalidOperationException("CognoDB URI is not configured.");

        var username = configuration["CognoDB:Username"]
                       ?? throw new InvalidOperationException("CognoDB username is not configured.");

        var password = configuration["CognoDB:Password"]
                       ?? throw new InvalidOperationException("CognoDB password is not configured.");

        _driver =  Neo4j.Driver.GraphDatabase.Driver(
            uri,
            AuthTokens.Basic(username, password));
    }

    public IDriver Driver => _driver;

    public async Task VerifyConnectionAsync()
    {
        await _driver.VerifyConnectivityAsync();
    }

    public async ValueTask DisposeAsync()
    {
        await _driver.DisposeAsync();
    }
}