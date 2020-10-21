# Rare Database

## ERD

https://dbdiagram.io/d/5f885a013a78976d7b77cb74

## SQL Script

```sql
CREATE TABLE "AccountTypes" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "label" varchar
);

CREATE TABLE "Users" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "first_name" varchar,
  "last_name" varchar,
  "email" varchar,
  "bio" varchar,
  "username" varchar,
  "profile_image_url" varchar,
  "created_on" date,
  "active" bit,
  "account_type_id" INTEGER,
  FOREIGN KEY(`account_type_id`) REFERENCES `AccountTypes`(`id`)
);

CREATE TABLE "DemotionQueue" (
  "action" varchar,
  "admin_id" INTEGER,
  "approver_one_id" INTEGER,
  FOREIGN KEY(`admin_id`) REFERENCES `Users`(`id`),
  FOREIGN KEY(`approver_one_id`) REFERENCES `Users`(`id`),
  PRIMARY KEY (action, admin_id, approver_one_id)
);


CREATE TABLE "Subscriptions" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "follower_id" INTEGER,
  "author_id" INTEGER,
  "created_on" date,
  FOREIGN KEY(`follower_id`) REFERENCES `Users`(`id`),
  FOREIGN KEY(`author_id`) REFERENCES `Users`(`id`)
);

CREATE TABLE "Posts" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "user_id" INTEGER,
  "category_id" INTEGER,
  "title" varchar,
  "publication_date" date,
  "image_url" varchar,
  "content" varchar,
  "approved" bit
);

CREATE TABLE "Comments" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "post_id" INTEGER,
  "author_id" INTEGER,
  "content" varchar,
  FOREIGN KEY(`post_id`) REFERENCES `Posts`(`id`),
  FOREIGN KEY(`author_id`) REFERENCES `Users`(`id`)
);

CREATE TABLE "Reactions" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "label" varchar,
  "image_url" varchar
);

CREATE TABLE "PostReactions" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "user_id" INTEGER,
  "reaction_id" INTEGER,
  "post_id" INTEGER,
  FOREIGN KEY(`user_id`) REFERENCES `Users`(`id`),
  FOREIGN KEY(`reaction_id`) REFERENCES `Reactions`(`id`),
  FOREIGN KEY(`post_id`) REFERENCES `Posts`(`id`)
);

CREATE TABLE "Tags" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "label" varchar
);

CREATE TABLE "PostTags" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "post_id" INTEGER,
  "tag_id" INTEGER,
  FOREIGN KEY(`post_id`) REFERENCES `Posts`(`id`),
  FOREIGN KEY(`tag_id`) REFERENCES `Tags`(`id`)
);

CREATE TABLE "Categories" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "label" varchar
);

INSERT INTO Categories ('label') VALUES ('News');
INSERT INTO Categories ('label') VALUES ('Opinion');
INSERT INTO Categories ('label') VALUES ('How-To');
INSERT INTO Categories ('label') VALUES ('Editorial');
INSERT INTO Categories ('label') VALUES ("Here's something dumb");

INSERT INTO Tags ('label') VALUES ('JavaScript');
INSERT INTO Tags ('label') VALUES ('React');
INSERT INTO Tags ('label') VALUES ('Angular');
INSERT INTO Tags ('label') VALUES ('Vue');
INSERT INTO Tags ('label') VALUES ('Node');
INSERT INTO Tags ('label') VALUES ('C#');
INSERT INTO Tags ('label') VALUES ('.NET');
INSERT INTO Tags ('label') VALUES ('Python');
INSERT INTO Tags ('label') VALUES ('Data Science');
INSERT INTO Tags ('label') VALUES ('Django');
INSERT INTO Tags ('label') VALUES ('Flask');
INSERT INTO Tags ('label') VALUES ('Open Source');
INSERT INTO Tags ('label') VALUES ('Check this out!');
INSERT INTO Tags ('label') VALUES ('Beginners');
INSERT INTO Tags ('label') VALUES ('Weird');
INSERT INTO Tags ('label') VALUES ('Ugh');
INSERT INTO Tags ('label') VALUES ('Cool!');
INSERT INTO Tags ('label') VALUES ('Why tho?');
INSERT INTO Tags ('label') VALUES ('C#');
INSERT INTO Tags ('label') VALUES ('.NET');
INSERT INTO Tags ('label') VALUES ('Rust');
INSERT INTO Tags ('label') VALUES ('Ruby');
INSERT INTO Tags ('label') VALUES ('Rails');
INSERT INTO Tags ('label') VALUES ('Go');
INSERT INTO Tags ('label') VALUES ('C++');
INSERT INTO Tags ('label') VALUES ('History Lesson');

INSERT INTO Reactions ('label', 'image_url') VALUES ('happy', 'https://pngtree.com/so/happy');
INSERT INTO Reactions ('label', 'image_url') VALUES ('heart', 'https://lh3.googleusercontent.com/proxy/BlwtWdiO1ucoroiKKuJN5CpiAUFA4tdHYRT_yXzxWLpNVTJS7UEVp1JV-lYshjAPeS7wd1pqXk6mpxY6rrSAPXD5NbBoE9hTf-1PpzofQbzNyH__1miggtO2IQKktovnAyPzjCW6T9mQG6JvgdHklZUaMd-YnIxeBPuP1lBw2E7fp9d6AR68');


INSERT INTO AccountTypes ('label') VALUES ('Admin');
INSERT INTO AccountTypes ('label') VALUES ('Author');
```

## Ticket Order for Rare Project

![](./rare-ticket-order.png)
