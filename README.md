# Bénévoles Rosière — version collaborative

Application web open source avec comptes personnels, rôles et base partagée.

## Droits

- **Bénévole** : son planning, le planning collectif de la journée, annuaire téléphonique et boutons WhatsApp.
- **Conseil d'administration** : mêmes vues + gestion des missions/affectations + plans de défilé.
- **Administrateur** : droits complets et attribution des rôles.

L'onglet Défilé est protégé côté interface **et côté base de données**. Chaque journée possède son propre plan. Les post-it (chars, associations, groupes de musique…) se déplacent à la souris ou au doigt, avec ordre, responsable, téléphone, couleur et notes.

## Mise en ligne

1. Créer un projet gratuit sur Supabase.
2. Exécuter `schema.sql` dans son éditeur SQL.
3. Activer l'authentification par e-mail et créer les utilisateurs.
4. Mettre l'URL et la clé publique `anon` dans `config.js` (jamais la clé `service_role`).
5. Promouvoir le premier compte en administrateur avec la requête indiquée à la fin de `schema.sql`.
6. Héberger le dossier sur GitHub Pages, Netlify, Vercel ou un serveur web.
7. Dans Paramètres, renseigner le lien d'invitation à la communauté WhatsApp.

## Important

Les numéros de téléphone étant visibles par tous les comptes bénévoles, informer les bénévoles et limiter strictement la création des comptes aux membres de l'organisation. Le logiciel n'affiche pas les contacts d'urgence dans l'annuaire public.

## Licence

MIT.
