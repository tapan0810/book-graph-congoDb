import {
  ChangeDetectorRef,
  Component,
  OnInit,
  inject
} from '@angular/core';

import { CommonModule } from '@angular/common';
import { ActivatedRoute, RouterLink } from '@angular/router';

import { BookService } from '../../core/services/book.service';
import { BookDetails } from '../../models/book-details';
import { Book } from '../../models/book';

@Component({
  selector: 'app-book-details',
  standalone: true,
  imports: [
    CommonModule,
    RouterLink
  ],
  templateUrl: './book-details.html',
  styleUrl: './book-details.css'
})
export class BookDetailsComponent implements OnInit {

  private readonly route = inject(ActivatedRoute);
  private readonly bookService = inject(BookService);
  private readonly cdr = inject(ChangeDetectorRef);

  bookDetails: BookDetails | null = null;
  relatedBooks: Book[] = [];

  loading = false;
  errorMessage = '';

  ngOnInit(): void {
    this.loadBookDetails();
  }

  // ============================================================
  // LOAD BOOK DETAILS
  // ============================================================

  loadBookDetails(): void {

    const bookId = this.route.snapshot.paramMap.get('id');

    console.log('Book ID:', bookId);

    if (!bookId) {
      this.errorMessage = 'Book ID is missing.';
      this.loading = false;

      this.cdr.detectChanges();

      return;
    }

    this.loading = true;
    this.errorMessage = '';

    // ----------------------------------------------------------
    // GET BOOK DETAILS
    // ----------------------------------------------------------

    this.bookService.getBook(bookId).subscribe({

      next: (details: BookDetails | null) => {

        console.log('Book details received:', details);

        this.bookDetails = details;
        this.loading = false;

        console.log('Loading:', this.loading);

        // IMPORTANT
        this.cdr.detectChanges();
      },

      error: (error: any) => {

        console.error('Error loading book details:', error);

        this.errorMessage = 'Unable to load book details.';
        this.loading = false;

        this.cdr.detectChanges();
      }

    });

    // ----------------------------------------------------------
    // GET RELATED BOOKS
    // ----------------------------------------------------------

    this.bookService.getRelatedBooks(bookId).subscribe({

      next: (books) => {

        console.log('Related books received:', books);

        this.relatedBooks = books;

        this.cdr.detectChanges();
      },

      error: (error) => {

        console.error('Error loading related books:', error);

        this.relatedBooks = [];

        this.cdr.detectChanges();
      }

    });
  }
}