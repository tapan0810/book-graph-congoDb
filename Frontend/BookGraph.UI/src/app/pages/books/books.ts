import { ChangeDetectorRef, Component, OnInit, inject } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { RouterLink } from '@angular/router';

import { BookService } from '../../core/services/book.service';
import { Book } from '../../models/book';

@Component({
  selector: 'app-books',
  standalone: true,
  imports: [
    CommonModule,
    FormsModule,
    RouterLink
  ],
  templateUrl: './books.html',
  styleUrl: './books.css'
})
export class Books implements OnInit {

  private readonly bookService = inject(BookService);
  private readonly cdr = inject(ChangeDetectorRef);

  books: Book[] = [];
  searchTerm = '';

  loading = false;
  errorMessage = '';

  ngOnInit(): void {
    this.loadBooks();
  }

  // ============================================================
  // LOAD ALL BOOKS
  // ============================================================

  loadBooks(): void {
    this.loading = true;
    this.errorMessage = '';

    this.bookService.getBooks().subscribe({

      next: (books) => {
        this.books = books;
        this.loading = false;

        // Force the UI to update immediately
        this.cdr.detectChanges();
      },

      error: (error) => {
        console.error('Unable to load books:', error);

        this.errorMessage = 'Unable to load books.';
        this.loading = false;

        // Force the UI to update immediately
        this.cdr.detectChanges();
      }

    });
  }

  // ============================================================
  // SEARCH BOOKS
  // ============================================================

  searchBooks(): void {

    const search = this.searchTerm.trim();

    // If search box is empty, load all books
    if (!search) {
      this.loadBooks();
      return;
    }

    this.loading = true;
    this.errorMessage = '';

    this.bookService.searchBooks(search).subscribe({

      next: (books) => {
        this.books = books;
        this.loading = false;

        // Force the UI to update immediately
        this.cdr.detectChanges();
      },

      error: (error) => {
        console.error('Unable to search books:', error);

        this.errorMessage = 'Unable to search books.';
        this.loading = false;

        // Force the UI to update immediately
        this.cdr.detectChanges();
      }

    });
  }

  // ============================================================
  // CLEAR SEARCH
  // ============================================================

  clearSearch(): void {
    this.searchTerm = '';
    this.loadBooks();
  }
}