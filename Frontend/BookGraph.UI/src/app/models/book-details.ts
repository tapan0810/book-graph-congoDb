import { Author } from './author';
import { Book } from './book';
import { Genre } from './genre';
import { Tag } from './tag';

export interface BookDetails {
  book: Book;
  author: Author | null;
  genre: Genre | null;
  tags: Tag[];
}