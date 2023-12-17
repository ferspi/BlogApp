export class Article {
    id?: number;
    name: string;
    username?: string;
    body: string;
    private: boolean;
    template: number;
    image?: string;
    userId?: number;
    state?: number

    constructor(name: string, body: string, isPrivate: boolean, template: number, image: string) {
        this.id = 0;
        this.name = name;
        this.username = 'username';
        this.body = body;
        this.private = isPrivate;
        this.template = template;
        this.image = image;
        this.state = 0;
    }
  }