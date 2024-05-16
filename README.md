# Projet d'évaluation Backend

## Sommaire
1. [Introduction](#1-introduction)
2. [Modèles](#2-modèles)
    - [Utilisateur (User)](#utilisateur-user)
    - [Livre (Book)](#livre-book)
    - [Emprunt (Borrow)](#emprunt-borrow)
3. [Routes et pages](#3-routes-et-pages)
4. [Bonus](#4-bonus)

## 1. Introduction

L'application que vous devez développer est une application de gestion d'une bibliothèque.
Vous devez gérer des comptes utilisateurs, des livres et les emprunts de ceux-ci.

Vous trouverez ci-après l'ensemble des modèles et pages qui sont attendues. Les relations et associations ne sont pas données.

## 2. Modèles

### Utilisateur (User)

Compte utilisateur qui va pouvoir emprunter un ou plusieurs livres.

Colonnes (minimum) :
```yml
- email: string
- password_digest: string # has_secure_password
```

### Livre (Book)

Resource principale de l'application. Peut être emprunté par un utilisateur. Vous pouvez vous aider de `rails generate scaffold` pour générer ce modèle. Faites attention cependant à ne garder que ce qui est nécessaire pour l'application.

Si vous souhaitez remplir votre base de donnée avec des livres, vous pouvez utiliser le fichier de migration donné sur Pepal. Il faut bien faire attention à ce que le modèle soit bien nommé `Book` et qu'il y ait les bonnes colonnes.

Colonnes (minimum) :
```yml
- title: string
- author: string
- publish_year: integer
```

### Emprunt (Borrow)

Gestion d'un emprunt d'un livre par un utilisateur. Un emprunt a une date de début et une date de fin (ou non). Si l'emprunt n'a pas de date de fin, cela veut dire que l'emprunt est toujours en cours et qu'aucun autre emprunt ne peut être effectué.

> /!\ Il faut bien faire en sorte de ne pas pouvoir emprunter un livre actuellement emprunté.

Colonnes (minimum) :
```yml
- user: references
- book: references
- started_at: datetime
- ended_at: datetime | null
```

## 3. Routes et pages

Routes liées au User :
```bash
GET /login      # page de connexion
POST /login     # connexion
DELETE /logout  # déconnexion
GET /register   # page de création de compte
POST /register  # création de compte
```

Routes liées au Book :
```bash
GET /books      # liste des livres
GET /books/:id  # page de détail d'un livre
                # avec bouton pour l'emprunter

# optionnels (scaffold)
GET /books/new      # page d'ajout d'un livre
POST /books         # ajout d'un livre
GET /books/:id/edit # page d'édition d'un livre
PATCH /books/:id    # édition d'un livre
DELETE /books/:id   # suppression d'un livre
```

Sur la page d'un livre, il y a la possibilité de l'emprunter (si cela est possible). Si l'utilisateur connecté a déjà emprunté le livre, il y a un bouton pour finir l'emprunt à la place.

Routes liées au Borrow :
```bash
POST /borrows         # création d'un emprunt
DELETE /borrows/:id   # fin d'un emprunt
                      # (ne supprime pas l'emprunt)
```

## 4. Bonus

- Ajout de tests
- Ajout d'une barre de recherche dans l'index des livres
- Liste des livres actuellement empruntés par l'utilisateur
- Historique des emprunts de utilisateur connecté