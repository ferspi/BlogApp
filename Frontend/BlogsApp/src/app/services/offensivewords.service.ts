import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { Content } from '../models/content.model';
import { environment } from '../../environments/environment';

@Injectable({
  providedIn: 'root',
})
export class OffensivewordsService {
  private apiUrl = environment.API_HOST_URL + '/api/offensive-words';
  constructor(private http: HttpClient) {}

  getOfensiveWords(): Observable<string[]> {
    return this.http.get<string[]>(this.apiUrl);
  }

  postOffensiveWord(Aword: string): Observable<any> {
    const requestBody = { word: Aword };
    return this.http.post<any>(this.apiUrl, requestBody);
  }

  deleteOffensiveWord(word: string): Observable<any> {
    const requestBody = { word };
    return this.http.delete<any>(this.apiUrl, { body: requestBody });
  }

  getContentToRevision(): Observable<Content[]> {
    return this.http.get<Content[]>(this.apiUrl + '/content');
  }

  notificationDismissed(): Observable<any> {
    return this.http.put<any>(this.apiUrl + '/notification-dismisser', null);
  }

  notificationViewer(): Observable<any> {
    return this.http.get<any>(this.apiUrl + '/notification-viewer');
  }
}
