import { Routes } from '@angular/router';
export const routes: Routes = [
  {
    path: '',
    redirectTo: 'books',
    pathMatch: 'full'
  },
  {
    path: 'books',
    loadComponent: () =>
      import('./pages/books/books')
        .then(m => m.Books)
  },
 {
  path: 'books/:id',
  loadComponent: () =>
    import('./pages/book-details/book-details')
      .then(m => m.BookDetailsComponent)
},
  {
    path: '**',
    redirectTo: 'books'
  }
];