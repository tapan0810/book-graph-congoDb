// ==========================================
// AUTHORS
// ==========================================

MERGE (a:Author {id: 'A001'})
SET a.name = 'J.R.R. Tolkien';

MERGE (a:Author {id: 'A002'})
SET a.name = 'J.K. Rowling';

MERGE (a:Author {id: 'A003'})
SET a.name = 'George Orwell';

MERGE (a:Author {id: 'A004'})
SET a.name = 'Frank Herbert';

MERGE (a:Author {id: 'A005'})
SET a.name = 'Andy Weir';

MERGE (a:Author {id: 'A006'})
SET a.name = 'Orson Scott Card';

// ==========================================
// GENRES
// ==========================================

MERGE (g:Genre {id: 'G001'})
SET g.name = 'Fantasy';

MERGE (g:Genre {id: 'G002'})
SET g.name = 'Science Fiction';

MERGE (g:Genre {id: 'G003'})
SET g.name = 'Dystopian';

MERGE (g:Genre {id: 'G004'})
SET g.name = 'Adventure';

MERGE (g:Genre {id: 'G005'})
SET g.name = 'Thriller';

// ==========================================
// BOOKS
// ==========================================

MERGE (b:Book {id: 'B001'})
SET b.title = 'The Hobbit',
    b.description = 'Bilbo Baggins goes on an unexpected adventure.',
    b.publishedYear = 1937,
    b.rating = 4.8;

MERGE (b:Book {id: 'B002'})
SET b.title = 'The Fellowship of the Ring',
    b.description = 'Frodo begins a dangerous journey with the One Ring.',
    b.publishedYear = 1954,
    b.rating = 4.9;

MERGE (b:Book {id: 'B003'})
SET b.title = 'The Two Towers',
    b.description = 'The fellowship faces new dangers across Middle-earth.',
    b.publishedYear = 1954,
    b.rating = 4.8;

MERGE (b:Book {id: 'B004'})
SET b.title = 'The Return of the King',
    b.description = 'The final battle for Middle-earth begins.',
    b.publishedYear = 1955,
    b.rating = 4.9;

MERGE (b:Book {id: 'B005'})
SET b.title = 'Harry Potter and the Philosophers Stone',
    b.description = 'A young wizard begins his journey at Hogwarts.',
    b.publishedYear = 1997,
    b.rating = 4.7;

MERGE (b:Book {id: 'B006'})
SET b.title = 'Harry Potter and the Chamber of Secrets',
    b.description = 'Harry returns to Hogwarts and discovers a hidden threat.',
    b.publishedYear = 1998,
    b.rating = 4.6;

MERGE (b:Book {id: 'B007'})
SET b.title = '1984',
    b.description = 'A man struggles against an oppressive surveillance state.',
    b.publishedYear = 1949,
    b.rating = 4.7;

MERGE (b:Book {id: 'B008'})
SET b.title = 'Animal Farm',
    b.description = 'Farm animals create a new society with unexpected consequences.',
    b.publishedYear = 1945,
    b.rating = 4.5;

MERGE (b:Book {id: 'B009'})
SET b.title = 'Dune',
    b.description = 'A young nobleman becomes involved in a struggle over a desert planet.',
    b.publishedYear = 1965,
    b.rating = 4.8;

MERGE (b:Book {id: 'B010'})
SET b.title = 'The Martian',
    b.description = 'An astronaut must survive alone on Mars.',
    b.publishedYear = 2011,
    b.rating = 4.7;

MERGE (b:Book {id: 'B011'})
SET b.title = 'Project Hail Mary',
    b.description = 'A scientist wakes alone in space with a critical mission.',
    b.publishedYear = 2021,
    b.rating = 4.8;

MERGE (b:Book {id: 'B012'})
SET b.title = 'Enders Game',
    b.description = 'A young strategist is trained for an interstellar conflict.',
    b.publishedYear = 1985,
    b.rating = 4.6;


    // ==========================================
// AUTHOR -> BOOK
// ==========================================

MATCH (a:Author {id: 'A001'}), (b:Book {id: 'B001'})
MERGE (a)-[:WROTE]->(b);

MATCH (a:Author {id: 'A001'}), (b:Book {id: 'B002'})
MERGE (a)-[:WROTE]->(b);

MATCH (a:Author {id: 'A001'}), (b:Book {id: 'B003'})
MERGE (a)-[:WROTE]->(b);

MATCH (a:Author {id: 'A001'}), (b:Book {id: 'B004'})
MERGE (a)-[:WROTE]->(b);

MATCH (a:Author {id: 'A002'}), (b:Book {id: 'B005'})
MERGE (a)-[:WROTE]->(b);

MATCH (a:Author {id: 'A002'}), (b:Book {id: 'B006'})
MERGE (a)-[:WROTE]->(b);

MATCH (a:Author {id: 'A003'}), (b:Book {id: 'B007'})
MERGE (a)-[:WROTE]->(b);

MATCH (a:Author {id: 'A003'}), (b:Book {id: 'B008'})
MERGE (a)-[:WROTE]->(b);

MATCH (a:Author {id: 'A004'}), (b:Book {id: 'B009'})
MERGE (a)-[:WROTE]->(b);

MATCH (a:Author {id: 'A005'}), (b:Book {id: 'B010'})
MERGE (a)-[:WROTE]->(b);

MATCH (a:Author {id: 'A005'}), (b:Book {id: 'B011'})
MERGE (a)-[:WROTE]->(b);

MATCH (a:Author {id: 'A006'}), (b:Book {id: 'B012'})
MERGE (a)-[:WROTE]->(b);

// ==========================================
// BOOK -> GENRE
// ==========================================

