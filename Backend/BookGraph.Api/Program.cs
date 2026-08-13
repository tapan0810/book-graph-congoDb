using Microsoft.OpenApi.Models;
using BookGraph.Api.Data;
using BookGraph.Api.Services;

var builder = WebApplication.CreateBuilder(args);

// Add Controllers
builder.Services.AddControllers();

// API Explorer
builder.Services.AddEndpointsApiExplorer();

// Swagger
builder.Services.AddSwaggerGen(options =>
{
    options.SwaggerDoc("v1", new OpenApiInfo
    {
        Title = "BookGraph API",
        Version = "v1",
        Description = "Graph Database API using CognoDB"
    });
});

// Graph Database service

builder.Services.AddSingleton<GraphDatabase>();
builder.Services.AddScoped<BookService>();

var app = builder.Build();

// Swagger
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();

app.UseAuthorization();

app.MapControllers();

app.Run();