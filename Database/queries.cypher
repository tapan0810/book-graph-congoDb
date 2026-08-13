// ==========================================
// QUERY 1 - GET ALL BOOKS
// ==========================================

MATCH (b:Book)
RETURN b
ORDER BY b.title;


// ==========================================
// QUERY 2 - SEARCH BOOKS
// ==========================================

MATCH (b:Book)
WHERE toLower(b.title) CONTAINS toLower($search)
RETURN b
ORDER BY b.title;


// ==========================================
// QUERY 3 - BOOK DETAILS
// ==========================================

MATCH (b:Book {id: $bookId})
OPTIONAL MATCH (a:Author)-[:WROTE]->(b)
OPTIONAL MATCH (b)-[:BELONGS_TO]->(g:Genre)
OPTIONAL MATCH (b)-[:HAS_TAG]->(t:Tag)
RETURN b, a, g, collect(t) AS tags;


// ==========================================
// QUERY 4 - 2 HOP RELATED BOOKS
// ==========================================

MATCH (b:Book {id: $bookId})
      -[:BELONGS_TO]->(g:Genre)
      <-[:BELONGS_TO]-(related:Book)
WHERE related.id <> $bookId
RETURN related
ORDER BY related.rating DESC;


// ==========================================
// QUERY 5 - MULTI-HOP GRAPH EXPLORATION
// ==========================================

MATCH path =
    (b:Book {id: $bookId})
    -[:BELONGS_TO]->(g:Genre)
    <-[:BELONGS_TO]-(related:Book)
    <-[:WROTE]-(author:Author)
RETURN path;