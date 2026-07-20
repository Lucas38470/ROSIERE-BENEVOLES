# Bénévoles Rosière — version collaborative

Application web open source avec comptes personnels, rôles et base partagée.

## Droits

- **Bénévole** : son planning, le planning collectif de la journée, annuaire téléphonique et boutons WhatsApp.
- **Conseil d'administration** : mêmes vues + gestion des missions/affectations + plans de défilé.
- **Administrateur** : droits complets et attribution des rôles.

## Version 2

- Planning général sous forme de Gantt, filtrable par journée et événement, avec une ligne par ressource bénévole.
- Modification et suppression des missions et affectations.
- Modification et suppression des défilés et de chaque post-it.
- Organigramme hiérarchique des responsables, visible par les bénévoles et modifiable par le CA/les administrateurs.

Pour mettre à jour une installation existante, exécuter d'abord `migration_v2.sql` dans **Supabase > SQL Editor**, puis remplacer les fichiers du site sur GitHub. Le script de migration conserve toutes les données existantes.

## Version 3

- Onglet **Musiques** : groupes accueillis, nombre de musiciens, responsable du groupe, téléphone, référent musique du Comité, hébergement, séjour, régimes alimentaires et notes.
- Liaison d'un groupe musical avec un post-it du défilé. Le responsable, le téléphone et l'effectif sont repris sur le plan.
- Onglet **Restauration** : services par date/type/horaire, lignes de repas par groupe, total automatique et numéro de table.
- Version téléphone responsive et installable : menu inférieur, tableaux transformés en cartes et raccourci sur l'écran d'accueil.

### Mise à jour d'une V2 existante

1. Exécuter `migration_v3.sql` dans **Supabase > SQL Editor**.
2. Sur GitHub, remplacer `index.html` et ajouter `manifest.webmanifest`, `icon.svg` et `sw.js`.
3. Ne pas remplacer le `config.js` déjà configuré.
4. Attendre la publication GitHub Pages puis forcer l'actualisation.

### Installation sur téléphone

- Android/Chrome : ouvrir le site puis utiliser le bouton **Installer** ou le menu du navigateur > **Installer l'application**.
- iPhone/Safari : bouton **Partager** > **Sur l'écran d'accueil** > **Ajouter**.

La connexion Internet reste nécessaire pour charger et enregistrer les données Supabase.

## Identité visuelle officielle

Le fichier `logo-rosiere.png` est utilisé sur l'écran de connexion, dans la navigation et sur la version téléphone. Les icônes installables `icon-192.png` et `icon-512.png` reprennent également ce logotype. Lors d'une mise à jour GitHub, envoyer ces trois fichiers avec `index.html`, `manifest.webmanifest` et `sw.js`.

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