MATCH (b:Book {id: 'B001'}), (g:Genre {id: 'G001'})
MERGE (b)-[:BELONGS_TO]->(g);

MATCH (b:Book {id: 'B002'}), (g:Genre {id: 'G001'})
MERGE (b)-[:BELONGS_TO]->(g);

MATCH (b:Book {id: 'B003'}), (g:Genre {id: 'G001'})
MERGE (b)-[:BELONGS_TO]->(g);

MATCH (b:Book {id: 'B004'}), (g:Genre {id: 'G001'})
MERGE (b)-[:BELONGS_TO]->(g);

MATCH (b:Book {id: 'B005'}), (g:Genre {id: 'G001'})
MERGE (b)-[:BELONGS_TO]->(g);

MATCH (b:Book {id: 'B006'}), (g:Genre {id: 'G001'})
MERGE (b)-[:BELONGS_TO]->(g);

MATCH (b:Book {id: 'B007'}), (g:Genre {id: 'G003'})
MERGE (b)-[:BELONGS_TO]->(g);

MATCH (b:Book {id: 'B008'}), (g:Genre {id: 'G003'})
MERGE (b)-[:BELONGS_TO]->(g);

MATCH (b:Book {id: 'B009'}), (g:Genre {id: 'G002'})
MERGE (b)-[:BELONGS_TO]->(g);

MATCH (b:Book {id: 'B010'}), (g:Genre {id: 'G002'})
MERGE (b)-[:BELONGS_TO]->(g);

MATCH (b:Book {id: 'B011'}), (g:Genre {id: 'G002'})
MERGE (b)-[:BELONGS_TO]->(g);

MATCH (b:Book {id: 'B012'}), (g:Genre {id: 'G002'})
MERGE (b)-[:BELONGS_TO]->(g);

// ==========================================
// BOOK -> TAG
// ==========================================

MATCH (b:Book {id: 'B001'}), (t:Tag {id: 'T001'})
MERGE (b)-[:HAS_TAG]->(t);

MATCH (b:Book {id: 'B001'}), (t:Tag {id: 'T002'})
MERGE (b)-[:HAS_TAG]->(t);

MATCH (b:Book {id: 'B002'}), (t:Tag {id: 'T002'})
MERGE (b)-[:HAS_TAG]->(t);

MATCH (b:Book {id: 'B002'}), (t:Tag {id: 'T007'})
MERGE (b)-[:HAS_TAG]->(t);

MATCH (b:Book {id: 'B003'}), (t:Tag {id: 'T003'})
MERGE (b)-[:HAS_TAG]->(t);

MATCH (b:Book {id: 'B004'}), (t:Tag {id: 'T003'})
MERGE (b)-[:HAS_TAG]->(t);

MATCH (b:Book {id: 'B005'}), (t:Tag {id: 'T001'})
MERGE (b)-[:HAS_TAG]->(t);

MATCH (b:Book {id: 'B005'}), (t:Tag {id: 'T007'})
MERGE (b)-[:HAS_TAG]->(t);

MATCH (b:Book {id: 'B006'}), (t:Tag {id: 'T001'})
MERGE (b)-[:HAS_TAG]->(t);

MATCH (b:Book {id: 'B007'}), (t:Tag {id: 'T006'})
MERGE (b)-[:HAS_TAG]->(t);

MATCH (b:Book {id: 'B008'}), (t:Tag {id: 'T006'})
MERGE (b)-[:HAS_TAG]->(t);

MATCH (b:Book {id: 'B009'}), (t:Tag {id: 'T004'})
MERGE (b)-[:HAS_TAG]->(t);

MATCH (b:Book {id: 'B009'}), (t:Tag {id: 'T005'})
MERGE (b)-[:HAS_TAG]->(t);

MATCH (b:Book {id: 'B010'}), (t:Tag {id: 'T004'})
MERGE (b)-[:HAS_TAG]->(t);

MATCH (b:Book {id: 'B010'}), (t:Tag {id: 'T005'})
MERGE (b)-[:HAS_TAG]->(t);

MATCH (b:Book {id: 'B011'}), (t:Tag {id: 'T004'})
MERGE (b)-[:HAS_TAG]->(t);

MATCH (b:Book {id: 'B011'}), (t:Tag {id: 'T008'})
MERGE (b)-[:HAS_TAG]->(t);

MATCH (b:Book {id: 'B012'}), (t:Tag {id: 'T004'})
MERGE (b)-[:HAS_TAG]->(t);

MATCH (b:Book {id: 'B012'}), (t:Tag {id: 'T003'})
MERGE (b)-[:HAS_TAG]->(t);

// ==========================================
// BOOK -> BOOK
// ==========================================

MATCH (a:Book {id: 'B001'}), (b:Book {id: 'B002'})
MERGE (a)-[:SIMILAR_TO]->(b);

MATCH (a:Book {id: 'B002'}), (b:Book {id: 'B003'})
MERGE (a)-[:SIMILAR_TO]->(b);

MATCH (a:Book {id: 'B003'}), (b:Book {id: 'B004'})
MERGE (a)-[:SIMILAR_TO]->(b);

MATCH (a:Book {id: 'B005'}), (b:Book {id: 'B006'})
MERGE (a)-[:SIMILAR_TO]->(b);

MATCH (a:Book {id: 'B007'}), (b:Book {id: 'B008'})
MERGE (a)-[:SIMILAR_TO]->(b);

MATCH (a:Book {id: 'B010'}), (b:Book {id: 'B011'})
MERGE (a)-[:SIMILAR_TO]->(b);

MATCH (a:Book {id: 'B011'}), (b:Book {id: 'B012'})
MERGE (a)-[:SIMILAR_TO]->(b);