import { HttpClient, HttpErrorResponse, HttpParams } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable, catchError, tap, throwError } from 'rxjs';
import { Article } from '../models/article.model';
import { User, UserRanking, UserComplete } from '../models/user.model';
import { environment } from '../../environments/environment';
@Injectable({
  providedIn: 'root'
})
export class UserService {
  private apiUrl = environment.API_HOST_URL + '/api/users';
  constructor(private http: HttpClient) { }

  getArticlesByUser(userId: number): Observable<Article[]> {  
    const url = `${this.apiUrl}/${userId}/articles`;
    return this.http.get<Article[]>(url).pipe(
      tap((articles: Article[]) => {
      }),
      catchError((error: HttpErrorResponse) => {
        if (error.status === 404) {
          throwError(() => new Error('Artículos no encontrados'));
        } else {
          throwError(() => new Error('Ha ocurrido un error'));
        }
    
        return throwError(() => error);
      })
    );
  }

  public getRanking(dateFrom: string, dateTo: string, top: number, offensiveWords: boolean = false): Observable<UserRanking[]> {
    const url = `${this.apiUrl}/ranking`;
  
    const params = new HttpParams()
      .set('dateFrom', dateFrom)
      .set('dateTo', dateTo)
      .set('top', top.toString())
      .set('withOffensiveWords', offensiveWords.toString());
  
    return this.http.get<UserRanking[]>(url, { params });
  }

  public postUser(user: User): Observable<User> {
    return this.http.post<User>(this.apiUrl, user);
  }

  public updateUser(user: User, id: number): Observable<User> {
    const url = `${this.apiUrl}/${id}`;
    return this.http.patch<User>(url, user);
  }

  public deleteUser(userId: number): Observable<any> {
    const url = `${this.apiUrl}/${userId}`;
    return this.http.delete<any>(`${url}`);
  }

  public getUserById(userId: number): Observable<UserComplete> {
    const url = `${this.apiUrl}/${userId}`;
    return this.http.get<UserComplete>(url);
  }

  public getUsers(): Observable<UserComplete[]> {
    return this.http.get<UserComplete[]>(this.apiUrl);
  }
}
