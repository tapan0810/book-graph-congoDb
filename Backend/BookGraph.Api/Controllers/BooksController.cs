using BookGraph.Api.Services;
using Microsoft.AspNetCore.Mvc;

namespace BookGraph.Api.Controllers;

[ApiController]
[Route("api/books")]
public class BooksController : ControllerBase
{
    private readonly BookService _bookService;

    public BooksController(BookService bookService)
    {
        _bookService = bookService;
    }

    [HttpGet]
    public async Task<IActionResult> GetAllBooks()
    {
        var books = await _bookService.GetAllBooksAsync();

        return Ok(books);
    }

    [HttpGet("search")]
    public async Task<IActionResult> SearchBooks([FromQuery] string search)
    {
        if (string.IsNullOrWhiteSpace(search))
        {
            return BadRequest("Search term is required.");
        }

        var books = await _bookService.SearchBooksAsync(search);

        return Ok(books);
    }

    [HttpGet("{id}")]
    public async Task<IActionResult> GetBookDetails(string id)
    {
        var book = await _bookService.GetBookDetailsAsync(id);

        if (book == null)
        {
            return NotFound();
        }

        return Ok(book);
    }

    [HttpGet("{id}/related")]
    public async Task<IActionResult> GetRelatedBooks(string id)
    {
        var books = await _bookService.GetRelatedBooksAsync(id);

        return Ok(books);
    }

    [HttpGet("{id}/graph")]
public async Task<IActionResult> GetGraph(string id)
{
    var graph = await _bookService.GetGraphAsync(id);

    if (graph.Nodes.Count == 0)
    {
        return NotFound();
    }

    return Ok(graph);
}
}