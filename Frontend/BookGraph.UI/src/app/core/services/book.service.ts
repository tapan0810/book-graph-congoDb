import { Injectable, inject } from '@angular/core';
import { HttpClient, HttpParams } from '@angular/common/http';
import { Observable } from 'rxjs';

import { Book } from '../../models/book';
import { BookDetails } from '../../models/book-details';
import { GraphData } from '../../models/graph-data';

@Injectable({
  providedIn: 'root'
})
export class BookService {

  private readonly http = inject(HttpClient);

  private readonly apiUrl = 'http://localhost:5247/api/books';

  getBooks(): Observable<Book[]> {
    return this.http.get<Book[]>(this.apiUrl);
  }

  searchBooks(search: string): Observable<Book[]> {
    const params = new HttpParams()
      .set('search', search);

    return this.http.get<Book[]>(
      `${this.apiUrl}/search`,
      { params }
    );
  }

  getBook(id: string): Observable<BookDetails> {
    return this.http.get<BookDetails>(
      `${this.apiUrl}/${id}`
    );
  }

  getRelatedBooks(id: string): Observable<Book[]> {
    return this.http.get<Book[]>(
      `${this.apiUrl}/${id}/related`
    );
  }

  getGraph(id: string): Observable<GraphData> {
    return this.http.get<GraphData>(
      `${this.apiUrl}/${id}/graph`
    );
  }
}