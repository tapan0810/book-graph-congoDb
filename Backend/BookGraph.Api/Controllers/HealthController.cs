using BookGraph.Api.Data;
using Microsoft.AspNetCore.Mvc;

namespace BookGraph.Api.Controllers;

[ApiController]
[Route("api/health")]
public class HealthController : ControllerBase
{
    private readonly GraphDatabase _database;

    public HealthController(GraphDatabase database)
    {
        _database = database;
    }

    [HttpGet]
    public async Task<IActionResult> Get()
    {
        try
        {
            await _database.VerifyConnectionAsync();

            return Ok(new
            {
                status = "Connected",
                database = "CognoDB"
            });
        }
        catch (Exception ex)
        {
            return StatusCode(500, new
            {
                status = "Connection failed",
                error = ex.Message
            });
        }
    }
}